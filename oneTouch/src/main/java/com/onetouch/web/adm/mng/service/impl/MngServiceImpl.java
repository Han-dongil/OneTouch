package com.onetouch.web.adm.mng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.mng.dao.MngMapper;
import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.adm.mng.service.MngService;

@Service
public class MngServiceImpl implements MngService{
	
	@Autowired MngMapper mapper;
	@Override
	public List<MngVO> selectAll() {
		return mapper.selectAll();
	}

	@Override
	public List<MngVO> selectPrc() {
		return mapper.selectPrc();
	}

	@Override
	public void delete(List<MngVO> list) {
		mapper.delete(list);
	}



}
