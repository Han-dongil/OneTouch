package com.onetouch.web.sts.dao;

import java.util.List;

public interface StsMapper {
	
	//자재입고
	List<StsVO> mtrInDate(StsVO stsvo);
	List<StsVO> mtrInMonth(StsVO stsvo);
	List<StsVO> mtrInYear(StsVO stsvo);
	List<StsVO> mtrInMtrD(StsVO stsvo);
	List<StsVO> mtrInMtrM(StsVO stsvo);
	List<StsVO> mtrInMtrY(StsVO stsvo);
}
