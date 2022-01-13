package com.onetouch.web.mtr.ord.dao;

import lombok.Data;

@Data
public class MtrOrdVO {
	private String ordNo;
	private String ordDate;
	private String dlvReqDate;
	private String compCd;
	private String mtrCd;
	private String unit;
	private String unitCost;
	private String ordAmt;
	private String inAmt;
	private String notinAmt;
	private String cmt;
	private String startDate;
	private String endDate;
}
