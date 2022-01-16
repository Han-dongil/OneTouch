package com.onetouch.web.mtr.outForm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.inForm.dao.SearchVO;
import com.onetouch.web.mtr.outForm.dao.OutMapper;
import com.onetouch.web.mtr.outForm.dao.OutVO;
import com.onetouch.web.mtr.outForm.service.OutService;

@Service
public class OutServiceImpl implements OutService {
	@Autowired OutMapper mapper;
	@Override
	public List<OutVO> selectOut(SearchVO searchVO) {
		return mapper.selectOut(searchVO);
	}
}
