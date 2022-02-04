package com.onetouch.web.fct.prod.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.prod.dao.ProdMapper;
import com.onetouch.web.fct.prod.dao.ProdVO;
import com.onetouch.web.fct.prod.service.ProdService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class ProdServiceImpl implements ProdService {

	@Autowired ProdMapper mapper;
	@Override
	public List<ProdVO> prodSelect(ProdVO prodVSO) {
		
		return mapper.prodSelect(prodVSO);
	}
	@Override
	public List<ProdVO> prodCheckSelectList(ProdVO prodVO) {

		return mapper.prodCheckSelectList(prodVO);
	}
	@Override
	public void modify(ModifyVO<ProdVO> mvo) {
		if(mvo.getCreatedRows() != null) {
			for(ProdVO prodVO : mvo.getCreatedRows()) {
				mapper.insertProd(prodVO);
			};
		}
		
			for(ProdVO prodVO: mvo.getUpdatedRows()) {
				if(mvo.getUpdatedRows() != null) {
					System.out.println(mvo.getUpdatedRows().get(0).getProdChkNo());
					if(mvo.getUpdatedRows().get(0).getProdChkNo() != null) {
						mapper.updateProd(prodVO);
					}
					else {
						mapper.insertProd(prodVO);
					}
			};
		}
		if(mvo.getDeletedRows() != null) {
			for(ProdVO prodVO: mvo.getDeletedRows()) {
				mapper.deleteProd(prodVO);
			};
		
		}
	}
	@Override
	public ProdVO selectchkExpectDt(ProdVO prodVO) {
		return mapper.selectchkExpectDt(prodVO);
	}
}
