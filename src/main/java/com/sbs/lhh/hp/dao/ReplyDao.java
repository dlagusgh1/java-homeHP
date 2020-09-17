package com.sbs.lhh.hp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lhh.hp.dto.Reply;

@Mapper
public interface ReplyDao {
		// 댓글 리스트
		List<Reply> getForPrintReplies(Map<String, Object> param);

		// 댓글 작성
		void writeReply(Map<String, Object> param);

		// 댓글 삭제
		void deleteReply(@Param("id") int id);

		// 특정 댓글 가져오기
		Reply getForPrintReplyById(@Param("id") int id);

		// 댓글 수정
		void modifyReply(Map<String, Object> param);
}
