package com.onetouch.web.adm.bas.service;

import java.util.List;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface BasService {
	List<BasVO> selectBasAll(BasVO basvo);
	List<BasDtlVO> selectBasDtlAll();
	List<BasDtlVO> selectUseBasDtl(BasDtlVO basDtlvo);
	List<BasDtlVO> selectBasDtl(BasDtlVO basDtlvo);
	
	void modify(ModifyVO<BasDtlVO> mvo);
	void modifyBas(ModifyVO<BasVO> mvo);
}
