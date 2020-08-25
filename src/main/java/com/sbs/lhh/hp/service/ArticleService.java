package com.sbs.lhh.hp.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lhh.hp.dao.ArticleDao;
import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.dto.CateItem;
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

	// 병원/약국 카테고리 가져오기
	public List<CateItem> getCateItem() {
		return articleDao.getCateItem();
	}

	// 기관 등록
	public void organWrite(Map<String, Object> param) {
		articleDao.organWrite(param);
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
	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();

		return articles;
	}
	
	// 게시물 리스트(자유) 출력제한
	public List<Article> getForPrintBoarCodeArticles(String boardCode, int limit) {
		List<Article> articles = articleDao.getForPrintBoarCodeArticles(boardCode, limit);

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
			return new ResultData("S-1", "가능합니다.", "id", id);
		}

		return new ResultData("F-1", "권한이 없습니다.", "id", id);
	}
	
	// 액터가 게시물 삭제 가능한지 알려준다.
	public ResultData checkActorCanDelete(Member actor, int id) {
		boolean actorCanDelete = actorCanDelete(actor, id);

		if (actorCanDelete) {
			return new ResultData("S-1", "가능합니다.", "id", id);
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
		System.out.println("fileIdsStr" + fileIdsStr);
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
	
}
