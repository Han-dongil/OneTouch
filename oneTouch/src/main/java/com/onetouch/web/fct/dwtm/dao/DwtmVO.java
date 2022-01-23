package com.onetouch.web.fct.dwtm.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data

public class DwtmVO {
	String dwtmCd;
	String fctCd;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date strDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date finDt;
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
