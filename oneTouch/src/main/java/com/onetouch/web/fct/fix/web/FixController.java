package com.onetouch.web.fct.fix.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.fct.fix.dao.FixMapper;
import com.onetouch.web.fct.fix.service.FixService;

@Controller
public class FixController {

	@Autowired FixService fservice;
	@Autowired FixMapper fmapper;
	
	
	//수리관리 페이지 이동 
	@RequestMapping("ftcFix")
	public String moveFic() {
		return "tiles/fct/fixIns";
	}
	//수리 목록 조회
	@ResponseBody
	@PostMapping("fctFixList")
	public List<FixVO> fixselect(@RequestBody FixVO fixVO){
			System.out.println("컨트롤러 조회 출력 ");
			List<FixVO> list = new ArrayList<>();
			list = fservice.fixSelectList(fixVO);
		return list;
	}
	
}
