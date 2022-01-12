package com.onetouch.web.adm.flw.dao;

import lombok.Data;

@Data
public class FlwVO {
	private String prcSeq;		// 공정순서
	private String prcCd;		// 공정코드
	private String prcNm;		// 공정명
	private String workCmt;		// 작업설명
	private String stdLoad;		// 기준부하율
	private String unitCost;	// 단가
	private String leadTime;	// LEAD타임
	private String prdCd;		// 제품코드
}
