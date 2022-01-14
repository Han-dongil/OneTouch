package com.onetouch.web.pdt.work.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkMapper;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.pdt.work.service.WorkService;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired WorkMapper mapper;
	@Override
	public List<WorkVO> workList() {
		return mapper.workList();
	}
	@Override
	public List<PlanVO> planListView() {
		System.out.println(mapper.planListView());

		return mapper.planListView();
	}

	
}
