package com.onetouch.web.pdt.work.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.pdt.plan.dao.PlanMapper;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkMapper;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.pdt.work.service.WorkService;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired WorkMapper mapper;
	@Autowired PlanMapper planMapper;
	@Override
	public List<WorkVO> workList() {
		WorkVO vo = new WorkVO();
		
		return mapper.workList();
	}
	
	@Override
	public List<WorkVO> planListView(String planNo) {
		System.out.println(planNo);
		System.out.println("00000");
		List<WorkVO> list=new ArrayList<>();
		List<WorkVO> list2=new ArrayList<>();
		list =mapper.workDetailSelect(planNo);
		System.out.println(list);
		for (WorkVO vo : list) {
			System.out.println("111111111111111");
			vo.setInstrNo((mapper.findWorkSeq()).getInstrNo());
			System.out.println("2222222222222222");
			list2.add(vo);
		}
		System.out.println(list2);
		return list2;
	}
	@Override
	public List<PlanVO> planList(String planCheck) {
		List<PlanVO> list=mapper.planList(planCheck);
		return list;
	}
	@Override
	public List<PlanVO> findLotMtrCnt(PlanVO vo) {
		System.out.println("dddddddd");
		System.out.println(mapper.findLotMtrCnt(vo));
		System.out.println(vo);
		return mapper.findLotMtrCnt(vo);
	}
	@Override
	public void workInsert(Map<String,List<WorkVO>> map) {
		WorkVO seqVo=mapper.findWorkSeq();

		
		System.out.println("seq"+seqVo);
		if(map.get("planData")!=null) {
			for(WorkVO vo : map.get("planData") ) {
				System.out.println("1111111");
				mapper.workInsert(vo);
				planMapper.planCheck(vo);
				
			}
		}
		if(map.get("detailData")!=null) {
			for(WorkVO vo : map.get("detailData")) {
				System.out.println("2222222");
				System.out.println(vo.getInstrNo());
				vo.setPdtCnt(vo.getNeedCnt());
				mapper.workInsertDtl(vo);
			}
		}
		if(map.get("lotData")!=null) {
			for(WorkVO vo : map.get("lotData")) {
				
				System.out.println("333333333");
				System.out.println(vo);
				mapper.LotFindUpdate(vo);
				System.out.println(vo);
				System.out.println("444444444");
				mapper.prdNeed(vo);
			}
		}
		
		
		
	}

	
}
