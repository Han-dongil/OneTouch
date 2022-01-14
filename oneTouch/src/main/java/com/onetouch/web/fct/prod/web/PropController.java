package com.onetouch.web.fct.prod.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PropController {

	//정기점검페이지 이동 
	@RequestMapping("ftcProd")
	public String moveList() {
		return"tiles/fct/ftcProd";
	}
	
}
