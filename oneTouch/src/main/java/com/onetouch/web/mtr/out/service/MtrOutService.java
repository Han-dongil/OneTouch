package com.onetouch.web.mtr.out.service;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.out.dao.MtrOutVO;

public interface MtrOutService {
	List<MtrOutVO> selectOut(MtrSearchVO searchVO);
}
