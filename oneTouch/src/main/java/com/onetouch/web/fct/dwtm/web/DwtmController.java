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
	
	//비동기 삭제
	@ResponseBody
	@PostMapping("dwtmDelete")
	public int dwtmDelete(@RequestBody DwtmVO dwtmVO) {
		log.info("삭제 컨트롤러 연결했슴");
		System.out.println(dwtmVO);
		return dservice.dwtmDelte(dwtmVO);
	}
	
	//비동기 수정
	@ResponseBody
	@PostMapping("dwtmUpdate")
	public int dwtmUpdate(@RequestBody DwtmVO dwtmVO) {
		return dservice.dwtmUpdate(dwtmVO);
	}
	
	//비동기 등록
	@ResponseBody
	@PostMapping("dwtmInsret")
	public int dwtmInsert(@RequestBody DwtmVO dwtmVO) {
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
