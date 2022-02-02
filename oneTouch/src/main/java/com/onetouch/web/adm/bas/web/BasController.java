package com.onetouch.web.adm.bas.web;

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

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasVO;
import com.onetouch.web.adm.bas.service.BasService;
import com.onetouch.web.zzz.dao.ModifyVO;

@RequestMapping("/adm")
@Controller
public class BasController {

	@Autowired BasService basservice;
	
	//공통관리 보여주는 페이지로 이동
	@RequestMapping("/BasList")
	public String basList() {
		return "tiles/adm/admBasList";
	}
	
	//기초코드 조회처리
	@ResponseBody
	@GetMapping("/admBasList")
	public Map<String, Object> BasListAll(BasVO basvo) {
		Map<String, Object> map = new HashMap<>();
		map.put("contents", basservice.selectBasAll(basvo));

		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);

		return maps;
	}
	
	//기초코드명 클릭하면 상세코드정보 조회처리
	@ResponseBody
	@GetMapping("/admBasDtlList")
	public Map<String, Object> basListDtl(BasDtlVO basDtlvo) {
		
		//System.out.println("bas"+basDtlvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", basservice.selectBasDtl(basDtlvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		return maps;
	}
	
	//삭제수정등록 처리 (basDtl)
	@ResponseBody
	@PostMapping("/basDtlModifyData")
	public List<BasDtlVO> modify(@RequestBody ModifyVO<BasDtlVO> mvo) {
		BasDtlVO basdtlvo = new BasDtlVO();
		System.out.println("modify1" + mvo);
		basservice.modify(mvo);
		if(mvo.getCreatedRows().size() > 0) {
			basdtlvo.setBasCd(mvo.getCreatedRows().get(0).getBasCd());
		}
		if(mvo.getUpdatedRows().size() > 0) {
			basdtlvo.setBasCd(mvo.getUpdatedRows().get(0).getBasCd());
		}
		if(mvo.getDeletedRows().size() > 0) {
			basdtlvo.setBasCd(mvo.getDeletedRows().get(0).getBasCd());
		}
		return basservice.selectBasDtl(basdtlvo);
	}
	
	//삭제수정등록 처리 (basAll)
	@ResponseBody
	@PostMapping("/basAllModifyData")
	public List<BasVO> modifyBas(@RequestBody ModifyVO<BasVO> mvo) {
		System.out.println("modify" + mvo);
		basservice.modifyBas(mvo);
		return basservice.selectBasAll(null);
	}
	
}
