package com.mycompany.project.model;

public class Sensor {
	int dataNo;
	double distance;
	double gas;
	double temperature;
	double photo;
	String time;
	
	public int getDataNo() {
		return dataNo;
	}
	public void setDataNo(int dataNo) {
		this.dataNo = dataNo;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public double getGas() {
		return gas;
	}
	public void setGas(double gas) {
		this.gas = gas;
	}
	public double getTemperature() {
		return temperature;
	}
	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}
	public double getPhoto() {
		return photo;
	}
	public void setPhoto(double photo) {
		this.photo = photo;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
}
