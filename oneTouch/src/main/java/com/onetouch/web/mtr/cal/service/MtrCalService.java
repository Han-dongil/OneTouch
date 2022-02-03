package com.onetouch.web.mtr.cal.service;

import java.util.List;

import com.onetouch.web.mtr.cal.dao.MtrCalVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MtrCalService {
	List<MtrCalVO> selectCal(MtrSearchVO inSearchVO);
	List<LotVO> selectLot(MtrCalVO mtrCalVO);
	void createCal(ModifyVO<MtrCalVO> mtrCalVO);
	void deleteCal(ModifyVO<MtrCalVO> mtrCalVO);
	
}
