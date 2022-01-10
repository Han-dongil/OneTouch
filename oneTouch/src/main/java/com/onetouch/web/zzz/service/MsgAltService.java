package com.onetouch.web.zzz.service;

import java.util.List;

import com.onetouch.web.zzz.dao.MsgAltVO;

public interface MsgAltService {
	List<MsgAltVO> selectAll();
	List<MsgAltVO> selectDate(MsgAltVO vo);
	void delete(List<MsgAltVO> list);
}
