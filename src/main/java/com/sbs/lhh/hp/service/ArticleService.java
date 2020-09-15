package com.sbs.lhh.hp.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.lhh.hp.dao.ArticleDao;
import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.dto.CovidData;
import com.sbs.lhh.hp.dto.File;
import com.sbs.lhh.hp.dto.Member;
import com.sbs.lhh.hp.dto.Organ;
import com.sbs.lhh.hp.dto.ResultData;
import com.sbs.lhh.hp.util.Util;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private FileService fileService;
	@Autowired
	private MailService mailService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	// 병원/약국 카테고리 가져오기
	public List<CateItem> getCateItem() {
		return articleDao.getCateItem();
	}

	// 기관 등록
	public void organWrite(Map<String, Object> param) {
		articleDao.organWrite(param);
	}
	
	// 기관 정보 수정 요청
	public void organModify(Map<String, Object> param) {
		
		String organNumber = (String) param.get("organNumber");
		String organName = (String) param.get("organName");
		String organEmail = (String) param.get("organEmail");
		String modifyRequests = (String) param.get("modifyRequests");

		String mailTitle = String.format("[%s] 정보 수정 요청이 들어왔습니다.", siteName);
		
		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>정보 수정 요청</h1>");
		mailBodySb.append(String.format("<div><img src=\"https://user-images.githubusercontent.com/60770834/91107964-96185b80-e6b1-11ea-8d76-d3b5952e0add.png\" style=\"height:150px; width:300px; background-color: #4BAF4B; margin-bottom: 20px; padding:10px; border-radius:20px; \"/></div>"));
		mailBodySb.append(String.format("<p>기관 구분 : %s<br><br>기관명 : %s<br><br> 기관 이메일 주소 : %s<br><br>수정 요청사항 : %s</p>", organNumber, organName, organEmail, modifyRequests));
		
		mailService.send("dlagusgh1@gmail.com", mailTitle, mailBodySb.toString());
	}

	// 행정주소 카테고리 가져오기
	public List<AdCateItem> getAdCateItem() {
		return articleDao.getAdCateItem();
	}
	
	// 기관 정보 가져오기
	public List<Organ> getOrgan() {
		return articleDao.getOrgan();
	}

	// board 목록 가져오기
	public List<Board> getBoards() {
		return articleDao.getBoards();
	}
	
	// 코드에 맞는 게시판 가져오기(공지/자유)
	public Board getBoardByCode(String boardCode) {
		return articleDao.getBoardByCode(boardCode);
	}

	// 게시물 리스트
	public List<Article> getForPrintArticles(String boardCode) {
		List<Article> articles = articleDao.getForPrintArticles(boardCode);

		return articles;
	}
	
	// 게시물 리스트(관리자 메뉴 내 게시물 관리에 이용)
	public List<Article> getForPrintVisibleArticles() {
		List<Article> articles = articleDao.getForPrintVisibleArticles();

		return articles;
	}
	
	// 게시물 상세보기
	public Article getForPrintArticleById(Member actor, int id) {
		Article article = articleDao.getForPrintArticleById(id);
		
		// 수정, 삭제 가능/불가능 여부에 따라 상세보기 시 삭제, 수정 표시
		updateForPrintInfo(actor, article);
		
		List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");

		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);
		
		return article;
	}

	// 액터가 게시물 수정 가능한지 알려준다.
	public ResultData checkActorCanModify(Member actor, int id) {
		boolean actorCanModify = actorCanModify(actor, id);

		if (actorCanModify) {
			return new ResultData("S-1", "수정 가능합니다.", "id", id);
		}

		return new ResultData("F-1", "권한이 없습니다.", "id", id);
	}
	
	// 액터가 게시물 삭제 가능한지 알려준다.
	public ResultData checkActorCanDelete(Member actor, int id) {
		boolean actorCanDelete = actorCanDelete(actor, id);

		if (actorCanDelete) {
			return new ResultData("S-1", "삭제 가능합니다.", "id", id);
		}

		return new ResultData("F-1", "권한이 없습니다.", "id", id);
	}
	
	public boolean actorCanModify(Member actor, int id) {
		Article article = articleDao.getArticleById(id);

		return actorCanModify(actor, article);
	}
	
	public boolean actorCanDelete(Member actor, int id) {
		Article article = articleDao.getArticleById(id);

		return actorCanDelete(actor, article);
	}

	public boolean actorCanModify(Member actor, Article article) {
		return actor != null && actor.getId() == article.getMemberId() ? true : false;
	}
	
	public boolean actorCanDelete(Member actor, Article article) {
		return actorCanModify(actor, article);
	}
	
	private void updateForPrintInfo(Member actor, Article article) {
		Util.putExtraVal(article, "actorCanDelete", actorCanDelete(actor, article));
		Util.putExtraVal(article, "actorCanModify", actorCanModify(actor, article));
	}
	

	// 게시물 작성
	public int write(Map<String, Object> param) {
		articleDao.write(param);
		
		int id = Util.getAsInt(param.get("id"));
		
		String fileIdsStr = (String) param.get("fileIdsStr");
		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.startsWith(",")) {
				fileIdsStr = fileIdsStr.substring(1);
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.equals(",")) {
				fileIdsStr = "";
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}
		
		return id;
	}

	// 게시물 수정 기능
	public void modify(Map<String, Object> param) {
		articleDao.modify(param);

		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.startsWith(",")) {
				fileIdsStr = fileIdsStr.substring(1);
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}
	}

	// 게시물 삭제 기능
	public void delete(Map<String, Object> param) {
		articleDao.delete(param);
	}

	// organ 전체 수 출력
	public int organsCount() {
		return articleDao.organsCount();
	}

	// 특정 organ 수 출력
	public int organCount(int organNumber) {
		return articleDao.organCount(organNumber);
	}

	// 게시물 숨기기 기능
	public void hideArticle(int id) {
		articleDao.hideArticle(id);
	}

	// 게시물 보이기 기능
	public void showArticle(int id) {
		articleDao.showArticle(id);
	}

	// covid-19 데이터 가져와서 저장하는 기능(신규)
	public void setCovidData(CovidData data) {
		articleDao.setCovidData(data);
	}
	
	// covid-19 데이터 가져와서 저장하는 기능(기존데이터 있는 경우엔 수정)
	public void setCovidDataUpdate(CovidData data) {
		articleDao.setCovidDataUpdate(data);
	}

	// covid-19 데이터 가져오기
	public List<CovidData> getCovidData() {
		return articleDao.getCovidData();
	}

	// 조회수 기능
	public void increaseArticleHit(int id) {
		articleDao.increaseArticleHit(id);
	}


	// 추천 가능한지 확인 기능
	public Map<String, Object> getArticleLikeAvailable(int id, int loginedMemberId) {
		Article article = articleDao.getArticleById(id);

		Map<String, Object> rs = new HashMap<>();

		if (article.getMemberId() == loginedMemberId) {
			rs.put("resultCode", "F-1");
			rs.put("msg", "본인은 추천 할 수 없습니다.");

			return rs;
		}

		int likePoint = articleDao.getLikePointByMemberId(id, loginedMemberId);

		if (likePoint > 0) {
			rs.put("resultCode", "F-2");
			rs.put("msg", "이미 추천 하셨습니다.");

			return rs;
		}

		rs.put("resultCode", "S-1");
		rs.put("msg", "가능합니다.");

		return rs;
	}

	// 추천 기능
	public Map<String, Object> likeArticle(int id, int loginedMemberId) {
		articleDao.likeArticle(id, loginedMemberId);

		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물을 추천하였습니다.", id));

		return rs;
	}
	
}
