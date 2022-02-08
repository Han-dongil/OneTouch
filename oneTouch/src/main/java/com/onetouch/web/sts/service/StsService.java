package com.onetouch.web.sts.service;

import java.util.List;

import com.onetouch.web.sts.dao.StsVO;

public interface StsService {
	
	//자재입고
	List<StsVO> mtrInDate(StsVO stsvo);
	List<StsVO> mtrInMonth(StsVO stsvo);
	List<StsVO> mtrInYear(StsVO stsvo);
	List<StsVO> mtrInMtrD(StsVO stsvo);
	List<StsVO> mtrInMtrM(StsVO stsvo);
	List<StsVO> mtrInMtrY(StsVO stsvo);
	
	//자재출고
	List<StsVO> mtrOutDate(StsVO stsvo);
	List<StsVO> mtrOutMonth(StsVO stsvo);
	List<StsVO> mtrOutYear(StsVO stsvo);
	List<StsVO> mtrOutMtrD(StsVO stsvo);
	List<StsVO> mtrOutMtrM(StsVO stsvo);
	List<StsVO> mtrOutMtrY(StsVO stsvo);
	
	//제품생산
	List<StsVO> pdtDate(StsVO stsvo);
	List<StsVO> pdtMonth(StsVO stsvo);
	List<StsVO> pdtYear(StsVO stsvo);
	List<StsVO> pdtPrdD(StsVO stsvo);
	List<StsVO> pdtPrdM(StsVO stsvo);
	List<StsVO> pdtPrdY(StsVO stsvo);
	
	//제품불량
	List<StsVO> fltDate(StsVO stsvo);
	List<StsVO> fltMonth(StsVO stsvo);
	List<StsVO> fltYear(StsVO stsvo);
	List<StsVO> fltPrdD(StsVO stsvo);
	List<StsVO> fltPrdM(StsVO stsvo);
	List<StsVO> fltPrdY(StsVO stsvo);
}
