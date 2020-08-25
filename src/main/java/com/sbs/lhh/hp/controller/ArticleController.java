package com.sbs.lhh.hp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.dto.Member;
import com.sbs.lhh.hp.dto.Organ;
import com.sbs.lhh.hp.dto.ResultData;
import com.sbs.lhh.hp.service.ArticleService;
import com.sbs.lhh.hp.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	// 카카오맵
	@RequestMapping("/article/kakaoMap")
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
	
	// 카카오맵
	@RequestMapping("/article/kakaoMap_All")
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
	
	// 카카오맵
	@RequestMapping("/article/kakaoMap_HP")
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
	
	// 카카오맵
	@RequestMapping("/article/kakaoMap_PM")
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
	
	// 기관 등록 시 카카오맵 검색 기능
	@RequestMapping("/article/searchMap")
	public String searchMap(Model model) {
	
		
		return "article/searchMap";
	}
	
	// 응급처치
	@RequestMapping("/article/firstAid")
	public String firstAid(Model model) {
		
		return "article/firstAid";
	}
	
	// 기관(병원/약국) 추가 폼
	@RequestMapping("/article/organWrite")
	public String organWrite(Model model) {
		
		List<CateItem> cateItems = articleService.getCateItem();
		
		model.addAttribute("cateItems", cateItems);
		
		return "article/organWrite";
	}
	
	// 기관(병원/약국) 추가 기능
	@RequestMapping("/article/doOrganWrite")
	public String doOrganWrite(@RequestParam Map<String, Object> param, Model model, String redirectUri, HttpServletRequest request) {
		
		param.put("memberId", request.getAttribute("loginedMemberId"));
		
		articleService.organWrite(param);
		
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "정보 등록이 완료되었습니다.");

		return "common/redirect";
	}
	
	// 게시물 리스트(자유/공지)
	@RequestMapping("/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		List<Article> articles = articleService.getForPrintArticles();

		model.addAttribute("articles", articles);

		return "article/list";
	}
	
	// 게시물 상세보기
	@RequestMapping("/article/{boardCode}-detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");

		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/detail";
	}
	
	// 게시물 작성 폼
	@RequestMapping("/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, Model model, String listUrl) {
		if ( listUrl == null ) {
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
	@RequestMapping("/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		newParam.put("boardId", board.getId());
		newParam.put("memberId", loginedMemberId);
		int newArticleId = articleService.write(newParam);
		
		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}
	
	// 게시물 수정 폼
	@RequestMapping("/article/{boardCode}-modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/modify";
	}
	
	// 게시물 수정 기능
	@RequestMapping("/article/{boardCode}-doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		
		ResultData checkActorCanModifyResultData = articleService.checkActorCanModify(loginedMember, id);
		
		if (checkActorCanModifyResultData.isFail() ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkActorCanModifyResultData.getMsg());
			
			return "common/redirect";
		}
		
		articleService.modify(newParam);
		
		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}
	
	// 게시물 삭제 기능
		@RequestMapping("/article/{boardCode}-doDelete")
		public String doDelete(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, @PathVariable("boardCode") String boardCode, Model model) {
			Board board = articleService.getBoardByCode(boardCode);
			model.addAttribute("board", board);
			Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
			Member loginedMember = (Member)req.getAttribute("loginedMember");
			
			ResultData checkActorCanDeleteResultData = articleService.checkActorCanDelete(loginedMember, id);
			
			if (checkActorCanDeleteResultData.isFail() ) {
				model.addAttribute("historyBack", true);
				model.addAttribute("msg", checkActorCanDeleteResultData.getMsg());
				
				return "common/redirect";
			}
			
			articleService.delete(newParam);
			
			String redirectUri = boardCode + "-list";

			return "redirect:" + redirectUri;
		}
	
}

