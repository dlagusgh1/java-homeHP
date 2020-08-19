package com.sbs.lhh.hp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lhh.hp.dao.ArticleDao;
import com.sbs.lhh.hp.dto.CateItem;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public List<CateItem> getCateItem() {
		return articleDao.getCateItem();
	}

	public void organWrite(Map<String, Object> param) {
		articleDao.organWrite(param);
	}
	
	
}
