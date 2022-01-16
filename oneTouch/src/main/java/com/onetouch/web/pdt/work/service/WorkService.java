package com.onetouch.web.pdt.work.service;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkVO;

public interface WorkService {
	List<WorkVO> workList();
	List<PlanVO> planListView(String planNo);
	List<PlanVO> planList();
	List<PlanVO> findLotMtrCnt(PlanVO vo);
}
