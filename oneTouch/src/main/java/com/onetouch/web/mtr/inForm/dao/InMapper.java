package com.onetouch.web.mtr.inForm.dao;

import java.util.List;

public interface InMapper {
	List<InVO> selectIn(InSearchVO inSearchVO);
	void insertIn(InVO vo);
	void deleteIn(InVO vo);
	void updateIn(InVO vo);
	void updateOrd(InVO vo);
}
