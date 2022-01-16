package com.onetouch.web.mtr.in.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MtrInService {
	List<MtrInVO> selectIn(MtrSearchVO inSearchVO);

	/* void modify(ModifyVO mvo); */
	/*
	 * void insert(InVO vo); 
	 * void update(InVO vo); 
	 * void delete(InVO vo);
	 */
	void modifyIn(ModifyVO<MtrInVO> mvo);
	
}
