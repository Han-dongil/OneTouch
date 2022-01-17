package com.onetouch.web.adm.bas.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasMapper;
import com.onetouch.web.adm.bas.dao.BasVO;
import com.onetouch.web.adm.bas.service.BasService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class BasServiceImpl implements BasService{

	@Autowired BasMapper mapper;

	@Override
	public List<BasDtlVO> selectBasDtl(BasDtlVO basDtlvo) {
		return mapper.selectBasDtl(basDtlvo);
	}
	@Override
	public List<BasDtlVO> selectBasDtlAll() {
		return mapper.selectBasDtlAll();
	}
	@Override
	public List<BasDtlVO> selectUseBasDtl(BasDtlVO basDtlvo) {
		return mapper.selectUseBasDtl(basDtlvo);
	}
	@Override
	public List<BasVO> selectBasAll(BasVO basvo) {
		return mapper.selectBasAll(basvo);
	}
	@Override
	public void modify(ModifyVO<BasDtlVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(BasDtlVO basDtlvo : mvo.getCreatedRows()) {
				mapper.insertBas(basDtlvo);
			};
		}
		if(mvo.getUpdatedRows() != null) {
			for(BasDtlVO basDtlvo : mvo.getUpdatedRows()) {
				mapper.updateBas(basDtlvo);
			};
		}
	}


}
