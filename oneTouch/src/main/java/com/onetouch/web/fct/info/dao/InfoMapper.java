package com.onetouch.web.fct.info.dao;

import java.util.List;
import java.util.Map;

import com.onetouch.web.pdt.plan.dao.PlanVO;


public interface InfoMapper {

	List<Map<String, Object>> findFctList();
	//공정 시작할 때 설비 상태 가동 변경
	int updateEndFctPhs();
	int updateStartFctPhs();
	//설비이름 조회 
	InfoVO selectFctNm(InfoVO infoVO);
	//현재 날자 조회
	InfoVO todayDate();
	//라인수정
	int LineUpdate(LineVO lineVO);
	//라인삭제
	int LineDelete(LineVO lineVO);
	//라인 조회 
	List<LineVO> LineSelect(LineVO lineVO);
	
	int LineInsert(LineVO lineVO);
	
	//List<InfoVO> selectFctGubun(InfoVO infoVO);
	//공정관리테이블 join
	List<InfoVO> selectprcCd(PlanVO vo);
	
	//설비코드 조회 
	List<InfoVO> selectCheckFct();
	//설비관리 수정
	int InfoUpdate(InfoVO infoVO);
	//설비 등록 조회 
	List<InfoVO> selectFctInfoAll(InfoVO infoVO);
	InfoVO selectFctInfo(InfoVO infoVO);
	//삭제
	void deleteFctInfo(InfoVO infoVO);
	//등록
	void insertFctInfo(InfoVO infoVO);
	
	
	
}
