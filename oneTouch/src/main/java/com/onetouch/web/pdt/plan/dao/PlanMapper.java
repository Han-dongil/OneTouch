package com.onetouch.web.pdt.plan.dao;

import java.util.List;

import com.onetouch.web.mtr.lot.dao.LotVO;

public interface PlanMapper {
	
	List<PlanVO> list();
	List<PlanVO> selectDtl(String no);
	List<PlanVO> findPrcCd(String no);
	void insertPlan(PlanVO vo);
	void deletePlan(PlanVO vo);
	List<PlanVO> lotCntSelect(PlanVO vo);
}
