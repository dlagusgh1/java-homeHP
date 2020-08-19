package com.sbs.lhh.hp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.CateItem;

@Mapper
public interface ArticleDao {

	List<CateItem> getCateItem();

	void organWrite(Map<String, Object> param);

	List<AdCateItem> getAdCateItem();
}
