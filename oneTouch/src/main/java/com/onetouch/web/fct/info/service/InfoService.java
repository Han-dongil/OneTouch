package com.onetouch.web.fct.info.service;

import java.util.List;

import com.onetouch.web.fct.info.dao.AdmBasDtlCdVO;
import com.onetouch.web.fct.info.dao.InfoVO;

public interface InfoService {
	
	//공정코드와 공정 이름 가져오기 위해서 adm_bas_dtl_cd 테이블 조회
	List<AdmBasDtlCdVO> selectPrcCd();
	List<InfoVO> selectFctInfoAll();
	void deleteFctInfo(List<InfoVO> list);
	InfoVO selectFctInfo(InfoVO infoVO);
	void insertFctInfo(InfoVO infoVO);
	
}
