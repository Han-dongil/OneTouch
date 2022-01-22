package com.onetouch.web.mtr.rtn.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.rtn.dao.MtrRtnVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MtrRtnService {
	List<MtrRtnVO> rtnList(MtrSearchVO searchVO);
	List<MtrRtnVO> selectRtn(MtrSearchVO inSearchVO);
	void modifyRtn(ModifyVO<MtrRtnVO> mvo);
	/* void modifyIn(ModifyVO<MtrInVO> mvo); */
	
}
