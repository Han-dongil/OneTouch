package com.onetouch.web.adm.flw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.flw.dao.FlwMapper;
import com.onetouch.web.adm.flw.dao.FlwVO;
import com.onetouch.web.adm.flw.service.FlwService;
import com.onetouch.web.zzz.dao.ModifyVO;


@Service
public class FlwServiceImpl implements FlwService{

	@Autowired FlwMapper mapper;

	@Override
	public List<FlwVO> selectFlw(FlwVO flwvo) {
		System.out.println("serviceimpl"+ mapper.selectFlw(flwvo));
		return mapper.selectFlw(flwvo);
	}

	@Override
	public void modify(ModifyVO<FlwVO> mvo) {
		if(mvo.getUpdatedRows() != null) {
			for(FlwVO flwvo : mvo.getUpdatedRows()) {
				mapper.updateFlw(flwvo);
			};
		}
		if(mvo.getDeletedRows() != null) {
			for(FlwVO flwvo : mvo.getDeletedRows()) {
				mapper.deleteFlw(flwvo);
			};
		}
	}

	@Override
	public void updatePrd(PrdVO prdvo) {
		mapper.updatePrd(prdvo);
	}
	
	


}
