package com.onetouch.web.adm.flt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.flt.dao.FltMapper;
import com.onetouch.web.adm.flt.dao.FltVO;
import com.onetouch.web.adm.flt.service.FltService;

@Service
public class FltServiceImpl implements FltService{

	@Autowired FltMapper mapper;
	@Override
	public List<FltVO> selectFltAll() {
		return mapper.selectFltAll();
	}

}
