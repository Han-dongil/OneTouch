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
}
