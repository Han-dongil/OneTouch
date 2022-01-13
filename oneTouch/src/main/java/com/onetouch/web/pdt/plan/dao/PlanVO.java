package com.onetouch.web.pdt.plan.dao;

import com.onetouch.web.mtr.lot.dao.LotVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PlanVO extends LotVO {
	private String planNo;
	private String ordShtNo;
	private String dueDate;
	private String workProt;
	private String planDate;
	private String planDtlNo;
	private String prdCd;
	private String prcCd;    
	private String needCnt;
	private String instrCnt;
	private String workStrDate;
	private String workPlanTime;
	
	
}
