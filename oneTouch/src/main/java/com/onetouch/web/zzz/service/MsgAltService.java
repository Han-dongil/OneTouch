package com.onetouch.web.zzz.service;

import java.util.List;

import com.onetouch.web.zzz.dao.MsgAltVO;

public interface MsgAltService {
	List<MsgAltVO> list();
	List<MsgAltVO> select(MsgAltVO vo);
}
