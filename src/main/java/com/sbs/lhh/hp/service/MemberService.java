package com.sbs.lhh.hp.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.lhh.hp.dao.MemberDao;
import com.sbs.lhh.hp.dto.Member;
import com.sbs.lhh.hp.dto.ResultData;
import com.sbs.lhh.hp.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Autowired
	private AttrService attrService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	
	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	// 회원가입
	public int join(Map<String, Object> param) {
		memberDao.join(param);

		// 회원가입 완료 시 대상에게 환영메일 발송
		sendJoinCompleteMail((String) param.get("email"));
		
		return Util.getAsInt(param.get("id"));
	}
	
	// 이메일 인증관련 고유 코드 재 발송 기능
	public void reSendEmailAuthCode(int actorId, String email) {

		String authCode = getAuthCodeEmail(actorId);
		
		String mailTitle = String.format("[%s] 가입이 완료되었습니다. 이메일 인증 부탁드립니다.", siteName);
		
		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>이메일 인증</h1>");
		mailBodySb.append(String.format("<p>담당자님의 가입을 진심으로 환영합니다.<br><br>아래 링크로 접속하여 이메일 인증을 해주세요.<br><br><a href=\"http://localhost:8085/member/authEmail?email=%s&authCode=%s&memberId=%s\" target=\"_blank\">이메일 인증하기</a> </p>", email, authCode, actorId));
		
		mailService.send(email, mailTitle, mailBodySb.toString());
	}
	
	// 회원가입 완료 시 대상에게 이메일 인증관련 고유 코드 등록 후 인증 안내 발송
	public void sendEmailAuthCode(int actorId, String email) {
		String authCode = UUID.randomUUID().toString();
		
		attrService.setValue("member__" + actorId + "__extra__emailAuthCode", authCode, Util.getDateStrLater(60 * 60));	
		
		String mailTitle = String.format("[%s] 이메일 인증", siteName);
		
		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>이메일 인증</h1>");
		mailBodySb.append(String.format("<p>가입을 진심으로 축하드립니다.<br><br>아래 링크를 클릭하여 이메일 인증을 진행해주세요.<br><br><a href=\"http://localhost:8085/member/authEmail?email=%s&authCode=%s&memberId=%s\" target=\"_blank\">이메일 인증하기</a> </p>", email, authCode, actorId));
		
		mailService.send(email, mailTitle, mailBodySb.toString());
	}
	
	// 이메일이 인증되었는지 attr에서 인증된 메일정보 가져오기
	public String getAuthCodeEmail(int memberId) {
		String authCodeEmail = attrService.getValue("member__" + memberId + "__extra__emailAuthed");
		
		return authCodeEmail;
	}
	
	// attr에서 회원가입 시 등록된 고유 인증 코드 가져오기
	public String getAuthCode(int memberId) {
		String authCode = attrService.getValue("member__" + memberId + "__extra__emailAuthCode");
		
		return authCode;
	}
	
	// 이메일 인증 완료 시 attr에 인증된 메일 정보 등록
	public void setEmailAuthed(int actorId, String email) {
		attrService.setValue("member__" + actorId + "__extra__emailAuthed", email, Util.getDateStrLater(60 * 60));
	}

	// 회원가입 완료 시 대상에게 환영메일
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>환영합니다!</h1>");
		mailBodySb.append(String.format("<p>가입을 진심으로 축하드립니다.<br><br><a href=\"http://localhost:8085/home/main\" target=\"_blank\">%s 사이트로 이동하기</a></p>", siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	// 회원가입 아이디 중복체크
	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	// 로그인 아이디로 대상 가져오기
	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	// 아이디 / 비밀번호 찾기 전 일치하는 정보 존재하는지 체크
	public Member getMemberByParam(Map<String, Object> param) {
		return memberDao.getMemberByParam(param);
	}

	// 아이디 찾기 기능(찾은 아이디 메일 전송)
	public void sendFindId(Member member) {
		String mailTitle = String.format("[%s] 아이디 찾기 결과", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>아이디 찾기 결과</h1>");
		mailBodySb.append(String.format("<p>아이디 찾기 결과 : %s <br><br><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", member.getLoginId(), siteMainUri, siteName));

		mailService.send(member.getEmail(), mailTitle, mailBodySb.toString());	
	}

	// 비밀번호 찾기 기능(임시 패스워드 발송 & 임시패스워드 적용)
	public void changeLoginPw(Member member) {
		
		String tempPw = Util.getTempPassword(8);
		String shaPw = Util.sha256(tempPw);	
		
		String authCode = UUID.randomUUID().toString();
		
		attrService.setValue("member__" + member.getId() + "__extra__useTempPassword", authCode, Util.getDateStrLater(60 * 60));
		
		memberModifyShaPw(member.getLoginId(), member.getOrganName(), shaPw);
		
		String mailTitle = String.format("[%s] 비밀번호 찾기 결과", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>비밀번호 찾기 결과</h1>");
		mailBodySb.append(String.format("<p>임시패스워드 : %s <br><br><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", tempPw, siteMainUri, siteName));

		mailService.send(member.getEmail(), mailTitle, mailBodySb.toString());	
	}

	// 임시 패스워드 적용
	private void memberModifyShaPw(String loginId, String organName, String shaPw) {
		memberDao.memberModifyShaPw(loginId, organName, shaPw);
	}

	// 회원 정보 수정
	public void memberModify(Map<String, Object> param) {
		memberDao.memberModify(param);
	}

	// 비밀번호 수정
	public void memberModifyPw(Map<String, Object> param, int actorId) {
			
		ResultData checkValidCheckTemporaryPasswordAuthCodeResultData = useTempPassword(actorId);
		
		if (checkValidCheckTemporaryPasswordAuthCodeResultData != null) {
			attrService.remove("member__" + actorId + "__extra__useTempPassword");
		}
		
		memberDao.memberModifyPw(param);
		
	}

	// 회원가입 진행 중 중복체크(AJAX)(아이디)
	public boolean isJoinableLoginId(String loginId) {
		return memberDao.isJoinableLoginId(loginId);
	}

	// 회원가입 진행 중 중복체크(AJAX)(아이디)
	public boolean isJoinableOrganName(String organName) {
		return memberDao.isJoinableOrganName(organName);
	}

	// 회원가입 진행 중 중복체크(AJAX)(아이디)
	public boolean isJoinableEmail(String email) {
		return memberDao.isJoinableEmail(email);
	}
	
	// 정보변경(회원정보, 비밀번호) 등 진행 시 비밀번호 확인 attr 저장
	public String genCheckPasswordAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__modifyPrivateAuthCode", authCode, Util.getDateStrLater(60 * 60));

		return authCode;
	}

	// 정보변경(회원정보, 비밀번호) 전 비밀번호 확인 되었는지, attr 확인
	public ResultData checkValidCheckPasswordAuthCode(int actorId, String checkPasswordAuthCode) {
		if (attrService.getValue("member__" + actorId + "__extra__modifyPrivateAuthCode").equals(checkPasswordAuthCode)) {
			return new ResultData("S-1", "유효한 키 입니다.");
		}

		return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}

	// 로그인 시 임시 패스워드 사용여부 확인
	public ResultData useTempPassword(int actorId) {
		
		String useTempPassword = attrService.getValue("member__" + actorId + "__extra__useTempPassword");
		
		if (useTempPassword.equals("")) {
			System.out.println("F-1 일때 : " + useTempPassword);
			return new ResultData("F-1", "임시 패스워드를 사용하고 있지 않습니다.");
		}
		System.out.println("에스-1 일때 : " + useTempPassword);
		return new ResultData("S-1", "임시 패스워드를 사용 중 입니다.");
	
	}

}
