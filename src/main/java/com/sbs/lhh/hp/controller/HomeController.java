package com.sbs.lhh.hp.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.lhh.hp.dto.Article;
import com.sbs.lhh.hp.dto.CovidData;
import com.sbs.lhh.hp.service.ArticleService;
import com.sbs.lhh.hp.service.CrawlingService;

@Controller
public class HomeController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private CrawlingService crawlingService;
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		
		List<CovidData> covidDataList;
		try {
			covidDataList = crawlingService.getCovidDatas();
			
			model.addAttribute("covidDataList", covidDataList);
			System.out.println("메인 확인 : " + covidDataList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//[CovidData(country=합계, diffFromPrevDay=168, domesticInflow=0, overseasInflow=0, total=21,010, quarantine=4,668, quarantineRelease=16,009, death=333, incidence=40.52), 
		// CovidData(country=서울, diffFromPrevDay=51, domesticInflow=0, overseasInflow=0, total=4,251, quarantine=2,006, quarantineRelease=2,220, death=25, incidence=43.67), CovidData(country=부산, diffFromPrevDay=10, domesticInflow=0, overseasInflow=0, total=329, quarantine=89, quarantineRelease=236, death=4, incidence=9.64), CovidData(country=대구, diffFromPrevDay=5, domesticInflow=0, overseasInflow=0, total=7,077, quarantine=103, quarantineRelease=6,783, death=191, incidence=290.46), CovidData(country=인천, diffFromPrevDay=14, domesticInflow=0, overseasInflow=0, total=784, quarantine=303, quarantineRelease=478, death=3, incidence=26.52), CovidData(country=광주, diffFromPrevDay=8, domesticInflow=0, overseasInflow=0, total=413, quarantine=140, quarantineRelease=271, death=2, incidence=28.35), CovidData(country=대전, diffFromPrevDay=2, domesticInflow=0, overseasInflow=0, total=288, quarantine=88, quarantineRelease=197, death=3, incidence=19.54), CovidData(country=울산, diffFromPrevDay=1, domesticInflow=0, overseasInflow=0, total=112, quarantine=44, quarantineRelease=67, death=1, incidence=9.76), CovidData(country=세종, diffFromPrevDay=0, domesticInflow=0, overseasInflow=0, total=67, quarantine=9, quarantineRelease=58, death=0, incidence=19.57), CovidData(country=경기, diffFromPrevDay=50, domesticInflow=0, overseasInflow=0, total=3,578, quarantine=1,256, quarantineRelease=2,277, death=45, incidence=27), CovidData(country=강원, diffFromPrevDay=3, domesticInflow=0, overseasInflow=0, total=205, quarantine=75, quarantineRelease=127, death=3, incidence=13.31), CovidData(country=충북, diffFromPrevDay=4, domesticInflow=0, overseasInflow=0, total=139, quarantine=44, quarantineRelease=94, death=1, incidence=8.69), CovidData(country=충남, diffFromPrevDay=4, domesticInflow=0, overseasInflow=0, total=378, quarantine=147, quarantineRelease=230, death=1, incidence=17.81), CovidData(country=전북, diffFromPrevDay=2, domesticInflow=0, overseasInflow=0, total=89, quarantine=36, quarantineRelease=53, death=0, incidence=4.9), CovidData(country=전남, diffFromPrevDay=0, domesticInflow=0, overseasInflow=0, total=156, quarantine=109, quarantineRelease=47, death=0, incidence=8.37), CovidData(country=경북, diffFromPrevDay=1, domesticInflow=0, overseasInflow=0, total=1,473, quarantine=45, quarantineRelease=1,374, death=54, incidence=55.32), CovidData(country=경남, diffFromPrevDay=8, domesticInflow=0, overseasInflow=0, total=251, quarantine=63, quarantineRelease=188, death=0, incidence=7.47), CovidData(country=제주, diffFromPrevDay=1, domesticInflow=0, overseasInflow=0, total=48, quarantine=21, quarantineRelease=27, death=0, incidence=7.16), CovidData(country=검역, diffFromPrevDay=4, domesticInflow=0, overseasInflow=0, total=1,372, quarantine=90, quarantineRelease=1,282, death=0, incidence=-)]
		
	        
		int limit = 5;
		
		List<Article> articles = articleService.getForPrintLimitNoticeArticles(limit);

		model.addAttribute("boardId", 2);
		model.addAttribute("articles", articles);
		
		return "home/main";
	}
}

