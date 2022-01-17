package com.onetouch.web.adm.mng.dao;

import com.onetouch.web.adm.flw.dao.FlwVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MngVO extends FlwVO{

	private String prcCd;	  //공정코드
	private String prcNm;	  //공정명
	private String mngUnit;   //단위코드
	private String mngUnitNm; //단위
	private String pdtDay;	  //생산일수
	private String prcSectNm; //공정구분
	private String cmt;	  	  //비고
	private String seq;		  //표시순서
	private String useYn;	  //사용여부
	private String prcSect;	  //공정구분
}
