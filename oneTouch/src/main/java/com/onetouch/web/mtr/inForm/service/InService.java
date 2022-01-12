package com.onetouch.web.mtr.inForm.service;

import java.util.List;

import com.onetouch.web.mtr.inForm.dao.InSearchVO;
import com.onetouch.web.mtr.inForm.dao.InVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface InService {
	List<InVO> select(InSearchVO inSearchVO);

	/* void modify(ModifyVO mvo); */
	/*
	 * void insert(InVO vo); 
	 * void update(InVO vo); 
	 * void delete(InVO vo);
	 */
	void modify(ModifyVO<InVO> mvo);
	
}
