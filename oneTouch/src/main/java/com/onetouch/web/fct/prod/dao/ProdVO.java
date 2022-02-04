package com.onetouch.web.fct.prod.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ProdVO {

	String prodChkNo;
	String fctCd;
	String fctNm;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date chkDt;		//	점검완료일
	String chkExpectDt;		//	차기점검일  점검완료일인 chkDt 변수에 설비등록 테이블에 있는 점검 주기를 더해서 만들어준다.
	String chkRslt;  //	적합, 부적합 정기점검후 상태 표
	String msrMtt;	 // 교체, 수리, 정검
	String msrCmt;   //	작업내용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date fixTo;		//날짜조회	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date fixFrom;		//날짜조회
	int chkProd;		//점검주기
	String chkProdUnit;	//점검주기단위
	int dayDiff;
	
}
