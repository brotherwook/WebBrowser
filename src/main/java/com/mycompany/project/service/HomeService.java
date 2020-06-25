package com.mycompany.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.HomeDao;
import com.mycompany.project.model.Sensor;

@Service
public class HomeService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeService.class);
	@Autowired
	HomeDao homeDao;
	
	public void receiveData(Sensor sensor) {
		homeDao.insert(sensor);
		homeDao.updateTable();
	}

	public List<Sensor> selectAll() {
		return homeDao.selectAll();
	}
}
