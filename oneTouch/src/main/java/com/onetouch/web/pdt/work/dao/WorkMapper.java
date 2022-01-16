package com.onetouch.web.pdt.work.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface WorkMapper {
	List<PlanVO> planJoinListView(String planNo);
	List<WorkVO> workList();
	List<PlanVO> planList();
	List<PlanVO> findLotMtrCnt(PlanVO vo);

}
