package com.onetouch.web.prd.prc.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.prd.prc.dao.PrcVO;
import com.onetouch.web.prd.prc.service.PrcService;

@Controller
public class PrcController {
	
	@Autowired PrcService service;
	
	@RequestMapping("prdPrcList")
	public String pdtListPage() {
		
		return "tiles/pdt/pdtPrcMng";
		
	}
	
	@ResponseBody
	@GetMapping("lineList")
	public List<PrcVO> lineList(){
		return service.lineList();
	}
	@ResponseBody
	@GetMapping("prcCdFromlineNo/{lineNo}")
	public List<PrcVO> prcCdFromlineNo(@PathVariable String lineNo){
		return service.prcList(lineNo);
	}
	@ResponseBody
	@PostMapping("prdPrcList")
	public List<PrcVO> prdPrcList(@RequestBody PrcVO vo) {
		return service.prdPrcList(vo);
	}
	@ResponseBody
	@PostMapping("prcStart")
	public PrcVO prcStart(@RequestBody List<PrcVO> list){
		System.out.println(list);
		PrcVO vo = new PrcVO();
		vo=list.get(0);
		return service.prcFlowMinMax(vo);
	}
	@ResponseBody
	@PostMapping("prcEnd")
	public PrcVO prcEnd(@RequestBody List<PrcVO> list) {
		
		return service.prcEnd(list.get(0));
	}
	@ResponseBody
	@PostMapping("fltCheck")
	public PrcVO fltCheck(@RequestBody List<PrcVO> list) {
		
		return service.selectCheck(list.get(0));
	}
	
}