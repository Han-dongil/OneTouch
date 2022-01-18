package com.onetouch.web.adm.flt.dao;

import lombok.Data;

@Data
public class FltVO {
	private String fltCd;	//불량코드
	private String fltSect;	//불량구분
	private String fltNm;	//불량명
	private String fltMtt;	//불량내역
	private String prcCd;	//공정코드
	private String prcNm;	//공정명
	private String cmt;		//비고
	private String seq;		//순서
}
