package com.onetouch.web.mtr.in.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onetouch.web.mtr.in.dao.MtrInMapper;
import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.in.service.MtrInService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MtrInServiceImpl implements MtrInService {
	@Autowired MtrInMapper mapper;
	@Override
	public List<MtrInVO> selectIn(MtrSearchVO inSearchVO) {
		return mapper.selectIn(inSearchVO);
	}
	
	@Transactional
	public void modifyIn(ModifyVO<MtrInVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(MtrInVO vo : mvo.getCreatedRows()){
				mapper.insertIn(vo);
				mapper.updateOrd(vo);
			};
		}
		if(mvo.getUpdatedRows() != null) {
		    for(MtrInVO vo : mvo.getUpdatedRows()){
		    	mapper.updateIn(vo);
		    	};
		}
		if(mvo.getDeletedRows() != null) {
		    for(MtrInVO vo : mvo.getDeletedRows()){
		    	mapper.deleteIn(vo); };
		}
	}

}
