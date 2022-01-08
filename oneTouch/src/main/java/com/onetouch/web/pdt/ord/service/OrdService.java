package com.onetouch.web.pdt.ord.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.onetouch.web.pdt.ord.dao.OrdVO;

public interface OrdService {
	List<OrdVO> list();
	List<OrdVO> select(OrdVO vo);
	void delete(List<OrdVO> list);
	
}
