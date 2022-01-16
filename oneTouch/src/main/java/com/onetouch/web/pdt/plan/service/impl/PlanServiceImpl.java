package com.onetouch.web.pdt.plan.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.in.dao.MtrInMapper;
import com.onetouch.web.pdt.ord.dao.OrdMapper;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.plan.service.PlanService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class PlanServiceImpl implements PlanService {

	@Autowired PlanMapper mapper;
	@Autowired OrdMapper ordMapper;
	@Autowired MtrInMapper mtrMapper;
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
		PlanVO nextSeq=mapper.findPlanSeq();
		int seq=mapper.findPlanSeqOnlyNum();
		String newSeq=nextSeq.getPlanDtlNo().substring(0,11);
		int i=0;
		if(list.getUpdatedRows()!=null) {
			for(PlanVO vo : list.getUpdatedRows()) {
				
				mapper.planDtlInsert(vo);
				PlanVO vo2=new PlanVO();
				seq=seq+i;
				String a=newSeq+seq;
				vo.setPlanDtlNo(a);
				mapper.LotFindInsert(vo);
				mtrMapper.prdNeed(vo);
				
				i++;
				
			}
		}
	}
	
}
