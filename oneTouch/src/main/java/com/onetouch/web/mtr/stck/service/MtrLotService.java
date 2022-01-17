package com.onetouch.web.mtr.stck.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.stck.dao.LotVO;

public interface MtrLotService {
	List<LotVO> listLot(MtrInVO vo);
	void insertLot(List<LotVO> list);
}
