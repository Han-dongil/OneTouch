package com.onetouch.web.prd.prc.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.work.dao.WorkMapper;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.prd.prc.dao.PrcMapper;
import com.onetouch.web.prd.prc.dao.PrcVO;
import com.onetouch.web.prd.prc.service.PrcService;

@RequestMapping("pdt/")
@Controller
public class PrcMovingController {
	
	@Autowired PrcService service;
	@Autowired WorkMapper workMapper;
	@Autowired PrcMapper mapper;
	
	@RequestMapping("movingPrc")
	public String pdtListPage() {
		return "tiles/pdt/movingPrc";
	}

	@RequestMapping("test")
	public String test() {
		return "tiles/pdt/test";
	}
	
	@ResponseBody
	@RequestMapping("prcMovingList")
	public List<WorkVO> prcMove(@RequestBody WorkVO vo){
		
		
		//
		return workMapper.workListDetail(vo);
	}
	
	@ResponseBody
	@RequestMapping("workListDetail")
	public List<WorkVO> workListDetail(@RequestBody WorkVO vo){
		return workMapper.prcMovingList(vo);
	}
	@ResponseBody
	@RequestMapping("PrcMovingLot")
	public List<PrcVO> PrcMovingLot(@RequestBody PrcVO vo){
		return mapper.usedlotFind(vo);
	}
	@ResponseBody
	@RequestMapping("prcMovingShow")
	public List<PrcVO> prcMovingShow(@RequestBody PrcVO vo){
		return service.prcMovingView(vo);
	}
	@ResponseBody
	@RequestMapping("prcMovingNonRoop")
	public List<PrcVO> prcMovingNonRoop(@RequestBody PrcVO vo){
		System.out.println(vo);
		System.out.println(mapper.prcMovingView(vo));
		return mapper.prcMovingView(vo);
	}
	@ResponseBody
	@RequestMapping("movingSearchList")
	public List<PrcVO> movingSearchList(@RequestBody PrcVO vo){
		
		return service.movingSearchList(vo);
	}
	
}