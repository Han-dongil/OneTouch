package com.onetouch.web.adm.bom.dao;

import lombok.Data;

@Data
public class PrdVO {
	private String prdCd;	 //제품코드
	private String prdNm;	 //제품명
	private String prdStd;	 //제품규격
	private String mngUnit;	 //관리단위
	private String useYn;	 //사용여부
	private String prdSect;	 //제품구분
	private String fctCd;	 //설비코드
	private String stck; 	 //재고
	private String needCpnt; //필요부품 
}
