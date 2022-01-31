package com.onetouch.web.fct.fix.dao;

import java.util.List;

public interface FixMapper {
	//생산공정에서 불량설비 수리요청 등록
	void insertRequestFixFtc(FixVO fixVO);
	//생상공정관리 테이블에 수리요청할 설비 조회 
	List<FixVO> prdPrcMngSelect();
	//수리테이블 조회 
	List<FixVO> fixSelectList(FixVO fixVO);
	void insertFtc(FixVO fixVO);
	void updateFtc(FixVO fixVO);
	void deleteFtc(FixVO fixVO);
	
}
