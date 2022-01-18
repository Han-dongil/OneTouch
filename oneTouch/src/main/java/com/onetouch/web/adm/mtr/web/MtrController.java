package com.onetouch.web.adm.mtr.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.mtr.service.MtrService;

@Controller
public class MtrController {
	
	@Autowired MtrService mtrservice;
	
	//자재정보관리 보여주는 페이지로 이동
	@RequestMapping("mtrList")
	public String mtrList() {
		return "tiles/adm/admMtrList";
	}
	
	//자재리스트 조회처리
	@ResponseBody
	@GetMapping("/admMtrList")
	public Map<String, Object> mtrListAll() {
		Map<String, Object> map = new HashMap<>();
		map.put("contents", mtrservice.selectAdmMtrAll());
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
}
