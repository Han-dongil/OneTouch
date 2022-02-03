package com.onetouch.web.brd.dao;

import java.util.List;

import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.prd.prc.dao.PrcVO;

public interface BrdMapper {
	List<LotVO> mtrList();
	List<FixVO> fctList();
	List<PrcVO> pdtList();
}
