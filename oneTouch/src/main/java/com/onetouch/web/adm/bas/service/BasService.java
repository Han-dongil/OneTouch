package com.onetouch.web.adm.bas.service;

import java.util.List;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasVO;

public interface BasService {
	List<BasVO> selectBasAll();
	List<BasVO> selectBasSrc(BasVO basvo);
	List<BasDtlVO> selectBasDtlAll();
	List<BasDtlVO> selectUseBasDtl(BasDtlVO basDtlvo);
	List<BasDtlVO> selectBasDtl(BasDtlVO basDtlvo);
}
