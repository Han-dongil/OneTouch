package com.onetouch.web.prd.prc.dao;

import java.util.List;

public interface PrcMapper {
	List<PrcVO> lineList();
	List<PrcVO> prcList(String lineNo);
	List<PrcVO> prdPrcList(PrcVO vo);
	List<PrcVO> prcFlowMinMax(PrcVO vo);
}
