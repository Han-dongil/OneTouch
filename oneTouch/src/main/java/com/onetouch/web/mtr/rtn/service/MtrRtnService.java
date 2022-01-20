package com.onetouch.web.mtr.rtn.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.rtn.dao.MtrRtnVO;

public interface MtrRtnService {
	List<MtrRtnVO> selectRtn(MtrSearchVO inSearchVO);
	/* void modifyIn(ModifyVO<MtrInVO> mvo); */
	
}
