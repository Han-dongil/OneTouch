package com.onetouch.web.sts.dao;

import java.util.List;

public interface StsMapper {
	
	//자재입고
	List<StsVO> mtrInDate();
	List<StsVO> mtrInMonth();
	List<StsVO> mtrInMtr();
}
