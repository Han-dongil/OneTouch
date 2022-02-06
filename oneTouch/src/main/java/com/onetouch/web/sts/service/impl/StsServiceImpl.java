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
	public List<StsVO> mtrInDate(StsVO stsvo) {  return mapper.mtrInDate(stsvo);  }

	@Override
	public List<StsVO> mtrInMonth(StsVO stsvo) {  return mapper.mtrInMonth(stsvo);  }

	@Override
	public List<StsVO> mtrInYear(StsVO stsvo) {  return mapper.mtrInYear(stsvo);  }

	@Override
	public List<StsVO> mtrInMtrD(StsVO stsvo) {  return mapper.mtrInMtrD(stsvo);  }

	@Override
	public List<StsVO> mtrInMtrM(StsVO stsvo) {  return mapper.mtrInMtrM(stsvo);  }

	@Override
	public List<StsVO> mtrInMtrY(StsVO stsvo) {  return mapper.mtrInMtrY(stsvo);  }

	@Override
	public List<StsVO> pdtDate(StsVO stsvo) {  return mapper.pdtDate(stsvo);  }

	@Override
	public List<StsVO> pdtMonth(StsVO stsvo) {  return mapper.pdtMonth(stsvo);  }

	@Override
	public List<StsVO> pdtYear(StsVO stsvo) {  return mapper.pdtYear(stsvo);  }

	@Override
	public List<StsVO> pdtPrdD(StsVO stsvo) {  return mapper.pdtPrdD(stsvo);  }

	@Override
	public List<StsVO> pdtPrdM(StsVO stsvo) {  return mapper.pdtPrdM(stsvo);  }

	@Override
	public List<StsVO> pdtPrdY(StsVO stsvo) {  return mapper.pdtPrdY(stsvo);  }

}
