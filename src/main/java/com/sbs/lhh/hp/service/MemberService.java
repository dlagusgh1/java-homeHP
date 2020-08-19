package com.sbs.lhh.hp.service;

import java.util.Map;

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

		sendJoinCompleteMail((String) param.get("email"));

		return Util.getAsInt(param.get("id"));
	}

	// 가입완료 대상에게 환영메일
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p>담당자님의 가입을 진심으로 환영합니다.<br><br><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

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
	
}
