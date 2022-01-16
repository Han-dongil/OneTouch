package com.onetouch.web.adm.bom.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.service.BomService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Controller
public class BomController { 

	@Autowired BomService bomservice;
	
	//제품Bom관리 보여주는 페이지로 이동
	@RequestMapping("BomList")
	public String bomList() {
		return "tiles/adm/admBomList";
	}
	
	//제품코드 클릭하면 제품에 해당하는 자재들 보여주기(bom)
	@ResponseBody
	@GetMapping("/admBomList")
	public Map<String, Object> BomList(BomVO bomvo) {
		System.out.println(bomvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", bomservice.selectBomDtl(bomvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//삭제수정등록 처리
	@ResponseBody
	@PostMapping("/bomModifyData")
	public void modify(@RequestBody ModifyVO<BomVO> mvo) {
		System.out.println("modify" + mvo);
		bomservice.modify(mvo);
	}
}
