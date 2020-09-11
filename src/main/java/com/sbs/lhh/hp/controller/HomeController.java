package com.sbs.lhh.hp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		
		return "home/main";
	}
	
	@RequestMapping("/")
	public String showIndex() {
		return "home/main";
	}
}

