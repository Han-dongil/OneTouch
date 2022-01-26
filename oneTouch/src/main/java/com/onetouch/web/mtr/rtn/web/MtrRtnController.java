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
import com.onetouch.web.mtr.rtn.dao.MtrRtnVO;
import com.onetouch.web.mtr.rtn.service.MtrRtnService;
import com.onetouch.web.zzz.dao.ModifyVO;
@RequestMapping("/mtr")
@Controller
public class MtrRtnController {

	@Autowired MtrRtnService service;
	
	@RequestMapping("/rtnForm")
	public String rtnForm() {
		return "tiles/mtr/mtrRtnForm";
	}
	
	//반품관리페이지에서 반품처리해야할 발주내역조회 
	@ResponseBody
	@PostMapping("/mtrRtnForm")
	public Map<String,Object> selectOrdList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", service.rtnList(searchVO));
		data.put("data", datas);
		return data;
	}
	
	//mainGrid modify
		@ResponseBody
		@PostMapping("/mtrRtnModify")
		public int mtrRtnModify(@RequestBody ModifyVO<MtrRtnVO> mvo){
			System.out.println("컨트롤러");
			System.out.println(mvo);
			service.modifyRtn(mvo);
			 return 0;
		}
	
	@RequestMapping("/rtnList")
	public String rtnList() {
		return "tiles/mtr/mtrRtnList";
	}
	
	//반품조회페이지에서 반품처리내역 조회
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
	
	
//	//mtrRtnGrid readData
//	@ResponseBody
//	@PostMapping("/mtrRtnModal")
//	public Map<String,Object> rtnList(@RequestBody MtrSearchVO searchVO){
//		Map<String,Object> datas = new HashMap<>();
//		Map<String,Object> data = new HashMap<>();
//		data.put("result", true);
//		datas.put("contents", mtrRtnService.rtnList(searchVO));
//		data.put("data", datas);
//		return data;
//	}
//	//mtrRtnGrid modifyData
//	@ResponseBody
//	@PostMapping("/mtrRtnModify")
//	public int rtnModify(@RequestBody ModifyVO<MtrRtnVO> mvo){
//		 mtrRtnService.modifyRtn(mvo);
//		return 0;
//	}
}
