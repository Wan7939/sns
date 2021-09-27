package com.sns;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
//@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
public class SnsApplication {

	public static void main(String[] args) {
		SpringApplication.run(SnsApplication.class, args);
	}

}
