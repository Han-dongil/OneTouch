package com.onetouch.web.adm.flw.dao;

import java.util.List;

import com.onetouch.web.adm.bom.dao.PrdVO;

public interface FlwMapper {
	List<PrdVO> selectFlwPrd();
	List<PrdVO> selectFlwPrdDtl(PrdVO prdvo);
	List<FlwVO> selectFlwAll(FlwVO flwvo);
}
