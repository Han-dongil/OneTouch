package com.onetouch.web.mtr.in.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.in.dao.InMapper;
import com.onetouch.web.mtr.in.dao.InSearchVO;
import com.onetouch.web.mtr.in.dao.InVO;
import com.onetouch.web.mtr.in.service.InService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class InServiceImpl implements InService {
	@Autowired InMapper mapper;
	@Override
	public List<InVO> list() {
		return mapper.list();
	}
	@Override
	public List<InSearchVO> select(InSearchVO inSearchVO) {
		return mapper.select(inSearchVO);
	}
	
	/*
	 * @Override public void insert(InVO vo) { mapper.insert(vo); }
	 * 
	 * @Override public void update(InVO vo) { mapper.update(vo);
	 * 
	 * }
	 * 
	 * @Override public void delete(InVO vo) { mapper.delete(vo);
	 * 
	 * }
	 */
	
	public void modify(ModifyVO<InVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(InVO vo : mvo.getCreatedRows()){
				mapper.insert(vo); };
		}
		if(mvo.getUpdatedRows() != null) {
		    for(InVO vo : mvo.getUpdatedRows()){
		    	mapper.update(vo); };
		}
		if(mvo.getDeletedRows() != null) {
		    for(InVO vo : mvo.getDeletedRows()){
		    	mapper.delete(vo); };
		}
	}

}
