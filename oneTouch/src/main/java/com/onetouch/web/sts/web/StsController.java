package com.onetouch.web.sts.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.sts.dao.StsVO;
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
	
	//자재입고량--------------------------------------------------------
		//일별 조회
		@ResponseBody
		@GetMapping("/mtrInDate")
		public Map<String, Object> mtrInDate(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.mtrInDate(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//월별 조회
		@ResponseBody
		@GetMapping("/mtrInMonth")
		public Map<String, Object> mtrInMonth(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.mtrInMonth(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//연도별 조회
		@ResponseBody
		@GetMapping("/mtrInYear")
		public Map<String, Object> mtrInYear(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.mtrInYear(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//자재별 , 일별 조회
		@ResponseBody
		@GetMapping("/mtrInMtrD")
		public Map<String, Object> mtrInMtrD(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.mtrInMtrD(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//자재별 , 월별 조회
		@ResponseBody
		@GetMapping("/mtrInMtrM")
		public Map<String, Object> mtrInMtrM(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.mtrInMtrM(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//자재별 , 연도별 조회
		@ResponseBody
		@GetMapping("/mtrInMtrY")
		public Map<String, Object> mtrInMtrY(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.mtrInMtrY(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
	
	
	//자재출고량--------------------------------------------------------
		//일별 조회
		//월별 조회
		//연도별 조회
		//자재별,일별 조회
		//자재별,월별 조회
		//자재별,연도별 조회
		
	//제품생산량--------------------------------------------------------
		//일별 조회
		@ResponseBody
		@GetMapping("/pdtDate")
		public Map<String, Object> pdtDate(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.pdtDate(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//월별 조회
		@ResponseBody
		@GetMapping("/pdtMonth")
		public Map<String, Object> pdtMonth(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.pdtMonth(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//연도별 조회
		@ResponseBody
		@GetMapping("/pdtYear")
		public Map<String, Object> pdtYear(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.pdtYear(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//자재별,일별 조회
		@ResponseBody
		@GetMapping("/pdtPrdD")
		public Map<String, Object> pdtPrdD(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.pdtPrdD(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//자재별,월별 조회
		@ResponseBody
		@GetMapping("/pdtPrdM")
		public Map<String, Object> pdtPrdM(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.pdtPrdM(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
		//자재별,연도별 조회
		@ResponseBody
		@GetMapping("/pdtPrdY")
		public Map<String, Object> pdtPrdY(StsVO stsvo) {
			Map<String, Object> map = new HashMap<>();
			map.put("contents", stsservice.pdtPrdY(stsvo));
	
			Map<String, Object> maps = new HashMap<>();
			maps.put("result", true);
			maps.put("data", map);
	
			return maps;
		}
		
	//제품불량량--------------------------------------------------------
		//일별 조회
		//월별 조회
		//연도별 조회
		//자재별,일별 조회
		//자재별,월별 조회
		//자재별,연도별 조회
}
