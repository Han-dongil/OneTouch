package com.onetouch.web.fct.prod.dao;

import java.util.List;

public interface ProdMapper {
	List<ProdVO> prodSelect(ProdVO prodVO);
	List<ProdVO> prodCheckSelectList(ProdVO prodVO);
}
