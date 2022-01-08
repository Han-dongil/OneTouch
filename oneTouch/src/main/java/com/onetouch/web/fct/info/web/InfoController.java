package com.onetouch.web.fct.info.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.service.InfoService;

@Controller
public class InfoController {
	@Autowired InfoService service;
	@Autowired InfoMapper mapper;
	
	//목록조회 페이지이동
	@RequestMapping("fctInfo")
	public String moveList( ) {
		
		return "tiles/fct/info";
	}
	
	  //목록조회 처리
	  @ResponseBody
	  @GetMapping("list1") 
	  public List<InfoVO> list( ) {
		  List<InfoVO> list = new ArrayList<>();
		  list = service.selectFctInfoAll();
		  System.out.println(list);
	  return list; 
	  }
}
