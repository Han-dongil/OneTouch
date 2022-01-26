package com.onetouch.web.pdt.work.service;

import java.util.List;
import java.util.Map;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkVO;

public interface WorkService {
	List<WorkVO> workList();
	List<WorkVO> planListView(String planNo);
	List<PlanVO> planList(String planCheck);
	List<PlanVO> findLotMtrCnt(PlanVO vo);
	void workInsert(Map<String,List<WorkVO>> map);
	List<WorkVO> workListDetail(WorkVO vo);
	List<WorkVO> workList(Map<String,String> map);
}
