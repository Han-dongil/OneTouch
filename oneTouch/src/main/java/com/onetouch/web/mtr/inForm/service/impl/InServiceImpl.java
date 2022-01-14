package com.onetouch.web.mtr.inForm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onetouch.web.mtr.inForm.dao.InMapper;
import com.onetouch.web.mtr.inForm.dao.InSearchVO;
import com.onetouch.web.mtr.inForm.dao.InVO;
import com.onetouch.web.mtr.inForm.service.InService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class InServiceImpl implements InService {
	@Autowired InMapper mapper;
	@Override
	public List<InVO> selectIn(InSearchVO inSearchVO) {
		return mapper.selectIn(inSearchVO);
	}
	
	@Transactional
	public void modifyIn(ModifyVO<InVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(InVO vo : mvo.getCreatedRows()){
				mapper.insertIn(vo);
				mapper.updateOrd(vo);
			};
		}
		if(mvo.getUpdatedRows() != null) {
		    for(InVO vo : mvo.getUpdatedRows()){
		    	mapper.updateIn(vo);
		    	};
		}
		if(mvo.getDeletedRows() != null) {
		    for(InVO vo : mvo.getDeletedRows()){
		    	mapper.deleteIn(vo); };
		}
	}

}
