package com.onetouch.web.adm.mng.dao;

import lombok.Data;

@Data
public class MngVO {

	private String prcCd;	//공정코드
	private String prcNm;	//공정명
	private String mngUnit; //단위
	private String pdtDay;	//생산일수
	private String dtmNm;	//공정구분
	private String cmt;		//비고
	private String seq;		//표시순서
	private String useYn;	//사용여부
}