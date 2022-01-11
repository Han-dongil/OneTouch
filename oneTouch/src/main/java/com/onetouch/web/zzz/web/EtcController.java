package com.onetouch.web.zzz.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.zzz.dao.MsgAltVO;
import com.onetouch.web.zzz.service.MsgAltService;

@Controller
public class EtcController {
	
	@Autowired MsgAltService service;
	
	@RequestMapping("msgAlt")
	public String msgAltList() {
		
		return "tiles/zzz/msgAlt";
	}
	
	@ResponseBody
	@GetMapping("msgAltList")
	public List<MsgAltVO> selectAll(){
		List<MsgAltVO> list = new ArrayList<MsgAltVO>();
		list = service.selectAll();
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("msgAltDateList")
	public List<MsgAltVO> selectDate(MsgAltVO vo){
		List<MsgAltVO> list = new ArrayList<MsgAltVO>();
		list = service.selectDate(vo);
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("msgAltDelete")
	public List<MsgAltVO> delete(@RequestBody List<MsgAltVO> list){
		System.out.println(list);
		service.delete(list);
		
		return service.selectAll();
	}
	
	//modal호출
	@RequestMapping("mtrComp")
	public String mtrComp() {
		return "zzz/mtrComp";
	}
	
	@RequestMapping("mtr")
	public String mtr() {
		return "zzz/mtr";
	}
}
