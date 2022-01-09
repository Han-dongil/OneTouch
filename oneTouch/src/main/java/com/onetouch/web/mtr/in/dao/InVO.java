package com.onetouch.web.mtr.in.dao;

import lombok.Data;

@Data
public class InVO {
	private String inNo;
	private String inDate;
	private String mtrCd;
	private String mtrNm;
	private String ordNo;
	private String unit;
	private String inAmt;
	private String unitCost;
	private String totCost;
	private String fltAmt;
}