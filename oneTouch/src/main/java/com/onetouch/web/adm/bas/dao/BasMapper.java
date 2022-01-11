package com.onetouch.web.adm.bas.dao;

import java.util.List;

public interface BasMapper {
	List<BasVO> selectBasAll();
	List<BasVO> selectBasSrc(BasVO basvo);
	List<BasDtlVO> selectBasDtl(BasDtlVO basDtlvo);
}
