package com.onetouch.web.adm.bom.dao;

import lombok.Data;

@Data
public class PrdVO {
	private String prdCd;	  //제품코드
	private String prdNm;	  //제품명
	private String prdStd;	  //제품규격코드
	private String prdStdNm;  //제품규격코드이름
	private String mngUnit;   //관리단위
	private String mngUnitNm; //관리단위이름
	private String useYn;	  //사용여부
	private String prdSect;	  //제품구분코드
	private String prdSectNm; //제품구분
	private String ableLineNo; //가능라인번호
}
