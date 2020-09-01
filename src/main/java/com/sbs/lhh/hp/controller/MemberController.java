package com.sbs.lhh.hp.controller;

import java.util.Date;
import java.util.List;
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

import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
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
	
	// 이메일 인증 재 발송 기능
	@RequestMapping("/member/reAuthEmail")
	private String reAuthEmail(HttpServletRequest request, Model model) {
		Member loginedMember = (Member) request.getAttribute("loginedMember");
		
		memberService.reSendEmailAuthCode(loginedMember.getId(), loginedMember.getEmail());
		
		String redirectUri = "/member/checkPassword?redirectUri=%2Fmember%2FmyPage";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "인증 메일이 재 발송 되었습니다.\\n확인 후 이메일 인증 부탁드립니다.");

		return "common/redirect";
	}
	
	// 이메일 인증 기능
	@RequestMapping("/member/authEmail")
	private String authCodeEmail(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model) {
		
		String email = (String) param.get("email"); 
		String authCode = (String) param.get("authCode");
		String memberId = (String) param.get("memberId");

		// 이메일이 인증되었는지 attr에서 인증된 메일정보 가져오기
		String emailAuthed = memberService.getAuthCodeEmail(Integer.parseInt(memberId)); 
		
		// 이메일 인증 중복 방지
		if ( emailAuthed != "" ) {
			String redirectUri = "/home/main";
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", "이미 이메일 인증이 완료되었습니다.");

			return "common/redirect";
		}
			
		Member member = memberService.getMemberById(Integer.parseInt(memberId));
		
		boolean isExistMemberId = Integer.parseInt(memberId) == member.getId();
		boolean isExistMemberEmail = email.equals(member.getEmail());
		
		String mailAuthCode = memberService.getAuthCode(Integer.parseInt(memberId)); 
		
		if (isExistMemberId == false || isExistMemberEmail == false || mailAuthCode == null ) {
			String redirectUri = "/member/checkPassword?redirectUri=%2Fmember%2FmyPage";
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", "이메일 인증에 사용되는 정보가 잘못되었습니다.");

			return "common/redirect";
		}
	
		memberService.setEmailAuthed(Integer.parseInt(memberId), email);
		
		String redirectUri = "/member/login";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "이메일 인증이 완료되었습니다.");

		return "common/redirect";
		
	}

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
		
		memberService.sendEmailAuthCode(newMemberId, (String) param.get("email"));
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "가입을 환영합니다^^");

		return "common/redirect";
	}
	
	// 회원가입 진행 중 중복체크(AJAX)(아이디)
	@RequestMapping("/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(@RequestParam Map<String, Object> param) {
		
		String loginId = (String) param.get("loginId");

		boolean isJoinableLoginId = memberService.checkMemberDataJoinable(param);
		
		if (isJoinableLoginId == false) {
			if (loginId.equals("") ) {
				return new ResultData("E-1", "");
			} else if(loginId.length() <= 3) {
				return new ResultData("F-1", "아이디를 3자 이상 입력해주세요.", "loginId", loginId);
			} else if(loginId.matches("^[a-zA-Z0-9]*$") == false) {
				return new ResultData("M-1", "아이디를 영문자 또는 숫자로 입력해주세요.", "loginId", loginId);
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
	public ResultData getOrganNameDup(@RequestParam Map<String, Object> param) {
		
		String organName = (String) param.get("organName");

		boolean isJoinableOrganName = memberService.checkMemberDataJoinable(param);

		if (isJoinableOrganName == false) {
			if (organName.equals("") ) {
				return new ResultData("E-1", "");
			} else if(organName.length() <= 2) {
				return new ResultData("F-1", "기관명을 2자 이상 입력해주세요.", "organName", organName);
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
	public ResultData getEmailDup(@RequestParam Map<String, Object> param) {
		
		String email = (String) param.get("email");

		boolean isJoinableEmail = memberService.checkMemberDataJoinable(param);

		if (isJoinableEmail == false) {
			if (email.equals("") ) {
				return new ResultData("E-1", "");
			} else if (email.contains("@") == false) {
				return new ResultData("A-1", "이메일 주소를 정확히 입력해주세요.", "email", email);
			} else if(email.length() == 0) {
				return new ResultData("F-1", "이메일 주소를 입력해주세요.", "email", email);
			} else {
				return new ResultData("S-1", "이메일 사용 가능", "email", email);
			}
		} else {
			return new ResultData("F-1", "중복된 이메일이 존재합니다.", "email", email);
		}
	}
	
	// 회원가입 진행 중 중복체크(AJAX)(휴대전화번호)
	@RequestMapping("/member/getCellPhoneNoDup")
	@ResponseBody
	public ResultData getCellPhoneNoDup(@RequestParam Map<String, Object> param) {
		
		String cellphoneNo = (String) param.get("cellphoneNo");
		
		boolean isJoinableCellPhoneNo = memberService.checkMemberDataJoinable(param);

		if (isJoinableCellPhoneNo == false) {
			if (cellphoneNo.equals("") ) {
				return new ResultData("E-1", "");
			} else if(cellphoneNo.length() == 0) {
				return new ResultData("F-1", "휴대전화 번호를 입력해주세요.", "cellphoneNo", cellphoneNo);
			} else if (cellphoneNo.matches("^[0-9]*$") == false) {
				return new ResultData("N-1", "번호에는 숫자만 입력 가능합니다.", "cellphoneNo", cellphoneNo);
			} else {
				return new ResultData("S-1", "사용 가능한 번호입니다.", "cellphoneNo", cellphoneNo);
			}
		} else {
			return new ResultData("F-1", "중복된 번호가 존재합니다.", "cellphoneNo", cellphoneNo);
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
		
		if (member.isDelStatus()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "탈퇴한 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		String current = Util.getNowDateStr();
		String last = member.getUpdateDate();	
		
		long differenceDate = Util.getTime(current, last);	
		
		ResultData useTempPassword = memberService.useTempPassword(member.getId());
		
		session.setAttribute("loginedMemberId", member.getId());
		
		if ( differenceDate > 30 ) {
			model.addAttribute("alertMsg", "장기간 동일한 비밀번호를 사용중 입니다.\\n비밀번호 변경 부탁드립니다.");	
			
			redirectUri = "/member/checkPassword?redirectUri=%2Fmember%2FmemberModifyPw";
			model.addAttribute("redirectUri", redirectUri);
			
			return "common/redirect";
		}
		
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
	public String myPage(Model model, HttpServletRequest request) {
		int loginedMemberId = (int) request.getAttribute("loginedMemberId");
		
		// 이메일 인증/비인증 노출 기능 추가하기
		String emailAuthed = memberService.getAuthCodeEmail(loginedMemberId); 
		
		model.addAttribute("emailAuthed", emailAuthed);		
		
		return "member/myPage";
	}
	
	// 회원정보 수정 폼
	@RequestMapping("member/memberModify")
	public String memberModify(HttpSession session, Model model, HttpServletRequest request, String checkPasswordAuthCode) {
		
		int loginedMemberId = (int) request.getAttribute("loginedMemberId");
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
	
	// 회원 탈퇴 폼
	@RequestMapping("member/memberDelete")
	public String memberDelete() {		
		return "member/memberDelete";
	}
	
	// 회원 탈퇴 기능
	@RequestMapping("member/doMemberDelete")
	public String doMemberDelete(@RequestParam Map<String, Object> param, HttpSession session, Model model, HttpServletRequest request, String redirectUri) {
		Member loginedMember = (Member) request.getAttribute("loginedMember");	
		
		memberService.memberDelete(loginedMember.getLoginId());
		
		model.addAttribute("alertMsg", "탈퇴가 정상적으로 처리되었습니다.\\n감사합니다.");
		model.addAttribute("redirectUri", redirectUri);
		
		session.removeAttribute("loginedMemberId");
		
		return "common/redirect";	
	}
	
	// 관리자 메뉴 - 회원 관리
	@RequestMapping("/member/memberManage")
	public String memberManage(Model model) {
		List<Member> members = memberService.getMemberList();

		model.addAttribute("members", members);
		
		return "member/memberManage";
	}
	
	// 관리자 메뉴 - 회원 관리(회원 복구)ajax
	@RequestMapping("/member/doMemberRecoveryAjax")
	@ResponseBody
	public ResultData doMemberRecoveryAjax(Model model, String loginId, HttpServletRequest request) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			
			new ResultData("F-1", String.format("존재하지 않는 회원입니다."));
		}
		
		if (member.isDelStatus() != true) {
			
			new ResultData("F-1", String.format("이미 복구처리된 회원 입니다."));
		}
		
		memberService.doMemberRecoveryAjax(loginId);

		return new ResultData("S-1", String.format("%d 회원을 복구시켰습니다.", loginId));
	}
	
	// 관리자 메뉴 - 회원 관리(탈퇴(숨기기))ajax
	@RequestMapping("/member/doMemberDeleteAjax")
	@ResponseBody
	public ResultData doMemberDeleteAjax(Model model, String loginId, HttpServletRequest request) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			
			new ResultData("F-1", String.format("존재하지 않는 회원입니다."));
		}
		
		if (member.isDelStatus()) {
			
			new ResultData("F-1", String.format("이미 탈퇴처리된 회원 입니다."));
		}
		
		memberService.doMemberDeleteAjax(loginId);

		return new ResultData("S-1", String.format("%s 회원을 탈퇴시켰습니다.", loginId));
	}
	
	// 관리자 메뉴 - 회원 관리(권한 설정 폼)
	@RequestMapping("/member/memberGrantLevel")
	public String memberGrantLevel(Model model) {
		
		List<Member> members = memberService.getMemberList();

		model.addAttribute("members", members);
		
		return "member/memberGrantLevel";
	}
	
	// 관리자 메뉴 - 회원 관리(권한 설정 기능)
	@RequestMapping("/member/doGrantLevel")
	public String doGrantLevel(@RequestParam Map<String, Object> param, HttpSession session, Model model, String redirectUri, HttpServletRequest request) {
		
		String loginMemberId = (String) param.get("memberId");
		
		int grantLevel1 = 0;
		if (Util.isNum(param.get("grantLevel1"))) {
			grantLevel1 = Integer.parseInt((String) param.get("grantLevel1"));
			System.out.println("grantLevel1 확인 : " + grantLevel1);
		}
		int grantLevel2 = 0;
		if (Util.isNum(param.get("grantLevel2"))) {
			grantLevel2 = Integer.parseInt((String) param.get("grantLevel2"));
			System.out.println("grantLevel2 확인 : " + grantLevel2);
		}
		int grantLevel3 = 0;
		if (Util.isNum(param.get("grantLevel3"))) {
			grantLevel1 = Integer.parseInt((String) param.get("grantLevel3"));
			System.out.println("grantLevel3 확인 : " + grantLevel3);
		}
		
		model.addAttribute("alertMsg", "회원 권한 설정이 완료되었습니다.");
		model.addAttribute("historyBack", true);

		return "common/redirect";	
	}
}

