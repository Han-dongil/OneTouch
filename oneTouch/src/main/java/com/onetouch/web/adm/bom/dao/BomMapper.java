package com.onetouch.web.adm.bom.dao;

import java.util.List;

public interface BomMapper {
	List<PrdVO> selectBomPrd(PrdVO prdvo);
	List<BomVO> selectBomDtl(BomVO bomvo);
}
