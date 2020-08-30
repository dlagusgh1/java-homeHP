package com.sbs.lhh.hp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.service.ArticleService;

@Controller
public class HomeController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/home/main")
	public String showMain(Model model) {
		
		int limit = 5;
		
		List<Article> articles = articleService.getForPrintLimitNoticeArticles(limit);

		model.addAttribute("boardId", 2);
		model.addAttribute("articles", articles);
		
		return "home/main";
	}
}

