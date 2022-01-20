package com.onetouch.web.adm.mng.dao;

import java.util.List;

public interface MngMapper {
	List<MngVO> selectPrcAll();
	List<MngVO> selectUsePrc();
	List<MngVO> selectPrcMng();
	List<MngVO> selectPrc();
	List<MngVO> selectUnit();
	
	void deletePrc(MngVO mngvo);
	void updatePrc(MngVO mngvo);
	void insertPrc(MngVO mngvo);
}
