package com.onetouch.web.zzz.dao;

import java.util.List;

public interface MsgAltMapper {
	List<MsgAltVO> selectAll();
	List<MsgAltVO> selectDate(MsgAltVO vo);
	void delete(List<MsgAltVO> list);
}
