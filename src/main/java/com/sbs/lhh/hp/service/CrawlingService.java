package com.sbs.lhh.hp.service;

import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

@Service
public class CrawlingService {
	public void getCrawling() {
		String url = "https://www.sejong.go.kr/prog/fluInfo/listAjax.do";
		Document doc = null;
		try {
			doc = Jsoup.connect(url)
			        .header("origin", "https://www.sejong.go.kr/") // same-origin-polycy 로 인한 설정
			        .header("referer", "https://www.sejong.go.kr/") // same-origin-polycy 로 인한 설정
			        .ignoreContentType(true) // json 받아오려면 타입무시를 해야하는듯?
			        .get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String json = doc.select("body").text();
		
		
		
		//[{"searchCondition":"","searchKeyword":"","searchUseYn":"","pageIndex":1
		// ,"pageUnit":10,"pageSize":10,"firstIndex":1,"lastIndex":1,"recordCountPerPage":10
		// ,"searchKeywordFrom":"","searchKeywordTo":"","siteCode":null,"siteName":null
		// ,"mno":null,"tmplId":null,"tmplNo":0,"lang":"ko","searchStartDate":"","searchEndDate":""
		// ,"vodId":"","grantProgramId":null,"imgFileName":null,"imgUrl":null,"imgUrl300":null
		// ,"imgUrl920":null,"imgUrl1920":null,"imgDir":null,"imgFileCn":null
		// ,"managerYn":null,"groupCodeArr":null,"cntNo":1,"subject":"코로나19 현황판"
		
		// ,"baseDate":"9월 4일(금) 09시 기준","info1":"67","info2":"65","info3":"-"
		// ,"info4":"313","info5":"52","info6":"15","info7":"2","info8":"-","info9":"10"
		
		// ,"regDate":"2020-02-27 19:58:13.0","modDate":"2020-09-04 09:01:29.0"}]
		
		System.out.println("확인 : " + json);
		
	}
}
