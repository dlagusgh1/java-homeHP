package com.sbs.lhh.hp.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.sbs.lhh.hp.dto.CovidData;

@Service
public class CrawlingService {
	
	public List<CovidData> getCovidDatas() throws IOException {
		
		String url = "http://ncov.mohw.go.kr/bdBoardList_Real.do?brdId=1&brdGubun=13";
		
        List<CovidData> covidDataList = new ArrayList<>();
        Document doc = Jsoup.connect(url).get();

        Elements contents = doc.select("table tbody tr");
        
        for(Element content : contents){
           Elements tdContents = content.select("td");
         
            CovidData covidData = CovidData.builder()
                    .country(content.select("th").text())	// 시도명
                    .diffFromPrevDay(Integer.parseInt(tdContents.get(0).text()))	// 전일대비 확진환자 증감
                    .total(tdContents.get(3).text())	// 합계
                    .quarantine(tdContents.get(4).text())	//	격리자 수
                    .quarantineRelease(tdContents.get(5).text()) // 격리해제 수
                    .death(Integer.parseInt(tdContents.get(6).text()))	// 사망자 수
                    .incidence(tdContents.get(7).text())	// 발병률
                    .build();
           
            covidDataList.add(covidData);
            
            // System.out.println("확인 : " + covidData);
            	
       }

        return covidDataList;
	
	}
	
}
