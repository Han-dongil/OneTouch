package com.onetouch.web.adm.bas.dao;

import java.util.List;

public interface BasMapper {
	List<BasVO> selectBasAll(BasVO basvo);
	List<BasDtlVO> selectBasDtlAll();
	List<BasDtlVO> selectUseBasDtl(BasDtlVO basDtlvo);
	List<BasDtlVO> selectBasDtl(BasDtlVO basDtlvo);
	
	void insertBas(BasDtlVO basDtlvo);
	void updateBas(BasDtlVO basDtlvo);
}
