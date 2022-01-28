package com.onetouch.web.pdt.plan.dao;

import com.onetouch.web.mtr.stck.dao.LotVO;

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
	private String lineNo;
	private String prdCd;
	private String prcCd;    
	private String needCnt;
	private String instrCnt;
	private String workStrDate;
	private String workPlanTime;
	private String nowPhs;
	private String prdCd1;
	//bom 테이블 컬럼
	private String useAmt;
	private String mtrLot;
	private String realCnt;
	private String safeStck;
	
	
	
}
