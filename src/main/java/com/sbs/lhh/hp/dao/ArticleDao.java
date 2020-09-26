package com.sbs.lhh.hp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lhh.hp.dto.AdCateItem;
import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.Board;
import com.sbs.lhh.hp.dto.CateItem;
import com.sbs.lhh.hp.dto.CovidData;
import com.sbs.lhh.hp.dto.Organ;

@Mapper
public interface ArticleDao {
	
	Board getBoardByCode(String boardCode);
	
	int getForPrintListArticlesCount(String boardCode);
	
	List<Article> getForPrintArticles(String boardCode, int limitFrom, int itemsInAPage);
	
	Article getForPrintArticleById(@Param("id") int id);
	
	void write(Map<String, Object> param);

	void modify(Map<String, Object> param);

	void delete(Map<String, Object> param);
	
	Article getArticleById(@Param("id") int id);
	
	void increaseArticleHit(@Param("id")int id);
	
	void likeArticle(@Param("id") int id, @Param("memberId") int memberId);
	
	int getLikePointByMemberId(@Param("id") int id, @Param("memberId") int memberId);
	
	void cancelLikeArticle(@Param("id") int id, @Param("memberId") int memberId);
	
	List<AdCateItem> getAdCateItem();
	
	List<Organ> getOrgan();
	
	int organsCount();
	
	int organCount(int organNumber);

	List<CateItem> getCateItem();
	
	List<CovidData> getCovidData();

	void setCovidData(CovidData data);
	
	void setCovidDataUpdate(CovidData data);
	
	List<Board> getBoards();

	void hideArticle(int id);
	
	void showArticle(int id);
	
	List<Article> getForPrintVisibleArticles();
	
	void organWrite(Map<String, Object> param);

}
