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
	public List<FlwVO> selectFlw(FlwVO flwvo) {
		return mapper.selectFlw(flwvo);
	}


}
