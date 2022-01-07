package com.onetouch.web.pdt.ord.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.ord.dao.OrdVO;
import com.onetouch.web.pdt.ord.service.OrdService;

@Controller
public class OrdController {

	@Autowired OrdService service;
	
	@RequestMapping("ordList")
	public String ordList() {
		System.out.println("aaaaaa");
		
		return "tiles/pdt/pdtOrdList";
	}
	
	@ResponseBody
	@GetMapping("/pdtOrdlist")
	public List<OrdVO> list(){
		System.out.println("ddddddd");
		List<OrdVO> list= new ArrayList<>();
		list =service.list();
		System.out.println(list);
		return list; 
	}

}
