package com.onetouch.web.fct.fix.service;

import java.util.List;
import com.onetouch.web.fct.fix.dao.FixVO;

public interface FixService {

	List<FixVO> fixSelectList(FixVO fixVO);
}
