package com.onetouch.web.adm.mng.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.adm.mng.service.MngService;

@Controller
public class MngController {

	@Autowired MngService service;
	
	//공정리스트 보여주는 페이지로 이동
	@RequestMapping("mngList")
	public String mngList() {
		return "tiles/adm/admMngList";
	}
	
	//공정리스트 조회처리
	@ResponseBody
	@GetMapping("/admMngList")
	public List<MngVO> list() {
		List<MngVO> list = new ArrayList<>();
		list = service.selectAll();
		System.out.println("111"+list);
		return list;
	}
}

