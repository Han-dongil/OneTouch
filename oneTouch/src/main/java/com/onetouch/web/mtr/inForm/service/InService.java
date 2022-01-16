package com.onetouch.web.mtr.inForm.service;

import java.util.List;

import com.onetouch.web.mtr.inForm.dao.InVO;
import com.onetouch.web.mtr.inForm.dao.SearchVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface InService {
	List<InVO> selectIn(SearchVO inSearchVO);

	/* void modify(ModifyVO mvo); */
	/*
	 * void insert(InVO vo); 
	 * void update(InVO vo); 
	 * void delete(InVO vo);
	 */
	void modifyIn(ModifyVO<InVO> mvo);
	
}
