package com.sbs.lhh.hp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lhh.hp.dto.Member;

@Mapper
public interface MemberDao {
	Member getMemberById(@Param("id") int id);

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);

	Member getMemberByLoginId(@Param("loginId") String loginId);

	Member getMemberByParam(Map<String, Object> param);

	void memberModifyShaPw(String loginId, String organName, String shaPw);

	void memberModify(Map<String, Object> param);

	void memberModifyPw(Map<String, Object> param);

	boolean checkMemberDataJoinable(Map<String, Object> param);
	
	void meberDelete(String loginId);

	List<Member> getMemberList();

}
