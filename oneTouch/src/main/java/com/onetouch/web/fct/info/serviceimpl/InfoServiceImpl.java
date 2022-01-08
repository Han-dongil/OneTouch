package com.onetouch.web.fct.info.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.service.InfoService;
@Service
public class InfoServiceImpl implements InfoService {
	@Autowired InfoMapper mapper;
	
	@Override
	public List<InfoVO> selectFctInfoAll() {
		return mapper.selectFctInfoAll();
	}

	
}
