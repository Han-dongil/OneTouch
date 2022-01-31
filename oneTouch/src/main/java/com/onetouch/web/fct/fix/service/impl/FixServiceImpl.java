package com.onetouch.web.fct.fix.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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

	//생산공정관리 테이블에 수리요청 설비 조회 
	@Scheduled(fixedDelay = 10000) //10초마다 실행 (실행시간 별도)
	public void prdPrcMngSelect() {
		
		for(FixVO fixVO : fmapper.prdPrcMngSelect()) {
			System.out.println("수리요청");
			System.out.println(fixVO.getFctCd());
			fmapper.insertRequestFixFtc(fixVO);
		}
		
	}


		
}
	

