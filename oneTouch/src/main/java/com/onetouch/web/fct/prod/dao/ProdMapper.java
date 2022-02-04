package com.onetouch.web.fct.prod.dao;

import java.util.List;

public interface ProdMapper {
	
	//차기점검일 조회
	ProdVO selectchkExpectDt(ProdVO prodVO);
	void insertProd(ProdVO prodVO);
	void updateProd(ProdVO prodVO);
	void deleteProd(ProdVO prodVO);
	List<ProdVO> prodSelect(ProdVO prodVO);
	List<ProdVO> prodCheckSelectList(ProdVO prodVO);
}
