package com.onetouch.web.fct.info.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.service.InfoService;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
@Service
public class InfoServiceImpl implements InfoService {
	@Autowired InfoMapper mapper;
	@Autowired PlanMapper pmapper;
	
	@Override
	public List<InfoVO> selectFctInfoAll(InfoVO infoVO) {
		return mapper.selectFctInfoAll(infoVO);
	}


	@Override
	public void deleteFctInfo(List<InfoVO> list) {
		
		mapper.deleteFctInfo(list);
	}


	@Override
	public InfoVO selectFctInfo(InfoVO infoVO) {
		return mapper.selectFctInfo(infoVO);
	}


	@Override
	public void insertFctInfo(InfoVO infoVO) {
		mapper.insertFctInfo(infoVO);
		
	}





	@Override
	public int InfoUpdate(InfoVO infoVO) {
		
		return mapper.InfoUpdate(infoVO);
	}



	
}
