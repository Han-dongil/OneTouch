package com.onetouch.web.adm.flt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.flt.dao.FltMapper;
import com.onetouch.web.adm.flt.dao.FltVO;
import com.onetouch.web.adm.flt.service.FltService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class FltServiceImpl implements FltService{

	@Autowired FltMapper mapper;

	@Override
	public List<FltVO> selectFlt() {
		return mapper.selectFlt();
	}

	@Override
	public List<FltVO> selectFltAll() {
		return mapper.selectFltAll();
	}

	@Override
	public List<FltVO> selectUseFlt() {
		return mapper.selectUseFlt();
	}

	@Override
	public void modify(ModifyVO<FltVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(FltVO fltvo : mvo.getCreatedRows()) {
				mapper.insertFlt(fltvo);
			};
		}
		if(mvo.getUpdatedRows() != null) {
			for(FltVO fltvo : mvo.getUpdatedRows()) {
				mapper.updateFlt(fltvo);
			};
		}
		if(mvo.getDeletedRows() != null) {
			for(FltVO fltvo : mvo.getDeletedRows()) {
				mapper.deleteFlt(fltvo);
			};
		}
	}


}
