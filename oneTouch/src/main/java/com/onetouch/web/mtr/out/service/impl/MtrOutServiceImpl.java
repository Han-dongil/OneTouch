package com.onetouch.web.mtr.out.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.out.dao.MtrOutMapper;
import com.onetouch.web.mtr.out.dao.MtrOutVO;
import com.onetouch.web.mtr.out.service.MtrOutService;

@Service
public class MtrOutServiceImpl implements MtrOutService {
	@Autowired MtrOutMapper mapper;
	@Override
	public List<MtrOutVO> selectOut(MtrSearchVO searchVO) {
		return mapper.selectOut(searchVO);
	}
}
