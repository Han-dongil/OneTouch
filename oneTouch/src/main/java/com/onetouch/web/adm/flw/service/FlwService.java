package com.onetouch.web.adm.flw.service;

import java.util.List;

import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.flw.dao.FlwVO;

public interface FlwService {
	List<PrdVO> selectFlwPrd();
	List<PrdVO> selectFlwPrdDtl(PrdVO prdvo);
	List<FlwVO> selectFlwAll(FlwVO flwvo);
}
