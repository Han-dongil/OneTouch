package com.onetouch.web.mtr.stck.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;

public interface MtrLotMapper {
	List<LotVO> listLot(MtrSearchVO vo);
	List<LotVO> listMtr(MtrSearchVO vo);
	void insertLot(MtrInVO vo);
//	List<LotVO> selectLot(list);
}
