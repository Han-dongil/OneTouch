package com.onetouch.web.fct.prod.dao;

import java.util.List;

public interface ProdMapper {
	
	void insertProd(ProdVO prodVO);
	void updateProd(ProdVO prodVO);
	void deleteProd(ProdVO prodVO);
	List<ProdVO> prodSelect(ProdVO prodVO);
	List<ProdVO> prodCheckSelectList(ProdVO prodVO);
}
