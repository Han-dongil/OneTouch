package com.onetouch.web.pdt.work.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.work.dao.WorkMapper;
import com.onetouch.web.pdt.work.dao.WorkVO;

@RequestMapping("pdt/")
@Controller
public class WorkViewController {
	@Autowired WorkMapper mapper;
	@RequestMapping("WorkListView")
	public String pdtListPage() {
		
		return "tiles/pdt/pdtWorkList";
		
	}
	
	@ResponseBody
	@RequestMapping("workSearchList")
	public List<WorkVO> workSearchList(@RequestBody WorkVO vo){
		return mapper.workListDetail(vo);
	}

	@ResponseBody
	@RequestMapping("workList")
	public List<WorkVO> workList(@RequestBody Map<String,String> vo){
		return mapper.workList(vo);
	}
}
