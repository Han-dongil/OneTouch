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


@Controller
public class PropController {

	@Autowired ProdService prodservice;
	
	
	/*
	 * //모달창에서 점검대상 조회
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("prodChekList") public List<ProdVO> list(ProdVO prodVO){
	 * 
	 * List<ProdVO> list = new ArrayList<>(); list =
	 * prodservice.prodCheckSelectList(prodVO);
	 * System.out.println("점검대상 조회 컨트롤러 성공 "); System.out.println(list); return
	 * list; }
	 */
	
	//삭제, 수정, 등록처리 
	@ResponseBody
	@PostMapping("prodModifyData")
	public int modify(@RequestBody ModifyVO<ProdVO> mvo) {
		System.out.println("컨트롤값 보여주기");
		System.out.println("업데이트"+mvo.getUpdatedRows());
		System.out.println("등록"+mvo.getCreatedRows());
		System.out.println("삭제"+mvo.getDeletedRows());
		prodservice.modify(mvo);
		
		return -0;
	}	
			
			
	@ResponseBody
    @PostMapping("prodChekList")
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
	@PostMapping("prodSelect")
	public Map<String, Object> selectProd(@RequestBody ProdVO prodVO){
		Map<String, Object> datas = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("result", true);
		datas.put("contents", prodservice.prodSelect(prodVO));
		System.out.println("datas 맵 출력");
		System.out.println(datas);
		System.out.println("data 맵 출력");
		System.out.println(data);
		data.put("data", datas);
		return data;
	}
	
	
	//정기점검페이지 이동 
	@RequestMapping("ftcProd")
	public String moveList() {
		return"tiles/fct/prodIns";
	}
	
}
  