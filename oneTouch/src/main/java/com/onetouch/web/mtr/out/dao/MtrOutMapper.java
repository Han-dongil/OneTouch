package com.onetouch.web.mtr.out.dao;

import java.util.List;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;

public interface MtrOutMapper {

	List<MtrOutVO> selectOut(MtrSearchVO searchVO);
}
