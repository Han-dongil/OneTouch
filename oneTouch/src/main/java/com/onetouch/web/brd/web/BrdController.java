package com.onetouch.web.brd.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.brd.service.BrdService;
@RequestMapping("/brd")
@Controller
public class BrdController {
	
	@Autowired BrdService service;
	
	@RequestMapping("/dashBoard")
	public String dashBoard() {
		return "tiles/brd/dashBoard";
	}
	
	@ResponseBody
	@PostMapping("/brdList")
	public String brdList(Model model){
		model.addAttribute("mtrList", service.mtrList());
		model.addAttribute("fctList", service.fctList());
		model.addAttribute("pdtList", service.pdtList());
		return "brd/dashBoard";
	}
}
