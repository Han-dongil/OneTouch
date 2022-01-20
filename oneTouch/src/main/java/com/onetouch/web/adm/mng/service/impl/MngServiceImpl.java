package com.onetouch.web.adm.mng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.mng.dao.MngMapper;
import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.adm.mng.service.MngService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MngServiceImpl implements MngService{
	
	@Autowired MngMapper mapper;

	//modify
	@Override
	public void modify(ModifyVO<MngVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(MngVO mngvo : mvo.getCreatedRows()) {
				mapper.insertPrc(mngvo);
			};
		}
		if(mvo.getUpdatedRows() != null) {
			for(MngVO mngvo : mvo.getUpdatedRows()) {
				mapper.updatePrc(mngvo);
			};
		}
		if(mvo.getDeletedRows() != null) {
			for(MngVO mngvo : mvo.getDeletedRows()) {
				mapper.deletePrc(mngvo);
			};
		}
	}


	@Override
	public List<MngVO> selectPrcAll() {
		return mapper.selectPrcAll();
	}


	@Override
	public List<MngVO> selectUsePrc() {
		return mapper.selectUsePrc();
	}


	@Override
	public List<MngVO> selectPrcMng() {
		return mapper.selectPrcMng();
	}


	@Override
	public List<MngVO> selectPrc() {
		return mapper.selectPrc();
	}


	@Override
	public List<MngVO> selectUnit() {
		return mapper.selectUnit();
	}


}
