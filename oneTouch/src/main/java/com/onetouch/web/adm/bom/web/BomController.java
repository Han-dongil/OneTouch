package com.onetouch.web.adm.bom.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.onetouch.web.adm.bom.service.BomService;

@Controller
public class BomController {

	@Autowired BomService bomservice;
	
	//제품Bom관리 보여주는 페이지로 이동
	@RequestMapping("BomList")
	public String bomList() {
		return "tiles/adm/admBomList";
	}
}
