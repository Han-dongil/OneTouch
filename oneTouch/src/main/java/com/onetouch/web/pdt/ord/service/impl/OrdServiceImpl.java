package com.onetouch.web.pdt.ord.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.pdt.ord.dao.OrdMapper;
import com.onetouch.web.pdt.ord.dao.OrdVO;
import com.onetouch.web.pdt.ord.service.OrdService;

@Service
public class OrdServiceImpl implements OrdService {

	@Autowired OrdMapper mapper;
	@Override
	public List<OrdVO> list() {
		return mapper.list();
	}

}
