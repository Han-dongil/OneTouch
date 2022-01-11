package com.onetouch.web.adm.mtr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.onetouch.web.adm.mtr.dao.MtrMapper;
import com.onetouch.web.adm.mtr.dao.MtrVO;
import com.onetouch.web.adm.mtr.service.MtrService;

public class MtrServiceImpl implements MtrService{

	@Autowired	MtrMapper mapper;
	@Override
	public List<MtrVO> selectAdmMtrAll() {
		return mapper.selectAdmMtrAll();
	}

	@Override
	public List<MtrVO> selectAdmMtrDtl(MtrVO mtrvo) {
		return mapper.selectAdmMtrDtl(mtrvo);
	}

}