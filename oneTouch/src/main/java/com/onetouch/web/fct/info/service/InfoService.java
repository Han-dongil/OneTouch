package com.onetouch.web.fct.info.service;

import java.util.List;

import com.onetouch.web.fct.info.dao.InfoVO;

public interface InfoService {
	List<InfoVO> selectFctInfoAll();
	void deleteFctInfo(List<InfoVO> list);
	
}
