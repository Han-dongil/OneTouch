package com.onetouch.web.adm.flw.service;

import java.util.List;

import com.onetouch.web.adm.flw.dao.FlwVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface FlwService {

	List<FlwVO> selectFlw(FlwVO flwvo);
	void modify(ModifyVO<FlwVO> mvo);
	void insertFlwList(List<FlwVO> maps);

}
