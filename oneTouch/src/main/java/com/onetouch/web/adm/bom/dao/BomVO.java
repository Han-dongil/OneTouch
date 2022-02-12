package com.onetouch.web.adm.bom.dao;

import com.onetouch.web.adm.mng.dao.MngVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BomVO extends MngVO{
	
	private String mtrCd;	//자재코드
	private String mtrNm;	//자재명
	private String useAmt;	//사용량
	private String ordChk;	//발주
	private String pdtChk;	//생산
	private String prcCd;	//공정코드
	private String prcNm;	//공정명
	private String cmt;		//비고
	private String prdCd;	//제품코드
	private String bomCd;	//bom코드
	private String prcSeq;	//prcSeq
}
