package com.onetouch.web.mtr.rtn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.rtn.dao.MtrRtnMapper;
import com.onetouch.web.mtr.rtn.dao.MtrRtnVO;
import com.onetouch.web.mtr.rtn.service.MtrRtnService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MtrRtnServiceImpl implements MtrRtnService {
	@Autowired MtrRtnMapper rtnMapper;
	@Override
	public List<MtrRtnVO> rtnList(MtrSearchVO searchVO) {
		return rtnMapper.rtnList(searchVO);
	}
	@Override
	public List<MtrRtnVO> selectRtn(MtrSearchVO inSearchVO) {
		return rtnMapper.selectRtn(inSearchVO);
	}
	
	@Transactional
	public void modifyRtn(ModifyVO<MtrRtnVO> mvo) {
		//반품처리 등록
		if(mvo.getUpdatedRows() != null) {
		    for(MtrRtnVO data : mvo.getUpdatedRows()){
		    	System.out.println(data);
		    	rtnMapper.insertRtn(data);
//		    	rtnMapper.updateCmt(data);
		    	};
		}
	}
}
