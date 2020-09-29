package com.sbs.lhh.hp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class HpApplication {

	public static void main(String[] args) {
		SpringApplication.run(HpApplication.class, args);
	}

}
