package com.sbs.lhh.hp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@RequestMapping("/member/join")
	public String join() {
		
		return "member/join";
	}
}

