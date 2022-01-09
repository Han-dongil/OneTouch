package com.onetouch.web.pdt.plan.dao;

import java.util.List;

import com.onetouch.web.pdt.ord.dao.OrdVO;

public interface PlanMapper {
	
	List<PlanVO> list();
	List<PlanVO> selectDtl(String no);
}
