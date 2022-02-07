package com.onetouch.web.pdt.plan.dao;

import java.util.List;
import java.util.Map;

import com.onetouch.web.pdt.work.dao.WorkVO;

public interface PlanMapper {
	
	List<PlanVO> list(Map<String,String> map);
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
	List<PlanVO> pdtPlanDtllist(PlanVO vo);
	List<PlanVO> safeStckView();
	List<PlanVO> selectPrd();
	int dateCal(PlanVO vo);
	PlanVO test(PlanVO vo);	
	List<PlanVO> slectDate(PlanVO vo);
	List<PlanVO> useFct();
	List<PlanVO> lineUphFind(List<PlanVO> list);
	int strDateEndDateMinus(PlanVO vo);
	PlanVO dateArr(PlanVO vo);
	PlanVO updFind(String lineNo);
	List<PlanVO> lineNoAndSeqFind(PlanVO vo);
	
}
