package com.onetouch.web.sts.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.sts.dao.StsMapper;
import com.onetouch.web.sts.dao.StsVO;
import com.onetouch.web.sts.service.StsService;

@Service
public class StsServiceImpl implements StsService{

	@Autowired StsMapper mapper;
	
	//자재입고
	@Override
	public List<StsVO> mtrInDate() {
		return mapper.mtrInDate();
	}

	@Override
	public List<StsVO> mtrInMonth() {
		return mapper.mtrInMonth();
	}

	@Override
	public List<StsVO> mtrInMtr() {
		return mapper.mtrInMtr();
	}

}
