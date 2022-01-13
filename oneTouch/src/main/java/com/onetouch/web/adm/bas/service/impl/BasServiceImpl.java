package com.onetouch.web.adm.bas.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasMapper;
import com.onetouch.web.adm.bas.dao.BasVO;
import com.onetouch.web.adm.bas.service.BasService;

@Service
public class BasServiceImpl implements BasService{

	@Autowired BasMapper mapper;
	@Override
	public List<BasVO> selectBasAll() {
		return mapper.selectBasAll();
	}
	@Override
	public List<BasVO> selectBasSrc(BasVO basvo) {
		return mapper.selectBasSrc(basvo);
	}
	@Override
	public List<BasDtlVO> selectBasDtl(BasDtlVO basDtlvo) {
		return mapper.selectBasDtl(basDtlvo);
	}
	@Override
	public List<BasDtlVO> selectBasDtlAll() {
		return mapper.selectBasDtlAll();
	}
	@Override
	public List<BasDtlVO> selectUseBasDtl(BasDtlVO basDtlvo) {
		return mapper.selectUseBasDtl(basDtlvo);
	}


}
