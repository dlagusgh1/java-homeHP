package com.sbs.lhh.hp.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberDao {
	int getLoginIdDupCount(@Param("loginId") String loginId);
	
	void join(Map<String, Object> param);
}
