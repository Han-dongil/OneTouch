package com.onetouch.web.pdt.work.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface WorkMapper {
	List<PlanVO> planListView();
	List<WorkVO> workList();

}
