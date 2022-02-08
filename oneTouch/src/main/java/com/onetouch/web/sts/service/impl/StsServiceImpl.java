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
	
	//자재입고량
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
	
	//자재출고량
	@Override
	public List<StsVO> mtrOutDate(StsVO stsvo) {  return mapper.mtrOutDate(stsvo);  }

	@Override
	public List<StsVO> mtrOutMonth(StsVO stsvo) {  return mapper.mtrOutMonth(stsvo);  }

	@Override
	public List<StsVO> mtrOutYear(StsVO stsvo) {  return mapper.mtrOutYear(stsvo);  }

	@Override
	public List<StsVO> mtrOutMtrD(StsVO stsvo) {  return mapper.mtrOutMtrD(stsvo);  }

	@Override
	public List<StsVO> mtrOutMtrM(StsVO stsvo) {  return mapper.mtrOutMtrM(stsvo);  }

	@Override
	public List<StsVO> mtrOutMtrY(StsVO stsvo) {  return mapper.mtrOutMtrY(stsvo);  }
	
	//제품생산량
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

	//제품불량량
	@Override
	public List<StsVO> fltDate(StsVO stsvo) {  return mapper.fltDate(stsvo);  }

	@Override
	public List<StsVO> fltMonth(StsVO stsvo) {  return mapper.fltMonth(stsvo);  }

	@Override
	public List<StsVO> fltYear(StsVO stsvo) {  return mapper.fltYear(stsvo);  }

	@Override
	public List<StsVO> fltPrdD(StsVO stsvo) {  return mapper.fltPrdD(stsvo);  }

	@Override
	public List<StsVO> fltPrdM(StsVO stsvo) {  return mapper.fltPrdM(stsvo);  }

	@Override
	public List<StsVO> fltPrdY(StsVO stsvo) {  return mapper.fltPrdY(stsvo);  }

}
