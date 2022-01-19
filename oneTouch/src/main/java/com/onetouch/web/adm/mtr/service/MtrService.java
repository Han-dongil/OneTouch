package com.onetouch.web.adm.mtr.service;

import java.util.List;

import com.onetouch.web.adm.mtr.dao.MtrVO;

public interface MtrService {
	List<MtrVO> selectAdmMtrAll();
	List<MtrVO> selectUseAdmMtr();
	List<MtrVO> selectAdmMtrDtl(MtrVO mtrvo);
	
	void updateMtr(MtrVO mtrvo);
}
