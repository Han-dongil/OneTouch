package com.onetouch.web.pdt.work.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.pdt.work.service.WorkService;

@Controller
public class WorkController {
	@Autowired WorkService service;
	
	@RequestMapping("WorkList")
	public String pdtListPage() {
		
		return "tiles/pdt/workInstrList";
		
	}
	
	@RequestMapping
	@GetMapping("workList")
	public List<WorkVO> workList() {
		
		return service.workList();
		
	}
}
