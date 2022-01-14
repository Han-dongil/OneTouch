package com.onetouch.web.adm.bom.service;

import java.util.List;

import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.dao.PrdVO;

public interface BomService {
	List<PrdVO> selectPrd(PrdVO prdvo);
	List<BomVO> selectBomDtl(BomVO bomvo);
	List<PrdVO> selectPrdAll();
	List<PrdVO> selectUsePrdAll();
	List<PrdVO> selectUsePrd();
}