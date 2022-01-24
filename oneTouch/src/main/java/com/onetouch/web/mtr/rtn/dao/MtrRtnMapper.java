package com.onetouch.web.mtr.rtn.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;

public interface MtrRtnMapper {

	List<MtrRtnVO> selectRtn(MtrSearchVO inSearchVO);
	List<MtrRtnVO> rtnList(MtrSearchVO searchVO);
	void insertRtn(MtrRtnVO vo);
	void updateCmt(MtrRtnVO vo);
}
