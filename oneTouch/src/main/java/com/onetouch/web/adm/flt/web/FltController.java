package com.onetouch.web.adm.flt.web;

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

import com.onetouch.web.adm.flt.dao.FltVO;
import com.onetouch.web.adm.flt.service.FltService;
import com.onetouch.web.zzz.dao.ModifyVO;

@RequestMapping("/adm")
@Controller
public class FltController {

	@Autowired FltService fltservice;
	
	//불량코드 리스트 보여주는 페이지로 이동
	@RequestMapping("/FltList")
	public String fltList() {
		return "tiles/adm/admFltList";
	}
	
	//불량코드리스트 조회처리
	@ResponseBody
	@GetMapping("/admFltList")
	public Map<String, Object> fltListAll() {
		Map<String, Object> map = new HashMap<>();
		map.put("contents", fltservice.selectFlt());

		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);

		return maps;
	}
	
	// 삭제,수정,등록 처리
	@ResponseBody
	@PostMapping("/fltModifyData")
	public List<FltVO> modify(@RequestBody ModifyVO<FltVO> mvo) {
		System.out.println("modify" + mvo);
		fltservice.modify(mvo);
		return fltservice.selectFlt();
	}
	
}
