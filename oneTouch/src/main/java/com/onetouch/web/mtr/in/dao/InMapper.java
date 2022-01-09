package com.onetouch.web.mtr.in.dao;

import java.util.List;

public interface InMapper {
	List<InVO> list();
	List<InSearchVO> select(InSearchVO inSearchVO);
	void delete(List<InVO> list);
}
