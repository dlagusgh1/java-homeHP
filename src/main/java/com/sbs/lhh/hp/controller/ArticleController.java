package com.sbs.lhh.hp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	// 회원가입
	@RequestMapping("/article/hospital")
	public String join(Model model) {
		
		List<AdCateItem> adCateItems = articleService.getAdCateItem();
		
		model.addAttribute("adCateItems", adCateItems);
		
		return "article/hospital";
	}
	
	// 기관(병원/약국) 추가 폼
	@RequestMapping("/article/organWrite")
	public String organWrite(Model model) {
		
		List<CateItem> cateItems = articleService.getCateItem();
		
		model.addAttribute("cateItems", cateItems);
		
		return "article/write";
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
	
}

