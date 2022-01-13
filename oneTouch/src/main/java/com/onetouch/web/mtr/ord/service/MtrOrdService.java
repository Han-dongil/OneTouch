package com.onetouch.web.mtr.ord.service;

import java.util.List;

import com.onetouch.web.mtr.ord.dao.MtrOrdVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MtrOrdService {
	List<MtrOrdVO> select(MtrOrdVO vo);

	/* void modify(ModifyVO mvo); */
	/*
	 * void insert(InVO vo); 
	 * void update(InVO vo); 
	 * void delete(InVO vo);
	 */
	void modify(ModifyVO<MtrOrdVO> mvo);
	
}
