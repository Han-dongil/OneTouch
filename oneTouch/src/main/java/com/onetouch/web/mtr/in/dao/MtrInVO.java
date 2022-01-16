package com.onetouch.web.mtr.in.dao;

import lombok.Data;

@Data
public class MtrInVO {
	private String inNo;
	private String inDate;
	private String compNm;
	private String mtrCd;
	private String mtrNm;
	private String ordNo;
	private String unit;
	private String inAmt;
	private String unitCost;
	private String totCost;
	private String fltAmt;
}