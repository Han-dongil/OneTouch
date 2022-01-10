package com.onetouch.web.mtr.in.dao;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper=false)
public class InSearchVO extends InVO{

	String from;
	String to;
	String inComCd;
	String InComName;
	String dItemcode;
	String mtrCd;
	String gubun;
	String orderBy;
}

