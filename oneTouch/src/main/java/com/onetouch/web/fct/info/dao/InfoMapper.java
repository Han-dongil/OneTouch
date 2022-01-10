package com.onetouch.web.fct.info.dao;

import java.util.List;


public interface InfoMapper {

	//공정코드와 공정 이름 가져오기 위해서 adm_bas_dtl_cd 테이블 조회
	List<AdmBasDtlCdVO> selectPrcCd();
	//설비 등록 조회 
	List<InfoVO> selectFctInfoAll();
	InfoVO selectFctInfo(InfoVO infoVO);
	//삭제
	void deleteFctInfo(List<InfoVO> list);
	//등록
	void insertFctInfo(InfoVO infoVO);
}
