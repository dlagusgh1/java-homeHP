package com.sbs.lhh.hp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private boolean authStatus;
	private String loginId;
	private String loginPw;
	private String name;
	private String organName;
	private String organCode;
	private String email;
	private String phoneNo;
}
