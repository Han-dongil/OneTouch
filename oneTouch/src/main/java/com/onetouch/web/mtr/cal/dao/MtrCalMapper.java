package com.onetouch.web.mtr.cal.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;

public interface MtrCalMapper {

	List<MtrCalVO> selectCal(MtrSearchVO inSearchVO);
//	int selectInNo();
//	void insertIn(MtrInVO vo);
//	void deleteIn(MtrInVO vo);
//	void updateIn(MtrInVO vo);
//	void updateOrd(MtrInVO vo);
//	void prdNeed(PlanVO vo);
}
