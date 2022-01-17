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
	public void insertPlanDtl(List<PlanVO> list) {
		PlanVO nextSeq=mapper.findPlanSeq();
		System.out.println(nextSeq);
		System.out.println("11111");
		mapper.insertPlan(list.get(0));
		int seq=mapper.findPlanSeqOnlyNum();
		System.out.println(seq);
		System.out.println("22222");
		PlanVO a=mapper.findPlanDTLSeq();
		String newSeq=a.getPlanDtlNo().substring(0,11);
		System.out.println(newSeq);
		System.out.println("33333");
		int i=0;
		if(list!=null) {
			for(PlanVO vo : list) {
				seq=seq+i;
				String b=newSeq+seq;
				vo.setPlanDtlNo(b);
				vo.setPlanNo(nextSeq.getPlanNo());
				System.out.println(b);
				
				
				System.out.println("aaaaaa");
				
				System.out.println(vo.getPlanNo());
				mapper.planDtlInsert(vo);
				System.out.println("bbbbbbbb");
				System.out.println(vo);
				
				
				vo.setPlanNo(nextSeq.getPlanNo());
				System.out.println("ddddd");
				System.out.println(vo);
				mapper.LotFindInsert(vo);
				System.out.println("qqqqqqqqq");
				mtrMapper.prdNeed(vo);
				
				//i++;
				
			}
		}
	}
	
}
