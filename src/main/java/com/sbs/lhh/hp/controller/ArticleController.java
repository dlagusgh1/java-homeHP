package com.sbs.lhh.hp.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.dto.CovidData;
import com.sbs.lhh.hp.dto.Member;
import com.sbs.lhh.hp.dto.Organ;
import com.sbs.lhh.hp.dto.ResultData;
import com.sbs.lhh.hp.service.ArticleService;
import com.sbs.lhh.hp.service.CrawlingService;
import com.sbs.lhh.hp.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private CrawlingService crawlingService;
	
	// 카카오맵 (기본 ajax 테스트 중)
	@RequestMapping("/usr/article/getForPrintKakaoMapList")
	@ResponseBody
	public ResultData getForPrintKakaoMapList(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		Map<String, Object> rsDataBody = new HashMap<>();

		List<Organ> organes = articleService.getOrgan();
		rsDataBody.put("organes", organes);

		return new ResultData("S-1", String.format("%d개의 지도정보를 불러왔습니다.", organes.size()), rsDataBody);
	}

	// 카카오맵(기본-병원/약국)
	@RequestMapping("/usr/article/kakaoMap")
	public String kakaoMap(Model model) {

		List<AdCateItem> adCateItems = articleService.getAdCateItem();

		model.addAttribute("adCateItems", adCateItems);

		int organ_ALLCount = articleService.organsCount();
		int organ_HPCount = articleService.organCount(1);
		int organ_PMCount = articleService.organCount(2);

		model.addAttribute("organ_ALLCount", organ_ALLCount);
		model.addAttribute("organ_HPCount", organ_HPCount);
		model.addAttribute("organ_PMCount", organ_PMCount);

		List<Organ> organes = articleService.getOrgan();

		model.addAttribute("organes", organes);

		return "article/kakaoMap";
	}

	// 카카오맵(전체)
	@RequestMapping("/usr/article/kakaoMap_All")
	public String kakaoMap_All(Model model) {

		List<AdCateItem> adCateItems = articleService.getAdCateItem();

		model.addAttribute("adCateItems", adCateItems);

		int organ_ALLCount = articleService.organsCount();
		int organ_HPCount = articleService.organCount(1);
		int organ_PMCount = articleService.organCount(2);

		model.addAttribute("organ_ALLCount", organ_ALLCount);
		model.addAttribute("organ_HPCount", organ_HPCount);
		model.addAttribute("organ_PMCount", organ_PMCount);

		List<Organ> organes = articleService.getOrgan();

		model.addAttribute("organes", organes);

		return "article/kakaoMap_All";
	}

	// 카카오맵(병원)
	@RequestMapping("/usr/article/kakaoMap_HP")
	public String kakaoMap_HP(Model model) {

		List<AdCateItem> adCateItems = articleService.getAdCateItem();

		model.addAttribute("adCateItems", adCateItems);

		int organ_ALLCount = articleService.organsCount();
		int organ_HPCount = articleService.organCount(1);
		int organ_PMCount = articleService.organCount(2);

		model.addAttribute("organ_ALLCount", organ_ALLCount);
		model.addAttribute("organ_HPCount", organ_HPCount);
		model.addAttribute("organ_PMCount", organ_PMCount);

		List<Organ> organes = articleService.getOrgan();

		model.addAttribute("organes", organes);

		return "article/kakaoMap_HP";
	}

	// 카카오맵(약국)
	@RequestMapping("/usr/article/kakaoMap_PM")
	public String kakaoMap_PM(Model model) {

		List<AdCateItem> adCateItems = articleService.getAdCateItem();

		model.addAttribute("adCateItems", adCateItems);

		int organ_ALLCount = articleService.organsCount();
		int organ_HPCount = articleService.organCount(1);
		int organ_PMCount = articleService.organCount(2);

		model.addAttribute("organ_ALLCount", organ_ALLCount);
		model.addAttribute("organ_HPCount", organ_HPCount);
		model.addAttribute("organ_PMCount", organ_PMCount);

		List<Organ> organes = articleService.getOrgan();

		model.addAttribute("organes", organes);

		return "article/kakaoMap_PM";
	}
	
	// COVID-19 현황 가져오기(크롤링)
	@RequestMapping("/adm/article/getCovid19Status")
	public String getCovid19Status(Model model) {
		
		List<CovidData> covidDatas = articleService.getCovidData();
		
		List<CovidData> covidDataList;
		
		if ( covidDatas.isEmpty() ) {
			try {
				covidDataList = crawlingService.getCovidDatas();

				for (CovidData data : covidDataList) {
					articleService.setCovidData(data);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}	
		} else {
			try {
				covidDataList = crawlingService.getCovidDatas();

				for (CovidData data : covidDataList) {
					articleService.setCovidDataUpdate(data);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		String redirectUri = "/usr/article/covid19Status";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "covid-19 데이터를 갱신했습니다.");

		return "common/redirect";
	}
	
	// COVID-19 현황
	@RequestMapping("/usr/article/covid19Status")
	public String covid19(Model model) {

		List<CovidData> covidDataList = articleService.getCovidData();
		
		model.addAttribute("covidDataList", covidDataList);		
		
		return "article/covid19Status";
	}
	
	// 관리자 메뉴 - 게시물 관리(게시물 숨기기)ajax
	@RequestMapping("/adm/article/doHideArticleAjax")
	@ResponseBody
	public ResultData doHideArticleAjax(int id, HttpServletRequest request) {
		
		articleService.hideArticle(id);

		return new ResultData("S-1", String.format("%d번 게시물을 숨겼습니다.", id));
	}
	
	// 관리자 메뉴 - 게시물 관리(게시물 보이기(노출))ajax
	@RequestMapping("/adm/article/doShowArticleAjax")
	@ResponseBody
	public ResultData doShowArticleAjax(int id, HttpServletRequest request) {
		
		articleService.showArticle(id);

		return new ResultData("S-1", String.format("%d번 게시물을 노출시켰습니다.", id));
	}
	
	// 관리자 메뉴 - 게시물 관리
	@RequestMapping("/adm/article/{boardCode}articleAdministrate")
	public String articleManage(Model model) {
		Board board = articleService.getBoardByCode("free");
		model.addAttribute("board", board);
		
		List<Article> articles = articleService.getForPrintVisibleArticles();

		model.addAttribute("articles", articles);
		
		return "article/articleAdministrate";
	}
	
	// 기관 등록 시 카카오맵 검색 기능
	@RequestMapping("/adm/article/searchMap")
	public String searchMap(Model model) {

		return "article/searchMap";
	}

	// 응급처치
	@RequestMapping("/usr/article/firstAid")
	public String firstAid(Model model) {

		return "article/firstAid";
	}
	
	// 기관(병원/약국) 정보 수정요청 폼
	@RequestMapping("/usr/article/organModify")
	public String organModify(Model model) {

		List<CateItem> cateItems = articleService.getCateItem();

		model.addAttribute("cateItems", cateItems);

		return "article/organModify";
	}
	
	// 기관(병원/약국) 정보 수정 기능
	@RequestMapping("/usr/article/doOrganModify")
	public String doOrganModify(@RequestParam Map<String, Object> param, Model model, String redirectUri) {

		articleService.organModify(param);
		
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "수정 요청이 완료되었습니다.\\n결과는 등록된 이메일 주소로 회신됩니다.\\n감사합니다.");

		return "common/redirect";
	}

	// 기관(병원/약국) 추가 폼
	@RequestMapping("/adm/article/organWrite")
	public String organWrite(Model model) {

		List<CateItem> cateItems = articleService.getCateItem();

		model.addAttribute("cateItems", cateItems);

		return "article/organWrite";
	}

	// 기관(병원/약국) 추가 기능
	@RequestMapping("/adm/article/doOrganWrite")
	public String doOrganWrite(@RequestParam Map<String, Object> param, Model model, String redirectUri,
			HttpServletRequest request) {

		param.put("memberId", request.getAttribute("loginedMemberId"));

		articleService.organWrite(param);

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "정보 등록이 완료되었습니다.");

		return "common/redirect";
	}

	// 게시물 리스트(자유/공지)
	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		List<Article> articles = articleService.getForPrintArticles();

		model.addAttribute("articles", articles);

		return "article/list";
	}

	// 게시물 상세보기
	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req,
			@PathVariable("boardCode") String boardCode, String listUrl) {
		if (listUrl == null) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/detail";
	}

	// 게시물 작성 폼
	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, Model model, String listUrl) {
		if (listUrl == null) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		List<Board> boards = articleService.getBoards();

		model.addAttribute("boards", boards);

		return "article/write";
	}

	// 게시물 작성 기능
	@RequestMapping("/usr/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		newParam.put("boardId", board.getId());
		newParam.put("memberId", loginedMemberId);
		int newArticleId = articleService.write(newParam);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}

	// 게시물 수정 폼
	@RequestMapping("/usr/article/{boardCode}-modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req,
			@PathVariable("boardCode") String boardCode, String listUrl) {
		model.addAttribute("listUrl", listUrl);

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/modify";
	}

	// 게시물 수정 기능
	@RequestMapping("/usr/article/{boardCode}-doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, int id,
			@PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		ResultData checkActorCanModifyResultData = articleService.checkActorCanModify(loginedMember, id);

		if (checkActorCanModifyResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkActorCanModifyResultData.getMsg());

			return "common/redirect";
		}

		articleService.modify(newParam);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	// 게시물 삭제 기능
	@RequestMapping("/usr/article/{boardCode}-doDelete")
	public String doDelete(@RequestParam Map<String, Object> param, HttpServletRequest req, int id,
			@PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		ResultData checkActorCanDeleteResultData = articleService.checkActorCanDelete(loginedMember, id);

		if (checkActorCanDeleteResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkActorCanDeleteResultData.getMsg());

			return "common/redirect";
		}

		articleService.delete(newParam);

		String redirectUri = boardCode + "-list";

		return "redirect:" + redirectUri;
	}

}
