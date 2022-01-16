
package com.onetouch.web.mtr.in.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.in.service.MtrInService;
import com.onetouch.web.mtr.ord.service.MtrOrdService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Controller
public class MtrInFormController {

	@Autowired MtrInService inService;
	@Autowired MtrOrdService mtrOrdService;
	
	@RequestMapping("inForm")
	public String inForm() {
		return "tiles/mtr/mtrInForm";
	}
	
	//grid readData
	@ResponseBody
	@PostMapping("/mtrInForm")
	public Map<String,Object> selectInList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", inService.selectIn(searchVO));
		data.put("data", datas);
		return data;
	}
	
	//grid modify
	@ResponseBody
	@PostMapping("/mtrModify")
	public int modify(@RequestBody ModifyVO<MtrInVO> mvo){
		inService.modifyIn(mvo);
		 return 0;
	}
	
	//mtrOrd modal
	@ResponseBody
	@GetMapping("/mtrOrdModal")
	public Map<String,Object> ordList(){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", mtrOrdService.ordMtrList());
		data.put("data", datas);
		return data;
	}
	
	
	
}
