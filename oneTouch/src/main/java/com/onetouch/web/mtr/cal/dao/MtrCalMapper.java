package com.onetouch.web.mtr.cal.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;

public interface MtrCalMapper {

	List<MtrCalVO> selectCal(MtrSearchVO inSearchVO);
	List<LotVO> selectLot(MtrCalVO mtrCalVO);
	void insertCal(MtrCalVO mtrCalVO);
	void updateCal(MtrCalVO mtrCalVO);
	void deleteCal(MtrCalVO mtrCalVO);
	void minusCal(MtrCalVO mtrCalVO);
}
