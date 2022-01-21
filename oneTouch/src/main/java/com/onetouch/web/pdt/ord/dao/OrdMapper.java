package com.onetouch.web.pdt.ord.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface OrdMapper {
	List<OrdVO> list();
	List<OrdVO> select(OrdVO vo);
	void delete(List<OrdVO> list);
	void ordCheck(String ordShtNo);
	void ordCheck();
	List<PlanVO> ordShtSelect(String ordShtNo);
}
