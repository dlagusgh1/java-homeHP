package com.sbs.lhh.hp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.lhh.hp.service.MemberService;

@Controller
public class ArticleController {

	// 회원가입
	@RequestMapping("/article/hospital")
	public String join() {
		
		
		
		return "article/hospital";
	}

	
}

