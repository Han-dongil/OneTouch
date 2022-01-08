package com.onetouch.web.fct.info.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class InfoVO {
	
	String fctCd;		//설비코드 
	String fctNm;		//설비명
	String prcCd;		//공정코드
	String fctStd;		//설비규격?
	String fctModel;	//모델명
	String compCd;		//회사코드
	String usePurp;		//사용목적 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date inDate;		//입고일
	int purchCost;		//구매금액
	String chkProd;		//점검주기
	String FctImg;		//이미지
	int totPdtAmt;		//총생산량
	int uphPdtAmt;		//uph생산량
	String fctPhs;		//설비상태
	String useYn;		//사용여부
	String empNo;		//사번
	
	

}
