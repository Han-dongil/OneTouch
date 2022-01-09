package com.onetouch.web.mtr.in.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.InSearchVO;
import com.onetouch.web.mtr.in.dao.InVO;

public interface InService {
	List<InVO> list();
	List<InSearchVO> select(InSearchVO inSearchVO);
	void delete(List<InVO> list);
}
