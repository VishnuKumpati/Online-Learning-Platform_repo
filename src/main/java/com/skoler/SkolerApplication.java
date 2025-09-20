package com.skoler;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
public class SkolerApplication {

	public static void main(String[] args) {
		SpringApplication.run(SkolerApplication.class, args);
	}

}
