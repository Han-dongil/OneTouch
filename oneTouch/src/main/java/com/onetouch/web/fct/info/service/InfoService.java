package com.onetouch.web.fct.info.service;

import java.util.List;


import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.dao.LineVO;

public interface InfoService {

	//설비가 등록된 라인을 조회
	LineVO selectLineNo(LineVO lineVO);
	//공정 시작 설비상태 가동으로 변경
	void updateStartFctPhs();
	//설비 이름 조회
	InfoVO selectFctNm(InfoVO infoVO);
	//현재 날자 조회
	InfoVO todayDate();
	//라인수정
	int LineUpdate(LineVO lineVO);
	//라인삭제
	int LineDelete(LineVO lineVO);
	//라인조회
	List<LineVO> LineSelect(LineVO lineVO);
	int LineInsert(LineVO lineVO);
	
	//수정 
	int InfoUpdate(InfoVO infoVO);

	//검색조건 설비코드 조회 
	List<InfoVO> selectCheckFct(InfoVO infoVO);
	
	List<InfoVO> selectFctInfoAll(InfoVO infoVO);
	void deleteFctInfo(InfoVO infoVO);
	InfoVO selectFctInfo(InfoVO infoVO);
	void insertFctInfo(InfoVO infoVO);
	
	
}
