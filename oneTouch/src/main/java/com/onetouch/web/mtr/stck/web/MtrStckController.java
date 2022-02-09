package com.onetouch.web.mtr.stck.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.service.BasService;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.MtrLotMapper;
import com.onetouch.web.mtr.stck.service.MtrLotService;
@RequestMapping("/mtr")
@Controller
public class MtrStckController {

	@Autowired MtrLotService service;
	@Autowired BasService basService;
	@Autowired MtrLotMapper LotMapper;
	
	//엑셀출력
		@ResponseBody
		@PostMapping("/mtrExcelTwoView.do")
		public ModelAndView excelTwoView(@RequestBody MtrSearchVO searchVO ) throws IOException{
			List<Map<String, Object>> list = LotMapper.listExcelCheckMtr();
			HashMap<String, Object> map = new HashMap<String, Object>(); 
			
			map.put("filename", "excel_dept");
			map.put("datas", list);
			return new ModelAndView("mtrExcelTwoView", map);
		}
		
	//엑셀출력
	@RequestMapping("/LotExcelView.do")
	public ModelAndView excelView() throws IOException{
		List<Map<String, Object>> list = LotMapper.listExcelLot();
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		map.put("filename", "excel_dept");
		map.put("datas", list);
		return new ModelAndView("LotExcelView", map);
	}
	
	@RequestMapping("/stckList")
	public String stckList() {
		return "tiles/mtr/mtrStckList";
	}
	
	//lot grid
	@ResponseBody
	@PostMapping("/lotStckList")
	public Map<String,Object> selectLotList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", service.listLot(searchVO));
		data.put("data", datas);
		return data;
	}
	//mtr grid
	@ResponseBody
	@PostMapping("/mtrStckList")
	public Map<String,Object> selectMtrList(@RequestBody MtrSearchVO searchVO){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", service.listMtr(searchVO));
		data.put("data", datas);
		return data;
	}
	//radio
	@ResponseBody
	@GetMapping("/mtrStckRadio")
	public List<BasDtlVO> mtrStckRadio(){
		BasDtlVO vo=new BasDtlVO();
		vo.setBasCd("MTR_SECT");
		return basService.selectUseBasDtl(vo);
	}
}
