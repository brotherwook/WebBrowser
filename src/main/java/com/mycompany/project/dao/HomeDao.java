package com.mycompany.project.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Sensor;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class HomeDao extends EgovAbstractMapper {
	public int insert(Sensor sensor) {
		int rows = insert("sensor.insertData", sensor);
		return rows;
	}
	
	public void updateTable() {
		int dataNo = selectOne("sensor.selectFirstData");
		delete("sensor.DeleteByDataNo", dataNo);
	}

	public List selectAll() {	
		return selectList("sensor.selectList");
	}
	
}
