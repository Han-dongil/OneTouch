
package com.onetouch.web.mtr.out.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.out.service.MtrOutService;
@RequestMapping("/mtr")
@Controller
public class MtrOutListController {

	@Autowired MtrOutService outService;
	
	@RequestMapping("/outList")
	public String outForm() {
		return "tiles/mtr/mtrOutList";
	}
	
	//grid readData
	@ResponseBody
	@PostMapping("/mtrOutList")
	public Map<String,Object> selectOutList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", outService.selectOut(searchVO));
		data.put("data", datas);
		return data;
	}
	
//	//mtrOrd modal
//	@ResponseBody
//	@GetMapping("/mtrOrdModal")
//	public Map<String,Object> ordList(){
//		Map<String,Object> datas = new HashMap<>();
//		Map<String,Object> data = new HashMap<>();
//		data.put("result", true);
//		datas.put("contents", mtrOrdService.ordMtrList());
//		data.put("data", datas);
//		return data;
//	}
	
	
	
}
