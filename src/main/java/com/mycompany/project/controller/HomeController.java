package com.mycompany.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	
	// ---------- MQTT Subscriber ----------
	// yehna_web_mqtt에서 json 데이터를 전달 받음
	@RequestMapping("/receivedData.do")
	public void receivedData(String buzzer, String dcmotor_speed, String dcmotor_dir,
			String gas, String distance, String laser, String photo, String led, 
			String servo1, String servo2, String servo3, String servo4, String temperature,
			String tracker) throws Exception {
		LOGGER.info("---------------------------------");
		LOGGER.info("buzzer: {}", buzzer);
		LOGGER.info("dcmotor_speed: {}", dcmotor_speed);
		LOGGER.info("dcmotor_dir: {}", dcmotor_dir);
		LOGGER.info("gas: {}", gas);
		LOGGER.info("distance: {}", distance);
		LOGGER.info("laser: {}", laser);
		LOGGER.info("photo: {}", photo);
		LOGGER.info("led: {}", led);
		LOGGER.info("servo1: {}", servo1);
		LOGGER.info("servo2: {}", servo2);
		LOGGER.info("servo3: {}", servo3);
		LOGGER.info("servo4: {}", servo4);
		LOGGER.info("temperature: {}", temperature);
		LOGGER.info("tracker: {}", tracker);
	}
	
	@RequestMapping("/page2.do")
	public String page2() {
		LOGGER.info("실행");
		return "home/page2";
	}
	
	@RequestMapping("/page1.do")
	public String page1(HttpServletRequest request, HttpServletResponse response) {
		LOGGER.info("실행");
		String userData = request.getHeader("user-agent");
		LOGGER.info(userData);
		
		if(userData.contains("iPhone") || userData.contains("Android")) {
			return "home/mobile";
		}
		return "home/page1";
	}


}
