package com.onetouch.web.adm.flw.dao;

import java.util.List;

import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface FlwMapper {
	List<FlwVO> selectFlw(FlwVO flwvo);
	int deleteFlw(FlwVO flwvo);
	int insertFlw(FlwVO flwvo);
	void updateFlw(FlwVO flwvo);
	void bomFlwInsert(FlwVO flwvo);
	void bomFlwDelete(BomVO bomvo);
	void bomFlwUpdate(BomVO bomvo);
	List<FlwVO> selectPrcSeq(FlwVO flwvo);
	List<BomVO> selectFlwPrcBom(PlanVO vo);
}
