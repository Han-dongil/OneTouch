package com.onetouch.web.mtr.stck.dao;

import lombok.Data;

@Data
public class LotVO {
	private String mtrLot;
	private String hldCnt;
	private String mtrCd;
	private String stckCnt;
	private String calAmt = "0";
	private String cmt;
	private String inNo;
	private String inDate;
	private String mngAmt;
	private String inAmt;
	private String seq;
	private String mtrNm;
	private String unitNm;
	private String mtrSectNm;
	private String mtrStckCnt;
	private String safeStck;
	private String useYn;
}
