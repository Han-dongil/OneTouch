package com.onetouch.web.fct.fix.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.fct.fix.dao.FixMapper;
import com.onetouch.web.fct.fix.service.FixService;

@Service
public class FixServiceImpl implements FixService {

	@Autowired FixMapper mapper;

		//조회 서비스 
	@Override
	public List<FixVO> fixSelectList(FixVO fixVO) {
		
		return mapper.fixSelectList(fixVO);
	}
	
}
