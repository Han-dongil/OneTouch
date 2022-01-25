package com.onetouch.web.pdt.ord.service;

import java.util.List;

import com.onetouch.web.pdt.ord.dao.OrdVO;

public interface OrdService {
	List<OrdVO> list();
	List<OrdVO> select(OrdVO vo);
	void delete(List<OrdVO> list);
	OrdVO orderSeq();
	
}
