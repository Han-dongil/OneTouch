package com.onetouch.web.fct.info.dao;

import java.util.List;


public interface InfoMapper {

	List<InfoVO> selectFctInfoAll();
	InfoVO selectFctInfo(InfoVO infoVO);
	//삭제
	void deleteFctInfo(List<InfoVO> list);
	//등록
	void insertFctInfo(InfoVO infoVO);
}
