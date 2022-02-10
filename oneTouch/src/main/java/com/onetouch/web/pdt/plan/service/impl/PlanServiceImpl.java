package com.onetouch.web.pdt.plan.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bom.dao.BomMapper;
import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.flw.dao.FlwMapper;
import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
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
	@Autowired InfoMapper infoMapper;	
	@Override
	public List<PlanVO> list(Map<String,String> nowPhs) {
		System.out.println(mapper.list(nowPhs));
		System.out.println("22222");
		return mapper.list(nowPhs);
	}
	@Override
	public List<PlanVO> selectDtl(String no) {
		
		return mapper.selectDtl(no);
	}
	@Override
	public List<PlanVO> findPrcCd(PlanVO vo) {
		// TODO Auto-generated method stub
		return mapper.findPrcCd(vo);
	}
	@Override
	public void insertPlan(ModifyVO<PlanVO> list) {
//		// TODO Auto-generated method stub
//		System.out.println(list);
//		if(list.getCreatedRows()!=null) {
//			for (PlanVO vo : list.getCreatedRows()) {
//				System.out.println(vo);
//				mapper.insertPlan(vo);
//				ordMapper.ordCheck(vo.getOrdShtNo());
//			}
//		}
//		if(list.getDeletedRows()!=null) {
//			for (PlanVO vo : list.getDeletedRows()) {
//				mapper.deletePlan(vo);
//			}
//		}
//		list = new ModifyVO<PlanVO>();
	}
	@Override
	public List<PlanVO> lotCntSelect(PlanVO vo) {
		return mapper.lotCntSelect(vo);
	}
	
	@Override
	public void insertPlanDtl(Map<String,List<PlanVO>> map) {
		List<PlanVO> list=map.get("detail");

		PlanVO inVo=map.get("plan").get(0);
		if(map.get("plan")!=null) {
			for(PlanVO vo:map.get("plan")) {
				System.out.println(vo);
				mapper.insertPlan(vo);
			}
		}
		if(list!=null) {
			for(PlanVO vo : list) {
				int date=mapper.dateCal(vo);
				for(int i=0 ;i<=date;i++) {
					vo.setDate(i);
					System.out.println(vo);
					System.out.println(mapper.test(vo));
					mapper.planDtlInsert(vo);
				}
				if(inVo.getOrdShtNo()!=null)
				ordMapper.ordCheck(inVo.getOrdShtNo());
			}
		}
		if(map.get("lot")!=null) {
			List<PlanVO> lotList=map.get("lot");
			for(PlanVO vo : lotList) {
				mapper.LotFindInsert(vo);
				mtrMapper.prdNeed(vo);
			}
		}
	}
	
	
	@Override
	public List<PlanVO> prdCdFind() {
		return mapper.selectPrd();
	}

	@Override
	public List<BomVO> prcCdFind(PlanVO vo) {
		return flwMapper.selectFlwPrcBom(vo);
	}
	@Override
	public void addInsertPlan(Map<String, List<PlanVO>> map) {
		List<PlanVO> list=map.get("detail");
		List<PlanVO> lotList=map.get("lot");
		PlanVO inVo=map.get("plan").get(0);
		ordMapper.ordCheck(inVo.getOrdShtNo());
		PlanVO nextSeq=mapper.findPlanSeq();
		mapper.insertPlan(inVo);
		int i=0;
		if(list!=null) {
			for(PlanVO vo : list) {
				vo.setPlanNo(nextSeq.getPlanNo());
				mapper.planDtlInsert(vo);
				i++;
			}
		}
		int k=0;//이거 나중에 수정해야댐.. 
		if(lotList!=null) {
			for(PlanVO vo : lotList) {
				mapper.LotFindInsert(vo);
				mtrMapper.prdNeed(vo);
				k++;
			}
		}
		
	}
	@Override
	public List<PlanVO> findBomList(PlanVO vo) {
		return mapper.findBomList(vo);
	}
	@Override
	public List<PlanVO> findLineNo(String prdCd) {
		String lines=mapper.findLineNo(prdCd).getLineNo();
		System.out.println(lines);
		String line[]=lines.split("/");
		List<PlanVO> list=new ArrayList<>();
		List<PlanVO> list2=new ArrayList<>();
		List<Integer> list3=new ArrayList<>();
		for(int i=0; i<line.length;i++) {
			PlanVO vo=new PlanVO();
			vo.setLineNo(line[i]);
			System.out.println(vo.getLineNo());
			list.add(vo);
		}
		list2=mapper.useFct();
		System.out.println(list);
		System.out.println(list2);
		
		for(int i =0 ; i< list.size() ;i++ ) {
			for(PlanVO vo2 : list2) {
				if(list.get(i).getLineNo().equals(vo2.getLineNo())) {
					list3.add(i);
				}
				
			}
		}
		System.out.println(list);
		System.out.println(list2);
		for(int i=0 ; i< list.size();i++) {
			for(int k=0 ; k<list2.size(); k++) {
				list.remove(list2.get(k));
			}
		}
		list=mapper.lineUphFind(list);
		System.out.println(list);
		return list;
	}
	@Override
	public List<PlanVO> prcLineFine(PlanVO vo) {
		return mapper.lineNoAndSeqFind(vo);
	}
	@Override
	public List<PlanVO> safeStckView() {
		return mapper.safeStckView();
	}
	@Override
	public List<PlanVO> slectDate(PlanVO vo) {
		return mapper.slectDate(vo);
	}
	@Override
	public List<PlanVO> planDateCal(PlanVO vo) {
		int date=mapper.strDateEndDateMinus(vo);
		List<PlanVO> list=new ArrayList<>();
		for(int i=0; i<=date ;i++) {
			vo.setDate(i);
			PlanVO a=mapper.dateArr(vo);
			PlanVO vo2=new PlanVO();
			vo2.setWorkStrDate(a.getWorkStrDate());
			list.add(vo2);
		}
		return list;
	}
	@Override
	public PlanVO updFind(String lineNo) {
		
		return mapper.updFind(lineNo);
	}
	@Override
	public List<PlanVO> addPlanLotSelect(PlanVO vo) {
		// TODO Auto-generated method stub
		return mapper.addPlanLotSelect(vo);
	}
	
	//return flwMapper.selectFlwPrcBom();//prd코드로 공정흐름// 공정관리 // bom join 불러오기
}
