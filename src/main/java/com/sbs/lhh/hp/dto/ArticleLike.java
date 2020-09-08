package com.sbs.lhh.hp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticleLike {
	private int id;
	private String regDate;
	private int articleId;
	private int memberId;
	private int point;
}
