package com.sbs.lhh.hp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lhh.hp.dto.CateItem;

@Mapper
public interface ArticleDao {

	List<CateItem> getCateItem();
}
