package com.onetouch.web.fct.dwtm.service;

import java.util.List;

import com.onetouch.web.fct.dwtm.dao.DwtmVO;

public interface DwtmService {

	List<DwtmVO> dwtmSelectAll(DwtmVO dwtmVO);
}
