package com.onetouch.web.fct.dwtm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DwtmController {

	@RequestMapping("ftcDwtmIns")
	public String moveDwtmPage() {
		
		return "tiles/fct/dwtmIns";
	}
}
