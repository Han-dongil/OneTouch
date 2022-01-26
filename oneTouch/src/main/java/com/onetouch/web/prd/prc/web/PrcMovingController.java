package com.onetouch.web.prd.prc.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.work.dao.WorkMapper;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.prd.prc.dao.PrcVO;
import com.onetouch.web.prd.prc.service.PrcService;

@RequestMapping("pdt/")
@Controller
public class PrcMovingController {
	
	@Autowired PrcService service;
	@Autowired WorkMapper workMapper;
	
	@RequestMapping("movingPrc")
	public String pdtListPage() {
		return "tiles/pdt/movingPrc";
	}
	
	@ResponseBody
	@RequestMapping("prcMovingList")
	public List<WorkVO> prcMove(@RequestBody Map<String,String> map){
		
		
		//
		return workMapper.prcMovingList(map);
	}
}