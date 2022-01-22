package com.onetouch.web.fct.info.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.onetouch.web.adm.mng.dao.MngVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)			
public class InfoVO extends MngVO  {
	
	String fctCd;		//설비코드 
	String fctNm;		//설비명
	String prcCd;		//공정코드
	String fctStd;		//설비규격?
	String fctModel;	//모델명
	String compCd;		//회사코드
	String usePurp;		//공정분류 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date inDate;		//입고일	
	int purchCost;		//구매금액
	String chkProd;		//점검주기
	String FctImg;		//이미지
	int totPdtAmt;		//총생산량
	int uphPdtAmt;		//uph생산량
	String fctPhs;		//설비상태
	String useYn;		//사용여부
	String empNo;		//사번
	String checkPrcCd; //설비 조회 페이지에서 검색 조건으로 선택하는 공정코드를 담는 변수 
	String checkRadio;	//설비수리 페이지 에서 radio value값을 담는 변수 
	String lineNo;
	String prcNm;		//공정이름
	
	
	
	
	

}
