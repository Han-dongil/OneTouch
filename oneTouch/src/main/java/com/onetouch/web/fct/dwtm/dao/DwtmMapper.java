package com.onetouch.web.fct.dwtm.dao;

import java.util.List;

public interface DwtmMapper {
	
	List<DwtmVO> dwtmSelect(DwtmVO dwtmVO);
	int dwtmInsert(DwtmVO dwtmVO);
	int dwtmUpdate(DwtmVO dwtmVO);
	int dwtmDelete(DwtmVO dwtmVO);
}
