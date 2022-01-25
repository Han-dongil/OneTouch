package com.onetouch.web.mtr.cal.dao;

import lombok.Data;

@Data
public class MtrCalVO{
	private String calNo;
	private String mtrLot;
	private String mtrCd;
	private String mtrNm;
	private String calDate;
	private String calSect;
	private String calSectNm;
	private String unit;
	private String unitNm;
	private String calAmt;
	private String cmt;
}
