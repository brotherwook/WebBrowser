package com.mycompany.project.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.ImageCapture;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class ImageDao extends EgovAbstractMapper{
	private static final Logger LOGGER = LoggerFactory.getLogger(ImageDao.class);

	public void insert(ImageCapture imageCapture) {
		LOGGER.info("실행");
		int rows = insert("image.insert", imageCapture);
	}

	public List<ImageCapture> selectList() {
		List<ImageCapture> list  = selectList("image.select");
		return list;
	}
}
