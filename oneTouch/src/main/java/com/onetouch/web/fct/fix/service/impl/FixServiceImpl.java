package com.onetouch.web.fct.fix.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.fix.dao.FixMapper;
import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.fct.fix.service.FixService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class FixServiceImpl implements FixService {

	@Autowired FixMapper fmapper;

		//조회 서비스 
	@Override
	public List<FixVO> fixSelectList(FixVO fixVO) {
		
		return fmapper.fixSelectList(fixVO);
	}

	@Override
	public void modify(ModifyVO<FixVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(FixVO fixVO : mvo.getCreatedRows()) {
				fmapper.insertFtc(fixVO);
			};
		}
		if(mvo.getUpdatedRows() != null) {
			for(FixVO fixVO : mvo.getUpdatedRows()) {
				fmapper.updateFtc(fixVO);
			};
		}
		if(mvo.getDeletedRows() != null) {
			for(FixVO fixVO : mvo.getDeletedRows()) {
				fmapper.deleteFtc(fixVO);
			};
		}
	}
		
}
	

