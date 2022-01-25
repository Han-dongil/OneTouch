
package com.onetouch.web.mtr.cal.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.cal.service.MtrCalService;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
@RequestMapping("/mtr")
@Controller
public class MtrCalController {

	@Autowired MtrCalService mtrCalService;
	
	@RequestMapping("/calList")
	public String calList() {
		return "tiles/mtr/mtrCalList";
	}
	
	//mainGrid readData
	@ResponseBody
	@PostMapping("/mtrCalList")
	public Map<String,Object> selectCalList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		System.out.println("searchVO");
		System.out.println(searchVO);
		datas.put("contents", mtrCalService.selectCal(searchVO));
		data.put("data", datas);
		return data;
	}
	
//	@RequestMapping("/calForm")
//	public String calForm() {
//		return "tiles/mtr/mtrCalForm";
//	}
//	
	/*
	 * //mainGrid readData
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/mtrCalForm") public Map<String,Object>
	 * selectCalForm(@RequestBody MtrSearchVO searchVO){ Map<String,Object> datas =
	 * new HashMap<>(); Map<String,Object> data = new HashMap<>();
	 * data.put("result", true); datas.put("contents",
	 * mtrInService.selectIn(searchVO)); data.put("data", datas); return data; }
	 * 
	 * //mainGrid modify
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/mtrModify") public int modify(@RequestBody ModifyVO<MtrInVO>
	 * mvo){ mtrInService.modifyIn(mvo); return 0; }
	 * 
	 * //mtrOrdGrid readData
	 * 
	 * @ResponseBody
	 * 
	 * @GetMapping("/mtrOrdModal") public Map<String,Object> ordList(){
	 * Map<String,Object> datas = new HashMap<>(); Map<String,Object> data = new
	 * HashMap<>(); data.put("result", true); datas.put("contents",
	 * mtrOrdService.ordMtrList()); data.put("data", datas); return data; }
	 */
}
