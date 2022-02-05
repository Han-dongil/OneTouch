package com.onetouch.web.pdt.work.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.out.dao.MtrOutMapper;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkMapper;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.pdt.work.service.WorkService;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired WorkMapper mapper;
	@Autowired PlanMapper planMapper;
	@Autowired MtrOutMapper mtrMapper;
	@Override
	public List<WorkVO> workList() {
		return mapper.workList();
	}
	@Override
	public List<WorkVO> workList(Map<String,String> map) {
		return mapper.workList(map);
	}
	@Override
	public List<WorkVO> workListDetail(WorkVO vo) {
		return  mapper.workListDetail(vo);
	}
	
	@Override
	public List<WorkVO> planListView(String planNo) {
		List<WorkVO> list=new ArrayList<>();
		List<WorkVO> list2=new ArrayList<>();
		WorkVO vo1 = new WorkVO();
		list =mapper.workDetailSelect(planNo);
		System.out.println(list);
		for (WorkVO vo : list) {
			vo.setInstrNo((mapper.findWorkSeq()).getInstrNo());
			list2.add(vo);
		}
		System.out.println(list2);
		return list2;
	}
	@Override
	public List<WorkVO> planList(String planCheck) {
		WorkVO vo1 = new WorkVO();
		vo1.setPlanCheck(planCheck);
		//List<WorkVO> list=mapper.workListDetail(vo1);
		List<WorkVO> list=mapper.planList(vo1);
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
		if(map.get("planData")!=null) {
			for(WorkVO vo : map.get("planData") ) {
				System.out.println(vo);
				mapper.workInsert(vo);
				vo.setNowPhs("Y");
				planMapper.planCheck(vo);
			}
		}
		if(map.get("detailData")!=null) {
			for(WorkVO vo : map.get("detailData")) {
				System.out.println(vo.getInstrNo());
				vo.setPdtCnt(vo.getNeedCnt());
				System.out.println("aaaaaaaaaaaa");
				mapper.workInsertDtl(vo);
			}
		}
		if(map.get("lotData")!=null) {
			for(WorkVO vo : map.get("lotData")) {
				
				mapper.LotFindUpdate(vo);
				mapper.prdNeed(vo);
				mtrMapper.mtrOutInsert(vo);
			}
		}
	}
}
