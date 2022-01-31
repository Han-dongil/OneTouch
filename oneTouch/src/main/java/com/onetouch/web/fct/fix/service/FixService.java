package com.onetouch.web.fct.fix.service;

import java.util.List;

import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface FixService {

	
	void prdPrcMngSelect();
	List<FixVO> fixSelectList(FixVO fixVO);
	void modify(ModifyVO<FixVO> mvo);
}
