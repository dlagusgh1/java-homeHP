package com.sbs.lhh.hp.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lhh.hp.dto.Member;

@Mapper
public interface MemberDao {
	int getLoginIdDupCount(@Param("loginId") String loginId);
	
	void join(Map<String, Object> param);
	
	Member getMemberByLoginId(@Param("loginId") String loginId);
}
