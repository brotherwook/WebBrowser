package com.mycompany.project.model;

import java.util.Date;

public class ImageCapture {
	private int Ino;
	private String Iname;
	private Date Idate;
	private String Idata;
	
	public int getIno() {
		return Ino;
	}
	public void setIno(int ino) {
		Ino = ino;
	}
	public String getIname() {
		return Iname;
	}
	public void setIname(String iname) {
		Iname = iname;
	}
	public Date getIdate() {
		return Idate;
	}
	public void setIdate(Date idate) {
		Idate = idate;
	}
	public String getIdata() {
		return Idata;
	}
	public void setIdata(String idata) {
		Idata = idata;
	}
}
