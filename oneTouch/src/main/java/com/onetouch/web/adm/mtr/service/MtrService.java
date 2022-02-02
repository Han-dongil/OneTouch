package com.onetouch.web.adm.mtr.service;

import java.util.List;

import com.onetouch.web.adm.mtr.dao.MtrVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MtrService {
	List<MtrVO> selectAdmMtrAll();
	List<MtrVO> selectUseAdmMtr();
	List<MtrVO> selectAdmMtrDtl(MtrVO mtrvo);
	List<MtrVO> selectMtrSize();
	List<MtrVO> selectMtrSect();
	
	void updateMtr(MtrVO mtrvo);
	void insertMtr(MtrVO mtrvo);
	void deleteMtr(MtrVO mtrvo);
	
	void modify(ModifyVO<MtrVO> mvo);
}
