package com.onetouch.web.mtr.stck.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrInVO;

public interface MtrLotMapper {
	List<LotVO> listLot(MtrInVO vo);
	void insertLot(MtrInVO vo);
//	List<LotVO> selectLot(list);
}
