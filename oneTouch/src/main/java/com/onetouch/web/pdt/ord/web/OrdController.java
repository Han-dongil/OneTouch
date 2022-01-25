package com.onetouch.web.pdt.ord.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.ord.dao.OrdVO;
import com.onetouch.web.pdt.ord.service.OrdService;

@RequestMapping("pdt/")
@Controller
public class OrdController {

	@Autowired OrdService service;
	
	@RequestMapping("ordList")
	public String ordList() {

		return "tiles/pdt/pdtOrdList";
	}
	
	@ResponseBody
	@GetMapping("pdtOrdlist")
	public List<OrdVO> list(){
		List<OrdVO> list= new ArrayList<>();
		list =service.list();
		return list;
	}
	@ResponseBody
	@PostMapping("ord")
	public List<OrdVO> select(OrdVO vo){
		List<OrdVO> list= new ArrayList<>();
		list =service.select(vo);
		return list;
	}
	@ResponseBody
	@PostMapping("ordDel")
	public List<OrdVO> delete(@RequestBody List<OrdVO> list) {
		System.out.println(list);
		service.delete(list);
		
		return service.list();
		
	}
	@ResponseBody
	@GetMapping("orderSeq")
	public OrdVO orderSeq() {
		return service.orderSeq();
	}
	

}
