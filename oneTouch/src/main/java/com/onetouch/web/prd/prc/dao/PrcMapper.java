package com.onetouch.web.prd.prc.dao;

import java.util.List;

public interface PrcMapper {
	List<PrcVO> lineList();
	List<PrcVO> prcList(String lineNo);
	List<PrcVO> prdPrcList(PrcVO vo);
	List<PrcVO> prcFlowMinMax(PrcVO vo);
	void defaultInsert(PrcVO vo);
	void startUpdate(PrcVO vo);
	PrcVO startTimeSelect(PrcVO vo);
	PrcVO myPrcFlow(PrcVO vo);
	int flowCheck(PrcVO vo);
	PrcVO lineStartCheck(PrcVO vo);
}
