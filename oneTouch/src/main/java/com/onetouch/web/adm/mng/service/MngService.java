package com.onetouch.web.adm.mng.service;

import java.util.List;

import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MngService {
	List<MngVO> selectPrcAll();
	List<MngVO> selectUsePrc();
	List<MngVO> selectPrcMng();
	List<MngVO> selectPrc();
	List<MngVO> selectUnit();
	
	void modify(ModifyVO<MngVO> mvo);
}
