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
		return "home/exam19_mqtt";
	}
	@RequestMapping("/yehna_web_mqtt.do")
	public String yehna_web_mqtt() {
		LOGGER.info("실행");
		return "home/yehna_web_mqtt";
	}
	@RequestMapping("/yehna_highchart.do")
	public String yehna_highchart() {
		LOGGER.info("실행");
		return "home/yehna_highchart";
	}
	@RequestMapping("/ui_test.do")
	public String ui_test() {
		LOGGER.info("실행");
		return "home/ui_test";
	}
	
	// ---------- MQTT Subscriber ----------
	// yehna_web_mqtt에서 json 데이터를 전달 받음
	@RequestMapping("/receivedData.do")
	public String receivedData(String buzzer, String dcmotor_speed, String dcmotor_dir,
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
		return "home/yehna_web_mqtt";
	}
	
	// ---------- MQTT Publisher ----------
	
	@RequestMapping("/cameraAngleMotor.do")
	public String cameraAngleMotor() {
		LOGGER.info("실행");
		return "home/cameraAngleMotor";
	}
	
	// ---------- 박성진 ----------------------
	@RequestMapping("/sungjin.do")
	public String sungjin() {
		LOGGER.info("실행");
		return "home/sungjin";
	}
	
	// --------------김형욱----------------------
	@RequestMapping("/drivepage.do")
	public String drivepage() {
		LOGGER.info("실행");
		return "home/drivepage";
	}

	@RequestMapping("/sensingpage.do")
	public String sensingpage() {
		LOGGER.info("실행");
		return "home/sensingpage";
	}

	// --------------주상민----------------------
	@RequestMapping("/jujeonMain.do")
	public String jujeonMain() {
		LOGGER.info("실행");
		return "home/jujeonMain";
	}
	

}
