package com.onetouch.web.mtr.rtn.dao;

import com.onetouch.web.mtr.ord.dao.MtrOrdVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MtrRtnVO extends MtrOrdVO{
	private String rtnNo;
	private String rtnReqDate;
	private String rtnAmt;
	private String totCost;
	private String fltAmt;
	private String cmt;
	private String empNo;
}
