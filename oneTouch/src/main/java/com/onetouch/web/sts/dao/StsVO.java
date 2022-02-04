package com.onetouch.web.sts.dao;

import lombok.Data;

@Data
public class StsVO {
	
	private String inDate;		//입고일
	private String cnt;			//입고량
	private String mtrCd;		//자재코드
	private String startDate;	//날짜선택 범위 시작날짜
	private String endDate;		//날짜선택 범위 끝날짜
}
