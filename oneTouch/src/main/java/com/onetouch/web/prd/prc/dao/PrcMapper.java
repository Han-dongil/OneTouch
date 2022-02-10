package com.onetouch.web.prd.prc.dao;

import java.util.List;

import com.onetouch.web.pdt.work.dao.WorkVO;

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
	void planPhsUpdate(PrcVO vo);
	List<PrcVO> usedlotFind(PrcVO vo); 
	List<PrcVO> prcMovingView(PrcVO vo);
	int updateCheck();
	int prcFlowCount(PrcVO vo);
	int prcPlayCount();
	List<PrcVO> movingSearchList(PrcVO vo);
	List<PrcVO> movingSearchListFinish(PrcVO vo);
	List<PrcVO> autoSelect();
	int uphFind(PrcVO vo);
	void autoUpdate(PrcVO vo);
	void autoFltUpdate(PrcVO vo);
	List<PrcVO> playStartInstr();
	List<PrcVO> liveInstr(PrcVO vo);
	List<PrcVO> playingPrcFind(PrcVO vo);
	PrcVO autoFltSum(PrcVO vo);
}
