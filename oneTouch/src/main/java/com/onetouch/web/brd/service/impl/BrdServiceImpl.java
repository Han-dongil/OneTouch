package com.onetouch.web.brd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.onetouch.web.brd.dao.BrdMapper;
import com.onetouch.web.brd.service.BrdService;
import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.prd.prc.dao.PrcVO;

public class BrdServiceImpl implements BrdService {
	@Autowired BrdMapper mapper;

	@Override
	public List<LotVO> mtrList() {
		return mapper.mtrList();
	}

	@Override
	public List<FixVO> fctList() {
		return mapper.fctList();
	}

	@Override
	public List<PrcVO> pdtList() {
		return mapper.pdtList();
	}
	

}
