package com.onetouch.web.adm.bas.dao;

import lombok.Data;

@Data
public class BasDtlVO {

	private String dtlCd;	//상세코드
	private String dtlNm;	//상세코드명
	private String dtlCmt;	//상세코드설명
	private String seq;		//표시순서
	private String useYn;	//사용여부
	private String basCd;	//기초코드
}
