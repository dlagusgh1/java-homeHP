package com.sbs.lhh.hp.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@ToString
@Builder
@Getter
public class CovidData {
	private String country; // 시도명
    private int diffFromPrevDay; // 전일대비확진환자증감
    private int domesticInflow; // 국내유입
    private int overseasInflow; // 해외유입
    private String total; // 확진환자수
    // private int cure;// 완치자수
    private String quarantine; // 격리자수
    private String quarantineRelease;// 격리해제자 수
    private int death; // 사망자수
    private String incidence; // 발병률
    // private int inspection; // 일일 검사환자 수 
}