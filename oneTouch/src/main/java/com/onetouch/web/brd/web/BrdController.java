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
	
	@RequestMapping("/dashBoard")
	public String brdList(Model model){
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
		
		
		List<PrcVO> pdtList = new ArrayList<>();
		pdtList = brdService.pdtList();
		
		List<PrcVO> before = new ArrayList<>();
		List<PrcVO> progress = new ArrayList<>();
		List<PrcVO> done = new ArrayList<>();
		
		for(int i = 0; i < pdtList.size(); i++) {
			if(pdtList.get(i).getGoalCnt() == null ) {
				before.add(pdtList.get(i));
				System.out.println("44"+progress);
			} else if(pdtList.get(i).getNowPhs().equals("라인가동종료")) {
				done.add(pdtList.get(i));
				System.out.println("55"+done);
			} else if(pdtList.get(i).getNowPhs().equals("가동중")||pdtList.get(i).getNowPhs()==null){
				progress.add(pdtList.get(i));
				System.out.println("66"+progress);
			}
		};
		System.out.println("11"+listWarning);
		System.out.println("22"+listCaution);
		System.out.println("33"+before);
		model.addAttribute("listWarning", listWarning);
		model.addAttribute("listCaution", listCaution);
		model.addAttribute("before", before);
		model.addAttribute("progress", progress);
		model.addAttribute("done", done);
		model.addAttribute("fctList", brdService.fctList());
		return "tiles/brd/dashBoard";
		}
	
	@ResponseBody
	@GetMapping("dashBoardData")
	public List<List<PrcVO>> dashBoardPrc(){
	return prcService.dashBoardData();
	}
}
