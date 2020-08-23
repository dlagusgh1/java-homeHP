package com.sbs.lhh.hp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.dto.Organ;

@Mapper
public interface ArticleDao {

	List<CateItem> getCateItem();

	void organWrite(Map<String, Object> param);

	List<AdCateItem> getAdCateItem();

	Board getBoardByCode(String boardCode);

	List<Article> getForPrintArticles();
	
	List<Article> getForPrintBoarCodeArticles(String boardCode, int limit);

	Article getForPrintArticleById(@Param("id") int id);

	Article getArticleById(@Param("id") int id);
	
	void write(Map<String, Object> param);

	void modify(Map<String, Object> param);

	void delete(Map<String, Object> param);
	
	List<Board> getBoards();

	List<Organ> getOrgan();
	
}
