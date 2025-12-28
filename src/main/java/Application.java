package com.valtactics;

import java.util.Arrays;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SpringBootApplication
public class Application {
    private static final Logger logger = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
	   SpringApplication.run(Application.class, args);
    }

    @Bean
    public CommandLineRunner demo(MapsRepository m_repo) {
	   return (args) -> {
		  m_repo.save(new Maps("breeze", "breeze.jpg"));
		  m_repo.save(new Maps("fracture", "fracture.jpg"));

		  m_repo.findAll().forEach(maps -> {
			 logger.info(maps.toString());
		  });

	   };
    }

}
