package com.onetouch.web.adm.bom.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bom.dao.BomMapper;
import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.bom.service.BomService;

@Service
public class BomServiceImpl implements BomService {

	@Autowired BomMapper mapper;
	@Override
	public List<PrdVO> selectBomPrd(PrdVO prdvo) {
		return mapper.selectBomPrd(prdvo);
	}

	@Override
	public List<BomVO> selectBomDtl(BomVO bomvo) {
		return mapper.selectBomDtl(bomvo);
	}

	@Override
	public List<PrdVO> selectPrdAll() {
		return mapper.selectPrdAll();
	}

	@Override
	public List<PrdVO> selectUsePrd() {
		return mapper.selectUsePrd();
	}


}
