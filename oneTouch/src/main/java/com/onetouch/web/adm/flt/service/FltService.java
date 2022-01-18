package com.onetouch.web.adm.flt.service;

import java.util.List;

import com.onetouch.web.adm.flt.dao.FltVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface FltService {
	List<FltVO> selectFlt();
	List<FltVO> selectFltAll();
	List<FltVO> selectUseFlt();

	void modify(ModifyVO<FltVO> mvo);
}
