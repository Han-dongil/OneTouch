package com.onetouch.web.fct.info.dao;

import lombok.Data;

@Data
public class LineVO {

	String lineNO;		
	String totPdtAmt;	//총생산량
	String uphPdtAmt;	//uph생산량
	String useYn;		//사용여부
	String empNo;		//사원번호
	//설비 등록 input에서 클릭 했을 때는 사용중인 라인만 보기 위한 조건변수
	String fctLineChek;	
	int lineCnt;	//설비가 등록된 라인의 개수를 담는 변수
}
