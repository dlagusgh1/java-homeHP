package com.sbs.lhh.hp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
		
		Board fBoard = articleService.getBoardByCode("1");
		model.addAttribute("fBoard", fBoard);
		
		Board nBoard = articleService.getBoardByCode("2");
		model.addAttribute("nBoard", nBoard);
		
		int limit = 5;
		
		List<Article> fArticles = articleService.getForPrintBoarCodeArticles("1", limit);
		List<Article> nArticles = articleService.getForPrintBoarCodeArticles("2", limit);
		
		model.addAttribute("fArticles", fArticles);
		model.addAttribute("nArticles", nArticles);
		
		return "home/main";
	}
}

