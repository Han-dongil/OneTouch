package com.onetouch.web.fct.prod.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.fct.prod.dao.ProdVO;
import com.onetouch.web.fct.prod.service.ProdService;
import com.onetouch.web.zzz.dao.ModifyVO;

@RequestMapping("/fct")
@Controller
public class PropController {

	@Autowired ProdService prodservice;
	
	
	//차기점검일 조회
	@ResponseBody
	@PostMapping("/selectchkExpectDt")
	public ProdVO selecteXPECTdT(@RequestBody ProdVO prodVO) {
		System.out.println("차기점검일 컨트롤러 실행완료");
		return prodservice.selectchkExpectDt(prodVO);
	}
	
	//삭제, 수정, 등록처리 
	@ResponseBody
	@PostMapping("/prodModifyData")
	public int modify(@RequestBody ModifyVO<ProdVO> mvo) {
		System.out.println("컨트롤값 보여주기");
		System.out.println("업데이트"+mvo.getUpdatedRows());
		System.out.println("등록"+mvo.getCreatedRows());
		System.out.println("삭제"+mvo.getDeletedRows());
		prodservice.modify(mvo);
		
		return -0;
	}	
			
			
	@ResponseBody
    @PostMapping("/prodChekList")
    public Map<String,Object> selectFixList(@RequestBody ProdVO prodVO){
    	Map<String, Object> datas = new HashMap<>();
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	datas.put("contents", prodservice.prodCheckSelectList(prodVO));
    	data.put("data", datas);
    	System.out.println("검색 조건 확인하기");
    	System.out.println(data);
    	return data;
    }
	
	//정기점검 조회 
	@ResponseBody
	@PostMapping("/prodSelect")
	public Map<String, Object> selectProd(@RequestBody ProdVO prodVO){
		Map<String, Object> datas = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", prodservice.prodSelect(prodVO));
		System.out.println("prodVO chkDt 출력");
		System.out.println(prodservice.prodSelect(prodVO));
		
		data.put("data", datas);
		return data;
	}
	
	
	//정기점검페이지 이동 
	@RequestMapping("/fctProd")
	public String moveList() {
		return"tiles/fct/prodIns";
	}
	
}
  