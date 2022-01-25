package com.onetouch.web.adm.flw.web;

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

import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.bom.service.BomService;
import com.onetouch.web.adm.flw.dao.FlwVO;
import com.onetouch.web.adm.flw.service.FlwService;
import com.onetouch.web.zzz.dao.ModifyVO;

@RequestMapping("/adm")
@Controller
public class FlwController {
	
	//bom서비스 호출해서 제품리스트, 제품클릭하면 제품정보뜨는거 쓰기
	@Autowired FlwService flwservice;
	@Autowired BomService bomservice;
	
	//공정흐름관리 보여주는 페이지로이동
	@RequestMapping("/FlwList")
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
	
	//제품상세정보 조회처리
	@ResponseBody
	@GetMapping("/admPrdDtlList")
	public Map<String, Object> prdListDtl(PrdVO prdvo) {
		
		System.out.println("dtl"+prdvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", bomservice.selectPrd(prdvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//공정흐름 조회처리
	@ResponseBody
	@GetMapping("/admFlwList")
	public Map<String, Object> FlwList(FlwVO flwvo) {
		
		System.out.println(flwvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", flwservice.selectFlw(flwvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//공정흐름관리 저장
	@ResponseBody
	@PostMapping("/flwModifyData")
	public void modify(@RequestBody ModifyVO<FlwVO> mvo) {
		System.out.println("modify" + mvo);
		flwservice.modify(mvo);
	}
	
	//form 수정
	@ResponseBody
	@PostMapping("/updatePrd")
	public List<PrdVO> updatePrd(PrdVO prdvo) {
		flwservice.updatePrd(prdvo);
		System.out.println("upd"+prdvo);
		return bomservice.selectPrd(prdvo);
	}
	
	//삭제수정등록 처리
	@ResponseBody
	@PostMapping("/prdModifyData")
	public void modifyPrd(@RequestBody ModifyVO<PrdVO> mvo) {
		System.out.println("modify" + mvo);
		bomservice.modifyPrd(mvo);
	}
	
}
