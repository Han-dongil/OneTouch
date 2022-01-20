
package com.onetouch.web.mtr.rtn.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.rtn.service.MtrRtnService;

@Controller
public class MtrRtnListController {

	@Autowired MtrRtnService service;
	
	@RequestMapping("RtnList")
	public String inForm() {
		return "tiles/mtr/mtrRtnList";
	}
	
	//조건조회 grid
	@ResponseBody
	@PostMapping("/mtrRtnList")
	public Map<String,Object> selectRtnList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", service.selectRtn(searchVO));
		data.put("data", datas);
		return data;
	}
	
}
