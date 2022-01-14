
package com.onetouch.web.mtr.inForm.web;

import java.util.HashMap;
import java.util.List;
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
import com.onetouch.web.mtr.ord.dao.MtrOrdVO;
import com.onetouch.web.mtr.ord.service.MtrOrdService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Controller
public class InFormController {

	@Autowired InService inService;
	@Autowired MtrOrdService mtrOrdService;
	
	@RequestMapping("inForm")
	public String inForm() {
		return "tiles/mtr/mtrInForm";
	}
	
	//grid readData
	@ResponseBody
	@PostMapping("/mtrInForm")
	public Map<String,Object> selectInList(@RequestBody InSearchVO in){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", inService.selectIn(in));
		data.put("data", datas);
		return data;
	}
	
	//grid modify
	@ResponseBody
	@PostMapping("/mtrModify")
	public int modify(@RequestBody ModifyVO<InVO> mvo){
		inService.modifyIn(mvo);
		 return 0;
	}
	
	//mtrOrd modal
	@ResponseBody
	@PostMapping("/mtrOrdModal")
	public List<MtrOrdVO> ordList(){
		List<MtrOrdVO> list = mtrOrdService.ordMtrList();
		return list;
	}
	
	
	
}
