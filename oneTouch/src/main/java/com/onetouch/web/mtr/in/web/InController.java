package com.onetouch.web.mtr.in.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.in.dao.InVO;
import com.onetouch.web.mtr.in.service.InService;

@Controller
public class InController {

	@Autowired InService service;
	
	@RequestMapping("inList")
	public String inList() {
		return "tiles/mtr/mtrInList";
	}
	
	@ResponseBody
	@GetMapping("/mtrInList")
	public List<InVO> list(){
		List<InVO> list= new ArrayList<>();
		list =service.list();
		System.out.println("list : " + list);
		return list;
	}
}