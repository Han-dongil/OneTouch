package com.onetouch.web.mtr.outForm.service;

import java.util.List;

import com.onetouch.web.mtr.inForm.dao.SearchVO;
import com.onetouch.web.mtr.outForm.dao.OutVO;

public interface OutService {
	List<OutVO> selectOut(SearchVO inSearchVO);
}
