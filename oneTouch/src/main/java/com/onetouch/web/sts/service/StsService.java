package com.onetouch.web.sts.service;

import java.util.List;

import com.onetouch.web.sts.dao.StsVO;

public interface StsService {
	
	//자재입고
	List<StsVO> mtrInDate();
	List<StsVO> mtrInMonth();
	List<StsVO> mtrInMtr();
}
