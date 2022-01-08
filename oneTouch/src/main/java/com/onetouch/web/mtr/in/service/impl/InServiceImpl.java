package com.onetouch.web.mtr.in.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.in.dao.InMapper;
import com.onetouch.web.mtr.in.dao.InVO;
import com.onetouch.web.mtr.in.service.InService;

@Service
public class InServiceImpl implements InService {
	@Autowired InMapper mapper;
	@Override
	public List<InVO> list() {
		return mapper.list();
	}

}
