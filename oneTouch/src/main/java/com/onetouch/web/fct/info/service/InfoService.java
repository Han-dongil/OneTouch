package com.onetouch.web.fct.info.service;

import java.util.List;


import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.dao.LineVO;

public interface InfoService {
	
	//현재 날자 조회
	InfoVO todayDate();
	//라인삭제
	int LineDelete(LineVO lineVO);
	//라인조회
	List<LineVO> LineSelect(LineVO lineVO);
	int LineInsert(LineVO lineVO);
	
	//수정 
	int InfoUpdate(InfoVO infoVO);

	List<InfoVO> selectFctInfoAll(InfoVO infoVO);
	void deleteFctInfo(List<InfoVO> list);
	InfoVO selectFctInfo(InfoVO infoVO);
	void insertFctInfo(InfoVO infoVO);
	
	
}
