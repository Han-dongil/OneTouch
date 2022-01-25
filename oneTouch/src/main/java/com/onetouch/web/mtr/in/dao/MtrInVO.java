package com.onetouch.web.mtr.in.dao;

import com.onetouch.web.mtr.stck.dao.LotVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MtrInVO extends LotVO{
	private String inNo;
	private String inDate;
	private String compNm;
	private String mtrCd;
	private String mtrNm;
	private String ordNo;
	private String unit;
	private String unitNm;
	private String inAmt;
	private String fltAmt;
	private String unitCost;
	private String totCost;
}