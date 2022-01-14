package com.onetouch.web.mtr.inForm.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface InMapper {
	List<InVO> list();
	List<InVO> select(InSearchVO inSearchVO);
	void insert(InVO vo);
	void delete(InVO vo);
	void update(InVO vo);
	void prdNeed(PlanVO vo);
}
