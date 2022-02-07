package com.onetouch.web.fct.info.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.dao.LineVO;
import com.onetouch.web.fct.info.service.InfoService;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
@Service
public class InfoServiceImpl implements InfoService {
	@Autowired InfoMapper mapper;
	@Autowired PlanMapper pmapper;
	
	@Override
	public List<InfoVO> selectFctInfoAll(InfoVO infoVO) {
		return mapper.selectFctInfoAll(infoVO);
	}


	@Override
	public void deleteFctInfo(InfoVO infoVO) {
		mapper.deleteFctInfo(infoVO);
	}
	
	@Override
	public InfoVO selectFctInfo(InfoVO infoVO) {
		return mapper.selectFctInfo(infoVO);
	}
	
	@Override
	public void insertFctInfo(InfoVO infoVO) {
		mapper.insertFctInfo(infoVO);
	}
	@Override
	public int InfoUpdate(InfoVO infoVO) {
		return mapper.InfoUpdate(infoVO);
	}

	@Override
	public List<LineVO> LineSelect(LineVO lineVO) {
		return mapper.LineSelect(lineVO);
	}


	@Override
	public int LineInsert(LineVO lineVO) {
		System.out.println("서비스임플 인서트부분");
		System.out.println(lineVO);
		return mapper.LineInsert(lineVO);
	}


	@Override
	public int LineDelete(LineVO lineVO) {
		System.out.println("라인 삭제");
		return mapper.LineDelete(lineVO);
	}


	@Override
	public InfoVO todayDate() {
		return mapper.todayDate();
	}


	@Override
	public List<InfoVO> selectCheckFct(InfoVO infoVO) {
		return mapper.selectCheckFct();
	}


	@Override
	public int LineUpdate(LineVO lineVO) {
		return mapper.LineUpdate(lineVO);
	}


	@Override
	public InfoVO selectFctNm(InfoVO infoVO) {
		return mapper.selectFctNm(infoVO);
	}


	@Scheduled(fixedDelay = 10000)
	public void updateStartFctPhs( ) {
		System.out.println("가동상태전환");
		mapper.updateStartFctPhs();
		
	}


	@Override
	public LineVO selectLineNo(LineVO lineVO) {
		return mapper.selectLineNo(lineVO);
	}





	
}
