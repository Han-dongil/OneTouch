package com.onetouch.web.zzz.dao;

import java.util.List;

public interface MsgAltMapper {
	List<MsgAltVO> selectAll();
	List<MsgAltVO> selectDate(MsgAltVO vo);
	List<MsgAltVO> selectDept(MsgAltVO vo);
	void updateAltChkY(MsgAltVO vo);
	void delete(List<MsgAltVO> list);
}
