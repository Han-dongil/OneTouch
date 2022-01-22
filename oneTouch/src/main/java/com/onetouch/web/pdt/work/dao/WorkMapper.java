package com.onetouch.web.pdt.work.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface WorkMapper{
	List<PlanVO> planJoinListView(String planNo);
	List<WorkVO> workDetailSelect(String planNo);
	List<WorkVO> workList();
	List<PlanVO> planList(String planCheck);
	List<PlanVO> findLotMtrCnt(PlanVO vo);
	void workInsert(WorkVO vo);
	PlanVO workok();
	WorkVO findWorkSeq();
	void workInsertDtl(WorkVO vo);
	void LotFindUpdate(WorkVO vo);
	void prdNeed(WorkVO vo);

}
