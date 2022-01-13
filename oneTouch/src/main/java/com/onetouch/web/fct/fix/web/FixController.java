package com.onetouch.web.fct.fix.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.fct.fix.dao.FixMapper;
import com.onetouch.web.fct.fix.dao.FixVO;
import com.onetouch.web.fct.fix.service.FixService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Controller
public class FixController {

	@Autowired FixService fservice;
	@Autowired FixMapper fmapper;
	
	//수리관리 페이지 이동 
	@RequestMapping("ftcFix")
	public String moveFic() {
		return "tiles/fct/fixIns";
	}
	
	/*
	 * 이 형태로 만들어줘야함 { "result": true, "data": { "contents": [], "pagination": {
	 * "page": 1, "totalCount": 100 } } }
	 */
	
    @ResponseBody
    @PostMapping("fctFixList")
    public Map<String,Object> selectFixList(@RequestBody FixVO fixVO){
    	Map<String, Object> datas = new HashMap<>();
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	datas.put("contents", fservice.fixSelectList(fixVO));
    	data.put("data", datas);
    	return data;
    }
    
    //삭제,수정,등록 처리
    @ResponseBody
    @PostMapping("fctModifyData")
    public int modify(@RequestBody ModifyVO<FixVO> mvo) {
    	System.out.println("컨트롤러 값 보여주기 ^^^^^^^^^^^^^^^^^^^^^^^");
    	System.out.println(mvo.getUpdatedRows().get(0).getFixCd());
    	fservice.modify(mvo);
    	
    	return 0; 
    	
    }
	

}
