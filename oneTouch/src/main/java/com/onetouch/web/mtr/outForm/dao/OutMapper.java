package com.onetouch.web.mtr.outForm.dao;

import java.util.List;

import com.onetouch.web.mtr.inForm.dao.SearchVO;

public interface OutMapper {

	List<OutVO> selectOut(SearchVO searchVO);
}
