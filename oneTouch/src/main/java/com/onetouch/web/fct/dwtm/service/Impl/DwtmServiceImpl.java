package com.onetouch.web.fct.dwtm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.dwtm.dao.DwtmMapper;
import com.onetouch.web.fct.dwtm.dao.DwtmVO;
import com.onetouch.web.fct.dwtm.service.DwtmService;

@Service
public class DwtmServiceImpl implements DwtmService {
	@Autowired DwtmMapper dmapper;
	
	//수리조회
	@Override
	public List<DwtmVO> dwtmSelectAll(DwtmVO dwtmVO) {
		return dmapper.dwtmSelect(dwtmVO);
	}

	@Override
	public int dwtmInsert(DwtmVO dwtmVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int dwtmUpdate(DwtmVO dwtmVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int dwtmDelte(DwtmVO dwtmVO) {
		// TODO Auto-generated method stub
		return 0;
	}

}
