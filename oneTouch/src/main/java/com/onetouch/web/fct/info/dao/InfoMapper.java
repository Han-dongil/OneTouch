package com.onetouch.web.fct.info.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;


public interface InfoMapper {

	
	//공정관리테이블 join
	List<InfoVO> selectprcCd(PlanVO vo);
	
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
