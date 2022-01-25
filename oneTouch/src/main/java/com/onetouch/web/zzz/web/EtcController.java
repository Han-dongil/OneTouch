package com.onetouch.web.zzz.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasVO;
import com.onetouch.web.adm.bas.service.BasService;
import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.bom.service.BomService;
import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.adm.mng.service.MngService;
import com.onetouch.web.adm.mtr.dao.MtrVO;
import com.onetouch.web.adm.mtr.service.MtrService;
import com.onetouch.web.zzz.dao.MsgAltVO;
import com.onetouch.web.zzz.service.MsgAltService;

@Controller
public class EtcController {
	
	@Autowired MsgAltService service;
	@Autowired BasService basService;
	@Autowired MtrService mtrService;
	@Autowired BomService bomService;
	@Autowired MngService mngService;
	
	@RequestMapping("msgAlt")
	public String msgAltList() {
		
		return "tiles/zzz/msgAlt";
	}
	
	@ResponseBody
	@GetMapping("msgAltList")
	public List<MsgAltVO> selectAll(){
		List<MsgAltVO> list = service.selectAll();
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("msgAltDateList")
	public List<MsgAltVO> selectDate(MsgAltVO vo){
		List<MsgAltVO> list = service.selectDate(vo);
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("msgAltDelete")
	public List<MsgAltVO> delete(@RequestBody List<MsgAltVO> list){
		System.out.println(list);
		service.delete(list);
		
		return service.selectAll();
	}
	
	@ResponseBody
	@PostMapping("msgAltDept")
	public List<MsgAltVO> selectDept(MsgAltVO vo) {
		return service.selectDept(vo);
	}
	
	@ResponseBody
	@PostMapping("updateAltChkY")
	public void updateAltChkY(MsgAltVO vo) {
		service.updateAltChkY(vo);
	}

	
	
//	//modal호출 - 발주
//	@RequestMapping("modalMtr")
//	public String modalMtrOrd() {
//		return "zzz/modalMtr";
//	}
//	
//	@ResponseBody
//	@GetMapping("modalMtrOrdList")
//	public List<MtrVO> modalMtrOrdList(){
//		List<MtrVO> list = new ArrayList<MtrVO>();		
//		list = mtrService.selectAdmMtrAll();
//		System.out.println(list);
//		return list;
//	}
	//modal호출 - 자재
	@RequestMapping("modalMtr")
	public String modalMtr() {
		return "zzz/modalMtr";
	}
	
	@ResponseBody
	@GetMapping("modalMtrList")
	public List<MtrVO> modalMtrList(){
		List<MtrVO> list = mtrService.selectUseAdmMtr();
		System.out.println(list);
		
		return list;
	}
	//-----------------------------
	
	//modal호출 - 제품
	@RequestMapping("modalPrd")
	public String modalPrd() {
		return "zzz/modalPrd";
	}
	
	@ResponseBody
	@GetMapping("modalPrdList")
	public List<PrdVO> modalPrdList(){
		List<PrdVO> list = bomService.selectUsePrdAll(); 
		System.out.println(list);
		
		return list;
	}
	//-----------------------------
	
	//modal호출 - 공정
	@RequestMapping("modalPrc")
	public String modalPrc() {
		return "zzz/modalPrc";
	}
	
	@ResponseBody
	@GetMapping("modalPrcList")
	public List<MngVO> modalPrcList(){
		List<MngVO> list = mngService.selectPrcMng(); //머지하고 새로하기  selectUsePrc
		System.out.println(list);
		
		return list;
	}
	//-----------------------------
	
	
	//modal호출 - 공통
	@RequestMapping("modalBas")
	public String modalBas() {
		return "zzz/modalBas";
	}
	
	@ResponseBody
	@PostMapping("modalBasList")
	public List<BasDtlVO> modalBasList(String basCd){
		BasDtlVO vo = new BasDtlVO();
		vo.setBasCd(basCd);
		System.out.println(vo);
		
		List<BasDtlVO> list = basService.selectBasDtl(vo); //selectUseBasDtl 에 where절 조건에 bas_cd 추가되면 수정하기
		System.out.println(list);
		
		return list;
	}
	

	//-----------------------------
	
	//modal호출 - 공통2
	@RequestMapping("modalBas2")
	public String modalBas2() {
		return "zzz/modalBas2";
	}
	
	
	@ResponseBody
	@GetMapping("modalBas2List")
	public List<BasVO> modalBasList2(){
		List<BasVO> list = basService.selectBasAll(null);
		System.out.println(list);
		
		return list;
	}
	
}
