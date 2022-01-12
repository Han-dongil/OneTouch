package com.onetouch.web.pdt.ord.dao;

import java.util.List;

public interface OrdMapper {
	List<OrdVO> list();
	List<OrdVO> select(OrdVO vo);
	void delete(List<OrdVO> list);
	void ordCheck(String ordShtNo);
	void ordCheck();
}
