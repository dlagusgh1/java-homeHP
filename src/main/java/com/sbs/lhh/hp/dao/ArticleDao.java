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

	List<CateItem> getCateItem();

	void organWrite(Map<String, Object> param);

	List<AdCateItem> getAdCateItem();

	Board getBoardByCode(String boardCode);

	List<Article> getForPrintArticles(String boardCode);
	
	List<Article> getForPrintVisibleArticles();

	Article getForPrintArticleById(@Param("id") int id);

	Article getArticleById(@Param("id") int id);
	
	void write(Map<String, Object> param);

	void modify(Map<String, Object> param);

	void delete(Map<String, Object> param);
	
	List<Board> getBoards();

	List<Organ> getOrgan();

	int organsCount();

	int organCount(int organNumber);

	void hideArticle(int id);
	
	void showArticle(int id);

	void setCovidData(CovidData data);
	
	void setCovidDataUpdate(CovidData data);

	List<CovidData> getCovidData();

	void increaseArticleHit(@Param("id")int id);

	int getLikePointByMemberId(@Param("id") int id, @Param("memberId") int memberId);

	void likeArticle(@Param("id") int id, @Param("memberId") int memberId);

	void cancelLikeArticle(@Param("id") int id, @Param("memberId") int memberId);

}
