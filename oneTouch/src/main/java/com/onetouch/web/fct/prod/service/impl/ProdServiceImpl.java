package com.onetouch.web.fct.prod.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.prod.dao.ProdMapper;
import com.onetouch.web.fct.prod.dao.ProdVO;
import com.onetouch.web.fct.prod.service.ProdService;

@Service
public class ProdServiceImpl implements ProdService {

	@Autowired ProdMapper mapper;
	@Override
	public List<ProdVO> prodSelect(ProdVO prodVSO) {
		
		return mapper.prodSelect(prodVSO);
	}
	@Override
	public List<ProdVO> prodCheckSelectList(ProdVO prodVO) {

		return mapper.prodCheckSelectList(prodVO);
	}

	
}
