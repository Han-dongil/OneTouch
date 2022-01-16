package com.onetouch.web.mtr.ord.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.ord.dao.MtrOrdMapper;
import com.onetouch.web.mtr.ord.dao.MtrOrdVO;
import com.onetouch.web.mtr.ord.service.MtrOrdService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MtrOrdServiceImpl implements MtrOrdService {
	@Autowired MtrOrdMapper mapper;
	
	@Override
	public List<MtrOrdVO> ordMtrList() {
		System.out.println("************");
		System.out.println(mapper.ordMtrList());
		return mapper.ordMtrList();
	}
	
	@Override
	public List<MtrOrdVO> ordMtrSelect(MtrOrdVO vo) {
		return mapper.ordMtrSelect(vo);
	}
		
	public void modify(ModifyVO<MtrOrdVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(MtrOrdVO vo : mvo.getCreatedRows()){
				mapper.insert(vo); };
		}
		if(mvo.getUpdatedRows() != null) {
		    for(MtrOrdVO vo : mvo.getUpdatedRows()){
		    	mapper.update(vo); };
		}
		if(mvo.getDeletedRows() != null) {
		    for(MtrOrdVO vo : mvo.getDeletedRows()){
		    	mapper.delete(vo); };
		}
	}



}
