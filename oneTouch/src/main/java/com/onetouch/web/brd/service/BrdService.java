package com.onetouch.web.brd.service;

import java.util.List;

import com.onetouch.web.fct.prod.dao.ProdVO;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.prd.prc.dao.PrcVO;

public interface BrdService {
	List<LotVO> mtrList();
	List<ProdVO> fctList();
	List<PrcVO> pdtList();
	String sysdate();
}
