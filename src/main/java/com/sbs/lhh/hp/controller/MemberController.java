package com.sbs.lhh.hp.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lhh.hp.dto.Member;
import com.sbs.lhh.hp.dto.ResultData;
import com.sbs.lhh.hp.util.Util;
import com.sbs.lhh.hp.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	// 회원가입
	@RequestMapping("/member/join")
	public String join() {
		return "member/join";
	}

	// 회원가입 기능
	@RequestMapping("/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");

		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 로그인 폼
	@RequestMapping("/member/login")
	public String showLogin() {
		return "member/login";
	}

	// 로그인 기능
	@RequestMapping("/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session) {
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s 기관 담당자님 반갑습니다.", member.getOrganName()));

		return "common/redirect";
	}

	// 로그아웃 기능
	@RequestMapping("/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loginedMemberId");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		return "common/redirect";
	}
	
	// 아이디 찾기 폼
	@RequestMapping("member/findId")
	public String findId() {
		return "member/findId";
	}
	
	// 아이디 찾기 기능
	@RequestMapping("member/doFindId")
	public String doFindId(@RequestParam Map<String, Object> param, Model model, String redirectUri) {
		
		Member member = memberService.getMemberByParam(param);
		
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}		
		
		memberService.sendFindId(member);
		
		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/member/login";
		}
		
		model.addAttribute("alertMsg", "등록하신 메일로 아이디가 전송되었습니다.");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}

	// 비밀번호 찾기
	
}

