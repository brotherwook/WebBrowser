package com.mycompany.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.ImageDao;
import com.mycompany.project.model.ImageCapture;

@Service
public class ImageService {
	private static final Logger LOGGER = LoggerFactory.getLogger(ImageService.class);
	
	@Autowired
	private ImageDao imageDao;
	
	public void save(ImageCapture imageCapture) {
		LOGGER.info("실행");
		imageDao.insert(imageCapture);
	}

	public List<ImageCapture> list() {
		LOGGER.info("실행");
		List<ImageCapture> list = imageDao.selectList();
		return list;
	}

}
