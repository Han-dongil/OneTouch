package com.onetouch.web.adm.flt.service;

import java.util.List;

import com.onetouch.web.adm.flt.dao.FltVO;

public interface FltService {
	List<FltVO> selectFlt();
	List<FltVO> selectFltAll();
	List<FltVO> selectUseFlt();
}
