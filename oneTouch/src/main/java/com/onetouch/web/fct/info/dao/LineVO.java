package com.onetouch.web.fct.info.dao;

import lombok.Data;

@Data
public class LineVO {

	String lineNo;		
	String totPdtAmt;	//총생산량
	String uphPdtAmt;	//uph생산량
	String useYn;		//사용여부
	String empNo;		//사원번호
}
