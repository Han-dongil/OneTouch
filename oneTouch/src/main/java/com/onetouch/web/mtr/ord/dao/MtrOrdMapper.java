package com.onetouch.web.mtr.ord.dao;

import java.util.List;

public interface MtrOrdMapper {
	List<MtrOrdVO> ordMtrList();
	List<MtrOrdVO> ordMtrSelect(MtrOrdVO vo);
	void insert(MtrOrdVO vo);
	void delete(MtrOrdVO vo);
	void update(MtrOrdVO vo);
	
}
