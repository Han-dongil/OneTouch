package com.onetouch.web.adm.bom.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.service.BomService;
import com.onetouch.web.adm.flw.dao.FlwMapper;
import com.onetouch.web.adm.flw.dao.FlwVO;
import com.onetouch.web.adm.flw.service.FlwService;
import com.onetouch.web.zzz.dao.ModifyVO;

@RequestMapping("/adm")
@Controller
public class BomController { 

	@Autowired BomService bomservice;
	@Autowired FlwService flwservice;
	@Autowired FlwMapper flwmapper;
	
	//제품Bom관리 보여주는 페이지로 이동
	@RequestMapping("/BomList")
	public String bomList() {
		return "tiles/adm/admBomList";
	}
	
	//제품코드 클릭하면 제품에 해당하는 자재들 보여주기(bom)
	@ResponseBody
	@GetMapping("/admBomList")
	public Map<String, Object> BomList(BomVO bomvo) {
		System.out.println(bomvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", bomservice.selectBomDtl(bomvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//삭제수정등록 처리
	@ResponseBody
	@PostMapping("/bomModifyData")
	public List<BomVO> modify(@RequestBody ModifyVO<BomVO> mvo) {
		BomVO bomvo = new BomVO();
		System.out.println("modify" + mvo);
		bomservice.modify(mvo);
		if(mvo.getCreatedRows().size() > 0) {
			bomvo.setPrdCd(mvo.getCreatedRows().get(0).getPrdCd());
		}
		if(mvo.getUpdatedRows().size() > 0) {
			bomvo.setPrdCd(mvo.getUpdatedRows().get(0).getPrdCd());
		}
		if(mvo.getDeletedRows().size() > 0) {
			bomvo.setPrdCd(mvo.getDeletedRows().get(0).getPrdCd());
		}
		return bomservice.selectBomDtl(bomvo);
	}
	
	//bom 넣으면 공정흐름에도 추가되기(prdCd,prcCd,prcSeq만)
	@ResponseBody
	@PostMapping("/bomFlwInsert")
	public void bomFlwInsert(@RequestBody List<FlwVO> maps) {
		System.out.println("mmmmmm"+maps);
		for(FlwVO flwvo : maps) {
			System.out.println("controller"+flwvo);
			flwmapper.bomFlwInsert(flwvo);			
		}
	}
	
	//bom에서 지우면 공정흐름에도 삭제되기
	@ResponseBody
	@PostMapping("/bomFlwDelete")
	public void bomFlwDelete(@RequestBody List<BomVO> maps) {
		System.out.println("삭제ㅔㅔㅔ"+maps);
		for(BomVO bomvo : maps) {
			System.out.println("controller"+bomvo);
			flwmapper.bomFlwDelete(bomvo);			
		}
	}
	
	//bom에서 수정하면 공정흐름에도 수정되기
		@ResponseBody
		@PostMapping("/bomFlwUpdate")
		public void bomFlwUpdate(@RequestBody List<BomVO> maps) {
			System.out.println("수정ㅇㅇㅇ"+maps);
			for(BomVO bomvo : maps) {
				System.out.println("controller"+bomvo);
				flwmapper.bomFlwUpdate(bomvo);			
			}
		}
	
}
