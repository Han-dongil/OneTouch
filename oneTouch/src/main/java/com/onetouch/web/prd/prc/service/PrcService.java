package com.onetouch.web.prd.prc.service;

import java.util.List;

import com.onetouch.web.prd.prc.dao.PrcVO;

public interface PrcService {
	List<PrcVO> lineList();
	List<PrcVO> prcList(String lineNo);
	List<PrcVO> prdPrcList(PrcVO vo);
	PrcVO prcFlowMinMax(PrcVO vo);
	PrcVO prcEnd(PrcVO vo);
	PrcVO selectCheck(PrcVO vo);
	void updateFlt(PrcVO vo);
	void fastStop(PrcVO vo);
}
