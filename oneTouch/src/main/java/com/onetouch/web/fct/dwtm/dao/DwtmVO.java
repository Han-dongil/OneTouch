package com.onetouch.web.fct.dwtm.dao;

import lombok.Data;

@Data

public class DwtmVO {
	String dwtmCd;
	String fctCd;
	String strDt;
	String finDt;
	String empNo;
	String msrMtt;
	String msrCmt;
	String fctNm;		//설비명
	String dwtmStartTime;
	String dwtmStartMinute;
	String dwtmEndTime;
	String dwtmEndMinute;
	String checkPrcCd;
	String proceedCheck; 	//진행중인 설비 보여주기 위한 조건값 담는 변수 
}
