package com.onetouch.web.mtr.ord.service;

import java.util.List;

import com.onetouch.web.mtr.ord.dao.MtrOrdVO;
import com.onetouch.web.zzz.dao.ModifyVO;

public interface MtrOrdService {
	List<MtrOrdVO> ordMtrList();
	
	List<MtrOrdVO> ordMtrSelect(MtrOrdVO vo);
	
	void modify(ModifyVO<MtrOrdVO> mvo);
	
	
}
