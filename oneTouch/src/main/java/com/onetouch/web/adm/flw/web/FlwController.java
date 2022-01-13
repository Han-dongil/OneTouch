package com.onetouch.web.adm.flw.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.bom.service.BomService;
import com.onetouch.web.adm.flw.service.FlwService;

@Controller
public class FlwController {
	
	//bom서비스 호출해서 제품리스트, 제품클릭하면 제품정보뜨는거 쓰기
	@Autowired FlwService flwservice;
	@Autowired BomService bomservice;
	
	//공정흐름관리 보여주는 페이지로이동
	@RequestMapping("FlwList")
	public String flwList() {
		return "tiles/adm/admFlwList";
	}
	
	//제품리스트 조회처리
	@ResponseBody
	@GetMapping("/admPrdList")
	public Map<String, Object> prdListAll() {
		Map<String, Object> map = new HashMap<>();
		map.put("contents", bomservice.selectPrdAll());
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
}
