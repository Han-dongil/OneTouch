package com.onetouch.web.adm.flw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.flw.dao.FlwMapper;
import com.onetouch.web.adm.flw.dao.FlwVO;
import com.onetouch.web.adm.flw.service.FlwService;

@Service
public class FlwServiceImpl implements FlwService{

	@Autowired FlwMapper mapper;
	@Override
	public List<PrdVO> selectFlwPrd() {
		return mapper.selectFlwPrd();
	}

	@Override
	public List<PrdVO> selectFlwPrdDtl(PrdVO prdvo) {
		return mapper.selectFlwPrdDtl(prdvo);
	}

	@Override
	public List<FlwVO> selectFlwAll(FlwVO flwvo) {
		return mapper.selectFlwAll(flwvo);
	}

}
