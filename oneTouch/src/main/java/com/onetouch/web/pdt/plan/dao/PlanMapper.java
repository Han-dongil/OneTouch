package com.onetouch.web.pdt.plan.dao;

import java.util.List;

import com.onetouch.web.mtr.stck.dao.LotVO;

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
	List<PlanVO> addPlanLotSelect(PlanVO vo);
	PlanVO findLineNo(String prdCd);
	
}
