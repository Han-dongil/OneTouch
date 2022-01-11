package com.onetouch.web.fct.info.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.fct.info.dao.AdmBasDtlCdVO;
import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.service.InfoService;

@Controller
public class InfoController {
	@Autowired InfoService service;
	@Autowired InfoMapper mapper;
	
	
	//수정
	  @ResponseBody
	  @PostMapping("Updateinfo")
	  public List<InfoVO> InfoUpdate(InfoVO infoVO) {
		  service.InfoUpdate(infoVO);
		  System.out.println("확인하기 업데이트 문제에서 조회 조건");
		  System.out.println(infoVO.getCheckPrcCd());
		  return service.selectFctInfoAll(infoVO);
	  }
	
	//공정코드 조회 
	@ResponseBody
	@GetMapping("selectPrc")
	public List<AdmBasDtlCdVO> showPrc() {
		List<AdmBasDtlCdVO> list = new ArrayList<>();
		list = service.selectPrcCd();
		return list;
	}
	
	//목록조회 페이지이동
	@RequestMapping("ftcIhfoIns")
	public String moveList( ) {
		
		
		
		return "tiles/fct/infoIns";
	}
	
	//목록조회 페이지이동
	@RequestMapping("ftcIhfoSel")
	public String showList( ) {
		
		
		
		return "tiles/fct/infoSel";
	}
	
	  //목록조회 처리
	  @ResponseBody
	  @PostMapping("list1") //s는 공정코드 키 값으로 들어감 
	  public List<InfoVO> list(@RequestBody InfoVO infoVO) {
		  System.out.println("검색조건 넘어온지 확인하기 ");
		  System.out.println(infoVO.getCheckPrcCd());
		  List<InfoVO> list = new ArrayList<>();
		  list = service.selectFctInfoAll(infoVO);
	  return list; 
	  }
	  
	
	  @ResponseBody      
	  @PostMapping("deleteInfo")
	  public List<InfoVO> delete(@RequestBody List<InfoVO> del,InfoVO infoVO) {
		 
		  service.deleteFctInfo(del);
		  return service.selectFctInfoAll(infoVO);
	  }
	  
	  @ResponseBody
	  @PostMapping("infoInsert")
	  public List<InfoVO> InfoInsert(InfoVO infoVO) {
		 
		  service.insertFctInfo(infoVO);
		  return service.selectFctInfoAll(infoVO);
	  }
}
