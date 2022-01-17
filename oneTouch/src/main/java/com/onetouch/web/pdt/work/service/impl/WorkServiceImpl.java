package com.onetouch.web.pdt.work.service.impl;

import java.util.List;
import java.util.Map;

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
	public List<PlanVO> planListView(String planNo) {
		return mapper.planJoinListView(planNo);
	}
	@Override
	public List<PlanVO> planList() {
		List<PlanVO> list=mapper.planList();
		return list;
	}
	@Override
	public List<PlanVO> findLotMtrCnt(PlanVO vo) {
		return mapper.findLotMtrCnt(vo);
	}
	@Override
	public void workInsert(Map<String,List<WorkVO>> map) {
		WorkVO seqVo=mapper.findWorkSeq();
		System.out.println("seq"+seqVo);
		System.out.println(map.get("planData").get(0).getWorkProt());
		mapper.workInsert(map.get("planData").get(0));
		for(WorkVO vo : map.get("detailData")) {
			vo.setPrdCd(map.get("planData").get(0).getPrdCd());
			vo.setInstrNo(seqVo.getInstrNo());
			System.out.println(vo.getInstrNo());
			mapper.workInsertDtl(vo);
		}
		
		
		
	}

	
}
