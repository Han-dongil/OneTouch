
package com.onetouch.web.mtr.in.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.in.service.MtrInService;
@RequestMapping("/mtr")
@Controller
public class MtrInListController {

	@Autowired MtrInService service;
	
	@RequestMapping("/inList")
	public String inForm() {
		return "tiles/mtr/mtrInList";
	}
	
	//조건조회 grid
	@ResponseBody
	@PostMapping("/mtrInList")
	public Map<String,Object> selectInList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", service.selectIn(searchVO));
		data.put("data", datas);
		return data;
	}
	
}
