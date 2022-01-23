package com.onetouch.web.fct.dwtm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.fct.dwtm.dao.DwtmVO;
import com.onetouch.web.fct.dwtm.service.DwtmService;

import lombok.extern.java.Log;
@Log
@Controller
public class DwtmController {

	@Autowired DwtmService dservice;
	
	@ResponseBody
	@PostMapping("dwtmInsret")
	public int dwtmInsert(@RequestBody DwtmVO dwtmVO) {
		log.info("등록 컨트롤러 연결 성공");
		
		return dservice.dwtmInsert(dwtmVO);
	}
	
	@RequestMapping("ftcDwtmIns")
	public String moveDwtmPage() {
		
		return "tiles/fct/dwtmIns";
	}
	
	/* 비동기 테이블 목록 조회 */
	@ResponseBody
	@PostMapping("dwtmSelectAll")
	public List<DwtmVO> dwtmSelect(@RequestBody DwtmVO dwtmVO){
		return dservice.dwtmSelectAll(dwtmVO);
		
	}
}
