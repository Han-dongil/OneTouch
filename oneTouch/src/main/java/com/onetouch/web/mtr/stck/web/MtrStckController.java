package com.onetouch.web.mtr.stck.web;

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

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.service.BasService;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.service.MtrLotService;
@Controller
public class MtrStckController {

	@Autowired MtrLotService service;
	@Autowired BasService basService;
	
	@RequestMapping("stckList")
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
	@GetMapping("mtrStckRadio")
	public List<BasDtlVO> mtrStckRadio(){
		BasDtlVO vo=new BasDtlVO();
		vo.setBasCd("MTR_SECT");
		return basService.selectUseBasDtl(vo);
	}
}
