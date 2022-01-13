package com.onetouch.web.pdt.plan.service;

import java.util.List;

import com.onetouch.web.mtr.lot.dao.LotVO;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface PlanService {
	List<PlanVO> list();
	List<PlanVO> selectDtl(String no);
	List<PlanVO> findPrcCd(String no);
	void insertPlan(ModifyVO<PlanVO> list);
	List<PlanVO> lotCntSelect(PlanVO vo);
}
