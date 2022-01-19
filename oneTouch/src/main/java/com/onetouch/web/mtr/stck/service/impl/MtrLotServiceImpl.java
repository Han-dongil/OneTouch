package com.onetouch.web.mtr.stck.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.mtr.stck.dao.MtrLotMapper;
import com.onetouch.web.mtr.stck.service.MtrLotService;
@Service
public class MtrLotServiceImpl implements MtrLotService{
	@Autowired MtrLotMapper mapper;
	@Override
	public List<LotVO> listLot(MtrSearchVO vo) {
		
		return mapper.listLot(vo);
	}
	@Override
	public List<LotVO> listMtr(MtrSearchVO vo) {
		
		return mapper.listMtr(vo);
	}
	@Override
	public void insertLot(List<LotVO> list) {
	
	}

}
