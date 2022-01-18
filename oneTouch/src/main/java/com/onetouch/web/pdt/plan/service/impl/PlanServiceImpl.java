package com.onetouch.web.pdt.plan.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bom.dao.BomMapper;
import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.flw.dao.FlwMapper;
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
	@Autowired FlwMapper flwMapper;
	@Autowired BomMapper bomMapper;
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
	public void insertPlanDtl(Map<String,List<PlanVO>> map) {
		List<PlanVO> list=map.get("detail");
		PlanVO inVo=map.get("plan").get(0);
		PlanVO nextSeq=mapper.findPlanSeq();
		
		mapper.insertPlan(inVo);
		int seq=mapper.findPlanSeqOnlyNum();
		PlanVO a=mapper.findPlanDTLSeq();
		String newSeq=a.getPlanDtlNo().substring(0,11);
		int i=0;
		if(list!=null) {
			for(PlanVO vo : list) {
				seq=seq+i;
				String b=newSeq+seq;
				vo.setPlanDtlNo(b);
				vo.setPlanNo(nextSeq.getPlanNo());
				mapper.planDtlInsert(vo);
				mapper.LotFindInsert(vo);
				vo.setHldCnt(vo.getInstrCnt());
				mtrMapper.prdNeed(vo);
				ordMapper.ordCheck(inVo.getOrdShtNo());
				
				i++;
				
			}
		}
	}
	
	
	@Override
	public List<PrdVO> prdCdFind() {
		return bomMapper.selectPrdAll();
	}

	@Override
	public List<BomVO> prcCdFind(PlanVO vo) {
		return flwMapper.selectFlwPrcBom(vo);
	}
	@Override
	public void addInsertPlan(Map<String, List<PlanVO>> map) {
		List<PlanVO> list=map.get("detail");
		PlanVO inVo=map.get("plan").get(0);
		PlanVO nextSeq=mapper.findPlanSeq();
		System.out.println("111111");
		mapper.insertPlan(inVo);
		int seq=mapper.findPlanSeqOnlyNum();
		PlanVO a=mapper.findPlanDTLSeq();
		System.out.println("2222");
		String newSeq=a.getPlanDtlNo().substring(0,11);
		int i=0;
		if(list!=null) {
			for(PlanVO vo : list) {
				seq=seq+i;
				String b=newSeq+seq;
				vo.setPlanDtlNo(b);
				vo.setPlanNo(nextSeq.getPlanNo());
				mapper.planDtlInsert(vo);
				System.out.println("3333");
				System.out.println(vo);
				mapper.LotFindInsert(vo);
				System.out.println("4444");
				vo.setHldCnt(vo.getInstrCnt());
				mtrMapper.prdNeed(vo);
				System.out.println("5555");
				ordMapper.ordCheck(inVo.getOrdShtNo());
				System.out.println("6666");
				
				i++;
				
			}
		}
		
	}
	@Override
	public List<PlanVO> addPlanLotSelect(PlanVO vo) {
		
		return mapper.addPlanLotSelect(vo);
	}
	
	//return flwMapper.selectFlwPrcBom();//prd코드로 공정흐름// 공정관리 // bom join 불러오기
}
