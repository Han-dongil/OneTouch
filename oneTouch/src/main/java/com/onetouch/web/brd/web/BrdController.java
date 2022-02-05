package com.onetouch.web.brd.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.brd.service.BrdService;
import com.onetouch.web.mtr.stck.dao.LotVO;
import com.onetouch.web.prd.prc.dao.PrcVO;
import com.onetouch.web.prd.prc.service.PrcService;
@RequestMapping("/brd")
@Controller
public class BrdController {
	
	@Autowired BrdService brdService;
	@Autowired PrcService prcService;
	
//	@RequestMapping("/dashBoard")
//	public String dashBoard() {
//		return "tiles/brd/dashBoard";
//	}
	
	@RequestMapping("/dashBoard")
	public String brdList(Model model){
		System.out.println(brdService.mtrList());
		List<LotVO> mtrList = new ArrayList<>();
		mtrList = brdService.mtrList();
		
		List<LotVO> listWarning = new ArrayList<>();
		List<LotVO> listCaution = new ArrayList<>();
		
		for(int i = 0; i < mtrList.size(); i++) {
			if(Integer.parseInt(mtrList.get(i).safeStck) > Integer.parseInt(mtrList.get(i).stckUse)) {
				listWarning.add(mtrList.get(i));
			} else if(Integer.parseInt(mtrList.get(i).safeStck)*1.5 > Integer.parseInt(mtrList.get(i).stckUse)) {
				listCaution.add(mtrList.get(i));
			}
		};
		
		model.addAttribute("listWarning", listWarning);
		model.addAttribute("listCaution", listCaution);
		model.addAttribute("fctList", brdService.fctList());
		model.addAttribute("pdtList", brdService.pdtList());
		return "tiles/brd/dashBoard";
	}
	
		@ResponseBody
	   @GetMapping("dashBoardData")
	   public List<List<PrcVO>> dashBoardPrc(){
		return prcService.dashBoardData();
	   }
	
}
