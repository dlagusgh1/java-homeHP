package com.sbs.lhh.hp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Organ {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private int organNumber;
	private String organName;
	private String organAddress;
	private String organAdmAddress;
	private String organTel;
	private String organTime;
	private String organWeekendTime;
	private String organWeekend;
	private String organRemarks;
	private String organLocation1;
	private String organLocation2;
	private int memberId;
}
