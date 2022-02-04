package com.onetouch.web.sts.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.onetouch.web.sts.service.StsService;

@RequestMapping("/sts")
@Controller
public class StsController {

	@Autowired StsService stsservice;
	
	//통계 보여주는 페이지로 이동
	@RequestMapping("/stsList")
	public String stsList() {
		return "tiles/sts/stsList";
	}
}
