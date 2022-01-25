package com.onetouch.web.mtr.out.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface MtrOutMapper {

	List<MtrOutVO> selectOut(MtrSearchVO searchVO);
	void mtrOutInsert(PlanVO vo);
}
