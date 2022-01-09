package com.onetouch.web.fct.info.dao;

import java.util.List;


public interface InfoMapper {

	List<InfoVO> selectFctInfoAll();
	InfoVO selectFctInfo(InfoVO infoVO);
	void deleteFctInfo(List<InfoVO> list);
}
