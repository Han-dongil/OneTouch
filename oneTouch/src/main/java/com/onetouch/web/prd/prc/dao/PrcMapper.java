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
	List<PrcVO> lineStartCheck(PrcVO vo);
	void endUpdate(PrcVO vo);
	PrcVO endTimeSelect(PrcVO vo);
	int endFlowCheck(PrcVO vo);
	List<PrcVO> lineEndCheck(PrcVO vo);
	String sectSelect(PrcVO vo);
	void prdInsert(PrcVO vo);
	void updateFlt(PrcVO vo);
	PrcVO realFlt(PrcVO vo);
	PrcVO insertLotSelect(PrcVO vo);
	void hrdInsert(PrcVO vo);
	PrcVO insertHrdLotSelect(PrcVO vo);
	void fastStop(PrcVO vo);
	void fastStopUpdate(PrcVO vo);
}
