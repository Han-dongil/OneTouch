
package com.onetouch.web.mtr.inForm.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.inForm.dao.InSearchVO;
import com.onetouch.web.mtr.inForm.dao.InVO;
import com.onetouch.web.mtr.inForm.service.InService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Controller
public class InController {

	@Autowired InService service;
	
	@RequestMapping("inForm")
	public String inForm() {
		return "tiles/mtr/mtrInForm";
	}
	
	//조건조회 grid
	@ResponseBody
	@PostMapping("/mtrInForm")
	public Map<String,Object> selectInList(@RequestBody InSearchVO in){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		System.out.println(in.getDitemCode());
		data.put("result", true);
		datas.put("contents", service.select(in));
		data.put("data", datas);
		return data;
	}
	
	@ResponseBody
	@PostMapping("/mtrModify")
	public boolean modify(@RequestBody ModifyVO<InVO> mvo){
		 service.modify(mvo);
		 return true;
	}
	
}
