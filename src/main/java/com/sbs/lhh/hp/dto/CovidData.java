package com.sbs.lhh.hp.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class CovidData {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private int delStatus;
	private String country; // 시도명
    private int diffFromPrevDay; // 전일대비확진환자증감
    private int domesticInflow; // 국내유입
    private int overseasInflow; // 해외유입
    private String total; // 확진환자수
    private String quarantine; // 격리자수
    private String quarantineRelease;// 격리해제자 수
    private int death; // 사망자수
    private String incidence; // 발병률
    // private int cure;// 완치자수
    // private int inspection; // 일일 검사환자 수 
}