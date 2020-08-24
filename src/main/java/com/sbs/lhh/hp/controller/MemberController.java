package com.sbs.lhh.hp.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lhh.hp.dto.Member;
import com.sbs.lhh.hp.dto.ResultData;
import com.sbs.lhh.hp.service.MemberService;
import com.sbs.lhh.hp.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	// 회원가입
	@RequestMapping("/member/join")
	public String join() {
		return "member/join";
	}

	// 회원가입 기능
	@RequestMapping("/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");

		ResultData checkLoginIdJoinableResultData = memberService.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "가입을 환영합니다^^");

		return "common/redirect";
	}
	
	// 회원가입 진행 중 중복체크(AJAX)(아이디)
	@RequestMapping("/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(HttpServletRequest request) {
		String loginId = request.getParameter("loginId");

		boolean isJoinableLoginId = memberService.isJoinableLoginId(loginId);	
		
		if (isJoinableLoginId == false) {
			if(loginId.length() <= 3) {
				return new ResultData("F-1", "아이디 3자 이상 입력", "loginId", loginId);
			} else {
				return new ResultData("S-1", "아이디 사용 가능", "loginId", loginId);
			}
		} else {
			return new ResultData("F-1", "중복된 아이디가 존재합니다.", "loginId", loginId);
		}
	}
	
	// 회원가입 진행 중 중복체크(AJAX)(기관명)
	@RequestMapping("/member/getOrganNameDup")
	@ResponseBody
	public ResultData getOrganNameDup(HttpServletRequest request) {
		String organName = request.getParameter("organName");

		boolean isJoinableOrganName = memberService.isJoinableOrganName(organName);

		if (isJoinableOrganName == false) {
			if(organName.length() <= 2) {
				return new ResultData("F-1", "기관명을 2자 이상 입력", "organName", organName);
			} else {
				return new ResultData("S-1", "기관명 사용 가능", "organName", organName);
			}
		} else {
			return new ResultData("F-1", "중복된 기관명이 존재합니다.", "organName", organName);
		}
	}
	
	// 회원가입 진행 중 중복체크(AJAX)(이메일)
	@RequestMapping("/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(HttpServletRequest request) {
		String email = request.getParameter("email");

		boolean isJoinableEmail = memberService.isJoinableEmail(email);

		if (isJoinableEmail) {
			if(email.length() == 0) {
				return new ResultData("F-1", "이메일을 입력해주세요.", "email", email);
			} else {
				return new ResultData("S-1", "이메일 사용 가능", "email", email);
			}
		} else {
			return new ResultData("F-1", "중복된 이메일이 존재합니다.", "email", email);
		}
	}

	// 로그인 폼
	@RequestMapping("/member/login")
	public String showLogin() {
		return "member/login";
	}

	// 로그인 기능
	@RequestMapping("/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session, HttpServletRequest request) {
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
		
		ResultData useTempPassword = memberService.useTempPassword(member.getId());
		
		if (useTempPassword.isSuccess()) {
			model.addAttribute("alertMsg", "현재 임시 비밀번호를 사용 중 입니다.\\n비밀번호 변경 부탁드립니다.");
			
			redirectUri = "/member/checkPassword?redirectUri=%2Fmember%2FmemberModifyPw";
			model.addAttribute("redirectUri", redirectUri);
			
			return "common/redirect";
		}
		
		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s 담당자님 반갑습니다.", member.getOrganName()));

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
	
	// 아이디 / 비밀번호 찾기 폼
	@RequestMapping("member/findAccount")
	public String findAccount() {
		return "member/findAccount";
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
		
		model.addAttribute("alertMsg", "등록하신 메일로 아이디가 전송되었습니다.\\n메일 확인 부탁드립니다.");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}

	// 비밀번호 찾기(임시패스워드 발급)
	@RequestMapping("member/doFindPw")
	public String doFindPw(@RequestParam Map<String, Object> param, Model model, String redirectUri) {
		
		Member member = memberService.getMemberByParam(param);
		
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}		
		
		memberService.changeLoginPw(member);
		
		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/member/login";
		}
		
		model.addAttribute("alertMsg", "등록하신 메일로 임시패스워드가 전송되었습니다.\\n메일 확인 부탁드립니다.");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	
	// 마이페이지
	@RequestMapping("member/myPage")
	public String myPage() {
		
		// 이메일 인증/비인증 노출 기능 추가하기
		
		
		return "member/myPage";
	}
	
	// 회원정보 수정 폼
	@RequestMapping("member/memberModify")
	public String memberModify(HttpSession session, Model model, HttpServletRequest req, String checkPasswordAuthCode) {
		
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		ResultData checkValidCheckPasswordAuthCodeResultData = memberService.checkValidCheckPasswordAuthCode(loginedMemberId, checkPasswordAuthCode);

		if (checkPasswordAuthCode == null || checkPasswordAuthCode.length() == 0) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호 체크 인증코드가 없습니다.");
			return "common/redirect";
		}

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkValidCheckPasswordAuthCodeResultData.getMsg());
			return "common/redirect";
		}
		
		return "member/memberModify";
	}
	
	// 회원정보 수정 기능
	@RequestMapping("member/doMemberModify")
	public String doMemberModify(@RequestParam Map<String, Object> param, HttpSession session, Model model, String redirectUri) {
		
		memberService.memberModify(param);
		
		model.addAttribute("alertMsg", "회원 정보가 정상적으로 수정되었습니다.\\n다시 로그인 해주세요.");
		model.addAttribute("redirectUri", redirectUri);
		
		session.removeAttribute("loginedMemberId");
		
		return "common/redirect";
	}

	// 비밀번호 수정 폼
	@RequestMapping("member/memberModifyPw")
	public String memberModifyPw() {
		return "member/memberModifyPw";
	}
	
	// 비밀번호 수정 기능
	@RequestMapping("member/doMemberModifyPw")
	public String doMemberModifyPw(@RequestParam Map<String, Object> param, HttpSession session, Model model, String redirectUri, HttpServletRequest request) {
	
		int loginedMemberId = (int) request.getAttribute("loginedMemberId");
		
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		
		memberService.memberModifyPw(param, loginedMemberId);
		
		model.addAttribute("alertMsg", "비밀번호가 정상적으로 수정되었습니다.\\n다시 로그인 해주세요.");
		model.addAttribute("redirectUri", redirectUri);
		
		session.removeAttribute("loginedMemberId");
		
		return "common/redirect";	
	}
	
	// 비밀번호 확인 폼 연결(내정보/회원정보 변경/비밀번호 변경 전 확인)
	@RequestMapping("/member/checkPassword")
	public String checkPassword() {
		return "member/passwordConfirm";
	}
	
	// 비밀번호 확인 기능(내정보/회원정보 변경/비밀번호 변경 전 확인)
	@RequestMapping("/member/doPasswordConfirm")
	public String doPasswordConfirm(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request, String redirectUri) {
		String loginPw = (String) param.get("loginPwReal");
		Member loginedMember = (Member) request.getAttribute("loginedMember");

		if (loginedMember.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		String authCode = memberService.genCheckPasswordAuthCode(loginedMember.getId());
		
		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/home/main";
		}

		redirectUri = Util.getNewUri(redirectUri, "checkPasswordAuthCode", authCode);

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
}

