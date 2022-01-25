package com.onetouch.web.mtr.cal.service;

import java.util.List;

import com.onetouch.web.mtr.cal.dao.MtrCalVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;

public interface MtrCalService {
	List<MtrCalVO> selectCal(MtrSearchVO inSearchVO);
	List<LotVO> selectLot(MtrCalVO mtrCalVO);

	/* void modify(ModifyVO mvo); */
	/*
	 * void insert(InVO vo); 
	 * void update(InVO vo); 
	 * void delete(InVO vo);
	 */
	//void modifyIn(ModifyVO<MtrInVO> mvo);
	
}
