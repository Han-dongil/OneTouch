package com.onetouch.web.pdt.plan.service;

import java.util.List;
import java.util.Map;

import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface PlanService {
	List<PlanVO> list(Map<String,String> vo);
	List<PlanVO> selectDtl(String no);
	List<PlanVO> findPrcCd(PlanVO vo);
	void insertPlan(ModifyVO<PlanVO> list);
	List<PlanVO> lotCntSelect(PlanVO vo);
	void insertPlanDtl(Map<String,List<PlanVO>> map);
	List<PrdVO> prdCdFind();
	List<BomVO> prcCdFind(PlanVO vo);
	void addInsertPlan (Map<String,List<PlanVO>> map);
	List<PlanVO> addPlanLotSelect(PlanVO vo);
	List<PlanVO> findLineNo(String prdCd);
	List<InfoVO> prcLineFine(PlanVO vo);
}
