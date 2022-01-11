package com.onetouch.web.mtr.in.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.InSearchVO;
import com.onetouch.web.mtr.in.dao.InVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface InService {
	List<InVO> list();
	List<InSearchVO> select(InSearchVO inSearchVO);

	/* void modify(ModifyVO mvo); */
	/*
	 * void insert(InVO vo); void update(InVO vo); void delete(InVO vo);
	 */
	void modify(ModifyVO<InVO> mvo);
	
}
