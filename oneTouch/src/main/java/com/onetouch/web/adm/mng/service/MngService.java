package com.onetouch.web.adm.mng.service;

import java.util.List;

import com.onetouch.web.adm.mng.dao.MngVO;

public interface MngService {
	List<MngVO> selectAll();
	List<MngVO> selectPrc();
	void delete(List<MngVO> list);
}
