package com.onetouch.web.mtr.in.dao;

import java.util.List;
import java.util.Map;

import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface MtrInMapper {

	//엑셀
	List<Map<String, Object>> selectExcelIn();
	List<MtrInVO> selectIn(MtrSearchVO inSearchVO);
	int selectInNo();
	List<MtrInVO> selectOrdNo(MtrSearchVO searchVO);
	void insertIn(MtrInVO vo);
	void deleteIn(MtrInVO vo);
	void updateIn(MtrInVO vo);
	void plusOrd(MtrInVO vo);
	void minusOrd(MtrInVO vo);
	void prdNeed(PlanVO vo);
}
