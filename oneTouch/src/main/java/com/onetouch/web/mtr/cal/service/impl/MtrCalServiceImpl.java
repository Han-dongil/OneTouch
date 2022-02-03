package com.onetouch.web.mtr.cal.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.cal.dao.MtrCalMapper;
import com.onetouch.web.mtr.cal.dao.MtrCalVO;
import com.onetouch.web.mtr.cal.service.MtrCalService;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MtrCalServiceImpl implements MtrCalService {
	@Autowired MtrCalMapper calMapper;
	@Override
	public List<MtrCalVO> selectCal(MtrSearchVO inSearchVO) {
		return calMapper.selectCal(inSearchVO);
	}
	@Override
	public List<LotVO> selectLot(MtrCalVO mtrCalVO) {
		return calMapper.selectLot(mtrCalVO);
	}
	@Override
	public void createCal(ModifyVO<MtrCalVO> mvo) {
		for(int i=0; i<mvo.getCreatedRows().size(); i++) {
			calMapper.insertCal(mvo.getCreatedRows().get(i));
			calMapper.updateCal(mvo.getCreatedRows().get(i));
		}
	}
	@Override
	public void deleteCal(ModifyVO<MtrCalVO> mvo) {
		for(int i=0; i<mvo.getDeletedRows().size(); i++) {
			calMapper.deleteCal(mvo.getDeletedRows().get(i));
			calMapper.minusCal(mvo.getDeletedRows().get(i));
		}
		
	}

}
