
package com.onetouch.web.mtr.in.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.onetouch.web.mtr.in.dao.MtrInMapper;
import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.in.service.MtrInService;
@RequestMapping("/mtr")
@Controller
public class MtrInListController {

	@Autowired MtrInService service;
	@Autowired MtrInMapper mapper;
	
	@RequestMapping("/inList")
	public String inForm() {
		return "tiles/mtr/mtrInList";
	}
	
	//엑셀출력
	@RequestMapping("/MtrExcelView.do")
	public ModelAndView excelView() throws IOException{
		System.out.println("통신완료");
		List<Map<String, Object>> list = mapper.selectExcelIn();
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		System.out.println("리스트 보여주기");
		System.out.println(list );
		map.put("filename", "excel_dept");
		map.put("datas", list);
		return new ModelAndView("mtrExcelView", map);
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
		System.out.println(searchVO);
		System.out.println(service.selectIn(searchVO));
		return data;
	}
	
	//발주번호 list
	 @ResponseBody
	  @PostMapping("/inputOrdList")
	  public List<MtrInVO> inputOrdList(MtrSearchVO searchVO){
		 System.out.println(searchVO);
		 System.out.println(mapper.selectOrdNo(searchVO));
	  return mapper.selectOrdNo(searchVO);
	  }
}
