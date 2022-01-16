package com.onetouch.web.fct.prod.service;

import java.util.List;

import com.onetouch.web.fct.prod.dao.ProdVO;

public interface ProdService {

	List<ProdVO> prodSelect(ProdVO prodVSO);
	List<ProdVO> prodCheckSelectList(ProdVO prodVO);
}
