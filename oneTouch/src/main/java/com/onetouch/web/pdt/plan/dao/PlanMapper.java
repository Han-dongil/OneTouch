package com.onetouch.web.pdt.plan.dao;

import java.util.List;

public interface PlanMapper {
	
	List<PlanVO> list(String nowPhs);
	List<PlanVO> selectDtl(String no);
	List<PlanVO> findPrcCd(String no);
	void insertPlan(PlanVO vo);
	void deletePlan(PlanVO vo);
	List<PlanVO> lotCntSelect(PlanVO vo);
	void planDtlInsert(PlanVO vo);
	void LotFindInsert(PlanVO vo);
	PlanVO findPlanSeq();
	int findPlanSeqOnlyNum();
	PlanVO findPlanDTLSeq();
	List<PlanVO> addPlanLotSelect(PlanVO vo);
	
}
