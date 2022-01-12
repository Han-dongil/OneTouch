package com.onetouch.web.adm.flt.dao;

import java.util.List;

public interface FltMapper {
	List<FltVO> selectFlt();
	List<FltVO> selectFltAll();
	List<FltVO> selectUseFlt();
}
