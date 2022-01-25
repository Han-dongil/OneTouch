package com.onetouch.web.prd.prc.dao;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrcVO extends WorkVO{
	
	private String instrNo;
	private String lineNo;
	private String prcCd;
	private String workStrDt;
	private String workFinDt;
	private String goalCnt;
	private String pdtCnt;
	private String fltCnt;
	private String nowPhs;
	private String prdLot;
	//공정흐름 필드
	private String prcSeq;
	private int prcEndNull;
	private String prdSect; 
	//메세지
	private String msg;
	//동기화
	private String sumFlt;
	
}
