package com.onetouch.web.mtr.in.dao;

import java.util.List;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface MtrInMapper {

	List<MtrInVO> selectIn(MtrSearchVO inSearchVO);
	int selectInNo();
	void insertIn(MtrInVO vo);
	void deleteIn(MtrInVO vo);
	void updateIn(MtrInVO vo);
	void updateOrd(MtrInVO vo);
	void prdNeed(PlanVO vo);
}
