package com.onetouch.web.mtr.inForm.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface InMapper {

	List<InVO> selectIn(InSearchVO inSearchVO);
	void insertIn(InVO vo);
	void deleteIn(InVO vo);
	void updateIn(InVO vo);
	void updateOrd(InVO vo);
	void prdNeed(PlanVO vo);
}
