package com.onetouch.web.adm.mng.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.adm.mng.service.MngService;

@Controller
public class MngController {

	@Autowired
	MngService service;

	// 공정리스트 보여주는 페이지로 이동
	@RequestMapping("mngList")
	public String mngList() {
		return "tiles/adm/admMngList";
	}
	
	//공정과정명 리스트 담아주기
	@ResponseBody
	@GetMapping("/prcList")
	public List<MngVO> prcList() {
		List<MngVO> prcList = new ArrayList<>();
		prcList = service.selectPrc();
		System.out.println("222"+prcList);
		return prcList;
	}

	/*
	 * 이 형태로 만들어줘야함 { "result": true, "data": { "contents": [], "pagination": {
	 * "page": 1, "totalCount": 100 } } }
	 */

	// 공정리스트 조회처리
	@ResponseBody
	@GetMapping("/admMngList")
	public Map<String, Object> mngListAll() {
		Map<String, Object> map = new HashMap<>();
		map.put("contents", service.selectAll());

		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);

		return maps;
	}
	
	

	//삭제처리
/*	@ResponseBody
	@PostMapping("modifyData")
	public List<MngVO> modifyData(Map<String, List<MngVO>> vo){
		return null;
	}*/
}
