package com.mycompany.project.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.model.Sensor;
import com.mycompany.project.service.HomeService;

@Controller
@RequestMapping("/home")
public class HomeController {

	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping("/main.do")
	public String main() {
		LOGGER.info("실행");
		return "home/main";
	}
	
	@Autowired
	HomeService homeService;
	// ---------- MQTT Subscriber ----------
	// yehna_web_mqtt에서 json 데이터를 전달 받음
	@RequestMapping("/receivedData.do")
	public void receivedData(String buzzer, String dcmotor_speed, String dcmotor_dir,
			String gas, String distance, String laser, String photo, String led, 
			String servo1, String servo2, String servo3, String servo4, String temperature,
			String tracker) throws Exception {
		
		Sensor sensor = new Sensor();
		sensor.setDistance(Double.parseDouble(distance));
		sensor.setGas(Double.parseDouble(gas));
		sensor.setPhoto(Double.parseDouble(photo));
		sensor.setTemperature(Double.parseDouble(temperature));
		
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
		
		homeService.receiveData(sensor);
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
	
	@RequestMapping("/highchartplot.do")
	public void highchartplot(HttpServletResponse response) throws Exception {
		LOGGER.info("실행");
		List<Sensor> sensorlist = homeService.selectAll();
		
		response.setContentType("application/json; charset=UTF-8");
		JSONObject jsonObject = new JSONObject();
		
		double[] dist = new double[20];
		double[] temperature = new double[20];
		double[] gas = new double[20];
		double[] photo = new double[20];
		
		int index = 0;
		for(Sensor sensor : sensorlist) {
			dist[index] = sensor.getDistance();
			temperature[index] = sensor.getTemperature();
			gas[index] = sensor.getGas();
			photo[index] = sensor.getPhoto();
			index++;
			
			if(index >= 20) break;
		}
		
		jsonObject.put("dist", dist);
		jsonObject.put("temperature", temperature);
		jsonObject.put("gas", gas);
		jsonObject.put("photo", photo);
		PrintWriter pw = response.getWriter();
		pw.write(jsonObject.toString());
		pw.flush();
		pw.close();
		
	}
	
}
