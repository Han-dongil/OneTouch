package com.onetouch.web.zzz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.zzz.dao.MsgAltMapper;
import com.onetouch.web.zzz.dao.MsgAltVO;
import com.onetouch.web.zzz.service.MsgAltService;

@Service
public class MsgAltServiceImpl implements MsgAltService {

	@Autowired MsgAltMapper mapper;
	
	@Override
	public List<MsgAltVO> selectAll() {
		
		return mapper.selectAll();
	}

	@Override
	public List<MsgAltVO> selectDate(MsgAltVO vo) {
		
		return mapper.selectDate(vo);
	}
	
}
