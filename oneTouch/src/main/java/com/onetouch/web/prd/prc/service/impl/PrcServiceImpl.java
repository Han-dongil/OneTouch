package com.onetouch.web.prd.prc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.prd.prc.dao.PrcMapper;
import com.onetouch.web.prd.prc.dao.PrcVO;
import com.onetouch.web.prd.prc.service.PrcService;

@Service
public class PrcServiceImpl implements PrcService{
	@Autowired PrcMapper mapper;
	
	@Override
	public List<PrcVO> lineList() {
		return mapper.lineList();
	}

	@Override
	public List<PrcVO> prcList(String lineNo) {
		return mapper.prcList(lineNo);
	}

	@Override
	public List<PrcVO> prdPrcList(PrcVO vo) {
		return mapper.prdPrcList(vo);
	}

	@Override
	public PrcVO prcFlowMinMax(PrcVO vo) {
		List<PrcVO> list=mapper.prcFlowMinMax(vo);
		System.out.println(list);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaa");
		String msg;
		int flowMax=0;
		int flowMin=100;
		// flow min max 구하는 for문
		for(PrcVO resultVo: list) {
			System.out.println(resultVo);
			String a=resultVo.getPrcSeq().substring(0,1);
			if(flowMax<Integer.parseInt(a)) {
				flowMax=Integer.parseInt(a);
			};
			if(flowMin>Integer.parseInt(a)) {
				flowMin=Integer.parseInt(a);
			}
		}
		System.out.println("11111111111111111");
		
		String a=(mapper.myPrcFlow(vo)).getPrcSeq().substring(0,1);//내공정흐름번호
		System.out.println("공정흐름// 스타트시간합계체크");
		System.out.println(Integer.parseInt(a));
		//System.out.println(mapper.flowCheck(vo));
		System.out.println("111111111111111112222222222222");
		if(flowMin==Integer.parseInt(a)) { //공정흐름 1번이 들어온경우
			for(PrcVO insertVo:list) {
				System.out.println("2222222222222222222");
				System.out.println(insertVo);
				mapper.defaultInsert(insertVo);
			}
			System.out.println("555555555555555");
			mapper.startUpdate(vo); //시간업데이트
			vo=mapper.startTimeSelect(vo);  //입력된시간불러와서 리턴
			vo.setMsg("라인가동 시작!!!.");
			return vo;
		}else if(flowMin!=Integer.parseInt(a)&&mapper.lineStartCheck(vo)==null) { //1번흐름이아니고 line 셀렉트했는데 결과가 없는경우 (라인시작이안됨)
			vo.setMsg("라인가동안됨");
			System.out.println("33333333333333333333");
			return vo;
		}

		else if(Integer.parseInt(a)!=1 &&  Integer.parseInt(a)-1==mapper.flowCheck(vo)) { //1번흐름이 아니고 스타트시간찍힌애들의 합이 내플로우 -1과같을떄(라인시작o 앞공정시작o)
			System.out.println("444444444444444");
			mapper.startUpdate(vo); //시간업데이트
			vo=mapper.startTimeSelect(vo);
			vo.setMsg("공정시작!!.");
			return vo;
		}
		else if(Integer.parseInt(a)!=1 &&  Integer.parseInt(a)-1!=mapper.flowCheck(vo)){
			System.out.println("666666666666666");
			mapper.startTimeSelect(vo);
			vo.setMsg("앞공정시작안됨!!!.");
			return vo; 
		}
		return null;
	}
	

}
