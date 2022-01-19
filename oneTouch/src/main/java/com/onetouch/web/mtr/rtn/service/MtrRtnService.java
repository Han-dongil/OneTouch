package com.onetouch.web.mtr.rtn.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.rtn.dao.MtrRtnVO;

public interface MtrRtnService {
	List<MtrRtnVO> selectIn(MtrSearchVO inSearchVO);
	/* void modifyIn(ModifyVO<MtrInVO> mvo); */
	
}
