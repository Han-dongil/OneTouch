package com.onetouch.web.mtr.stck.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;

public interface MtrLotService {
	
	
	List<LotVO> listLot(MtrSearchVO vo);
	List<LotVO> listMtr(MtrSearchVO vo);
	void insertLot(List<LotVO> list);
}
