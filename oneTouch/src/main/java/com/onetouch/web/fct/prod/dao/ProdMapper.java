package com.onetouch.web.fct.prod.dao;

import java.util.List;

public interface ProdMapper {
	
	//등록, 수정 구분해주는 정기점검 코드 조회 
	ProdVO selectFctProdChkNo(ProdVO prodVO);
	//예정 정기점검코드 조회
	ProdVO selectFctProd();
	//차기점검일 조회
	ProdVO selectchkExpectDt(ProdVO prodVO);
	void insertProd(ProdVO prodVO);
	void updateProd(ProdVO prodVO);
	void deleteProd(ProdVO prodVO);
	List<ProdVO> prodSelect(ProdVO prodVO);
	List<ProdVO> prodCheckSelectList(ProdVO prodVO);
}
