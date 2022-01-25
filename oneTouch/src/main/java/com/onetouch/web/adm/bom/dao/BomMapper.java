package com.onetouch.web.adm.bom.dao;

import java.util.List;

public interface BomMapper {
	List<PrdVO> selectPrd(PrdVO prdvo);
	List<BomVO> selectBomDtl(BomVO bomvo);
	List<PrdVO> selectPrdAll();
	List<PrdVO> selectUsePrdAll();
	List<PrdVO> selectUsePrd();
	
	void insertPrd(PrdVO prdvo);
	void deletePrd(PrdVO prdvo);
	void updatePrd(PrdVO prdvo);
	 
	void deleteBom(BomVO bomvo);
	void updateBom(BomVO bomvo);
	void insertBom(BomVO bomvo);
}
