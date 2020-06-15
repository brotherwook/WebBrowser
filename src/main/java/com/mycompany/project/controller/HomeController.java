package com.mycompany.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class HomeController {

	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping("/main.do")
	public String main() {
		LOGGER.info("실행");
		return "home/main";
	}

	@RequestMapping("/exam19_mqtt.do")
	public String exam19_mqtt() {
		LOGGER.info("실행");
		return "home/yehna_web_mqtt";
	}
	
	@RequestMapping("/receivedData.do")
	public String receivedData(String tracker) throws Exception {
		LOGGER.info("실행");
		LOGGER.info("tracker: {}", tracker);
		return "home/yehna_web_mqtt";
	}
}
