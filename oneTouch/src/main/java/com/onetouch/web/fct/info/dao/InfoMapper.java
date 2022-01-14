package com.onetouch.web.fct.info.dao;

import java.util.List;


public interface InfoMapper {

	//설비관리 수정
	int InfoUpdate(InfoVO infoVO);

	//설비 등록 조회 
	List<InfoVO> selectFctInfoAll(InfoVO infoVO);
	InfoVO selectFctInfo(InfoVO infoVO);
	//삭제
	void deleteFctInfo(List<InfoVO> list);
	//등록
	void insertFctInfo(InfoVO infoVO);
}
