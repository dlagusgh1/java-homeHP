package com.sbs.lhh.hp.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Board {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String code;
	private Map<String, Object> extra;
}
