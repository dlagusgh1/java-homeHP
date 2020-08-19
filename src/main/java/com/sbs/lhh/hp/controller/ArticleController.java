package com.sbs.lhh.hp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	// 회원가입
	@RequestMapping("/article/hospital")
	public String join() {
		
		return "article/hospital";
	}
	
	// 병원 / 약국 추가 폼
	@RequestMapping("/article/write")
	public String write(Model model) {
		
		List<CateItem> cateItems = articleService.getCateItem();
		
		model.addAttribute("cateItems", cateItems);
		
		return "article/write";
	}
	
}

