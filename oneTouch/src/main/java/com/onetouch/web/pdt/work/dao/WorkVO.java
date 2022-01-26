package com.onetouch.web.pdt.work.dao;

import com.onetouch.web.pdt.plan.dao.PlanVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class WorkVO extends PlanVO{
	private String instrNo;
	private String planNo;
	private String workProt;
	private String instrDate;
	private String pdtFinDate;
	private String prdCd;
	private String instrCnt;
	private String pdtCnt;
	private String prcCd;
	private String workStrDate;
	private String workStrTime;
	private String bomCd;
	
	//////////////////////////////////
	private String startDate;
	private String endDate;
	
}
