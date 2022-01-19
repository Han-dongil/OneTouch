package com.onetouch.web.adm.mtr.dao;

import java.util.List;

public interface MtrMapper {
	List<MtrVO> selectAdmMtrAll();
	List<MtrVO> selectUseAdmMtr();
	List<MtrVO> selectAdmMtrDtl(MtrVO mtrvo);
	
	void updateMtr(MtrVO mtrvo);
}
