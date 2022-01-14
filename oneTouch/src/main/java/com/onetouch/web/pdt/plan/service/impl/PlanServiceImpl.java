package com.onetouch.web.pdt.plan.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.inForm.dao.InMapper;
import com.onetouch.web.pdt.ord.dao.OrdMapper;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.plan.service.PlanService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class PlanServiceImpl implements PlanService {

	@Autowired PlanMapper mapper;
	@Autowired OrdMapper ordMapper;
	@Autowired InMapper mtrMapper;
	@Override
	public List<PlanVO> list() {
		return mapper.list();
	}
	@Override
	public List<PlanVO> selectDtl(String no) {
		
		return mapper.selectDtl(no);
	}
	@Override
	public List<PlanVO> findPrcCd(String no) {
		// TODO Auto-generated method stub
		return mapper.findPrcCd(no);
	}
	@Override
	public void insertPlan(ModifyVO<PlanVO> list) {
		// TODO Auto-generated method stub
		System.out.println(list);
		if(list.getCreatedRows()!=null) {
			for (PlanVO vo : list.getCreatedRows()) {
				System.out.println(vo);
				mapper.insertPlan(vo);
				ordMapper.ordCheck(vo.getOrdShtNo());
			}
		}
		if(list.getDeletedRows()!=null) {
			for (PlanVO vo : list.getDeletedRows()) {
				mapper.deletePlan(vo);
			}
		}
		list = new ModifyVO<PlanVO>();
	}
	@Override
	public List<PlanVO> lotCntSelect(PlanVO vo) {
		return mapper.lotCntSelect(vo);
	}
	
	@Override
	public void insertPlanDtl(ModifyVO<PlanVO> list) {
		if(list.getUpdatedRows()!=null) {
			for(PlanVO vo : list.getUpdatedRows()) {
				System.out.println("vo");
				mapper.planDtlInsert(vo);
				System.out.println("plandtl");
				PlanVO vo2=new PlanVO();
				vo2=mapper.findPlanSeq();
				System.out.println("planseq");
				System.out.println(vo2);
				vo.setPlanDtlNo(vo2.getPlanDtlNo());
				mapper.LotFindInsert(vo);
				System.out.println("findinsert");
				mtrMapper.prdNeed(vo);
				System.out.println("prdneed");
				
			}
		}
	}
	
}
