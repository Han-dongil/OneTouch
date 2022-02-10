package com.onetouch.web.fct.dwtm.dao;

import java.util.List;

public interface DwtmMapper {
	//비가동 시작시 설비상태 대기으로 변경
	int updateChangeFctDwtmWait(DwtmVO dwtmVO);
	//비가동 시작시 설비상태 비가동으로 변경
	int updateChangeFctDwtm(DwtmVO dwtmVO);
	List<DwtmVO> dwtmSelect(DwtmVO dwtmVO);
	int dwtmInsert(DwtmVO dwtmVO);
	int dwtmUpdate(DwtmVO dwtmVO);
	int dwtmDelete(DwtmVO dwtmVO);
}
