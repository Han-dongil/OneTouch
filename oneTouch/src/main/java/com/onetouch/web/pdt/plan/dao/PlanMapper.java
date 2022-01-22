package com.onetouch.web.pdt.plan.dao;

import java.util.List;

import com.onetouch.web.pdt.work.dao.WorkVO;

public interface PlanMapper {
	
	List<PlanVO> list(String nowPhs);
	List<PlanVO> selectDtl(String no);
	List<PlanVO> findPrcCd(PlanVO vo);
	void insertPlan(PlanVO vo);
	void deletePlan(PlanVO vo);
	List<PlanVO> lotCntSelect(PlanVO vo);
	void planDtlInsert(PlanVO vo);
	void LotFindInsert(PlanVO vo);
	PlanVO findPlanSeq();
	List<PlanVO> addPlanLotSelect(PlanVO vo);
	PlanVO findLineNo(String prdCd);
	void planCheck(WorkVO vo);
	
}
