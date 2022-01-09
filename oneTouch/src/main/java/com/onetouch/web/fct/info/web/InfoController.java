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

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.service.InfoService;

@Controller
public class InfoController {
	@Autowired InfoService service;
	@Autowired InfoMapper mapper;
	
	//목록조회 페이지이동
	@RequestMapping("ftcIhfoList")
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
	  
	  //스플릿 사용해서 배열에다가 넣기 스트링 밷열로 만들어지면 향상된 포문으로 서비스 돌리기 
	  @ResponseBody      
	  @PostMapping("deleteInfo")
	  public List<InfoVO> delete(@RequestBody List<InfoVO> del) {
		  System.out.println("!!!!!!!!!!");
		  System.out.println(del);
		  service.deleteFctInfo(del);
		  return service.selectFctInfoAll();
	  }
}
