package com.onetouch.web.adm.mtr.web;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.mtr.dao.MtrVO;
import com.onetouch.web.adm.mtr.service.MtrService;

@RequestMapping("/adm")
@Controller
public class MtrController {
	
	@Autowired MtrService mtrservice;
	
	//자재정보관리 보여주는 페이지로 이동
	@RequestMapping("/mtrList")
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
	
	//자재상세정보 조회처리
	@ResponseBody
	@GetMapping("/admMtrDtlList")
	public Map<String, Object> mtrListDtl(MtrVO mtrvo) {
		
		System.out.println("dtl"+mtrvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", mtrservice.selectAdmMtrDtl(mtrvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//form 수정
	@ResponseBody
	@PostMapping("/updateMtr")
	public List<MtrVO> updateMtr(MtrVO mtrvo) {
		mtrservice.updateMtr(mtrvo);
		System.out.println("upd"+mtrvo);
		return mtrservice.selectAdmMtrDtl(mtrvo);
	}
	
	//form 등록
	@ResponseBody
	@PostMapping("/insertMtr")
	public List<MtrVO> insertMtr(MtrVO mtrvo) {
		mtrservice.insertMtr(mtrvo);
		System.out.println("upd"+mtrvo);
		return mtrservice.selectAdmMtrDtl(mtrvo);
	}
	
}
