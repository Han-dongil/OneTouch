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
		String a=(mapper.myPrcFlow(vo)).getPrcSeq().substring(0,1);//내공정흐름번호
		if(flowMin==Integer.parseInt(a)) { //공정흐름 1번이 들어온경우
			for(PrcVO insertVo:list) {
				System.out.println(insertVo);
				mapper.defaultInsert(insertVo);
			}
			mapper.startUpdate(vo); //시간업데이트
			vo=mapper.startTimeSelect(vo);  //입력된시간불러와서 리턴
			vo.setMsg("라인가동 시작!!!.");
			return vo;
		}else if(flowMin!=Integer.parseInt(a)&&mapper.lineStartCheck(vo).size()==0) { //1번흐름이아니고 line 셀렉트했는데 결과가 없는경우 (라인시작이안됨)
			vo.setMsg("라인가동안됨");
			return vo;
		}

		else if(Integer.parseInt(a)!=1 &&  Integer.parseInt(a)-1==mapper.flowCheck(vo)) { //1번흐름이 아니고 스타트시간찍힌애들의 합이 내플로우 -1과같을떄(라인시작o 앞공정시작o)
			mapper.startUpdate(vo); //시간업데이트
			vo=mapper.startTimeSelect(vo);
			vo.setMsg("공정시작!!.");
			return vo;
		}
		else{
			mapper.startTimeSelect(vo);
			vo.setMsg("앞공정시작안됨!!!.");
			return vo; 
		}
	}

	@Override
	public PrcVO prcEnd(PrcVO vo) {
		List<PrcVO> list=mapper.prcFlowMinMax(vo);
		int flowMax=0;
		int flowMin=100;
		PrcVO vo100 = new PrcVO();
		vo100=vo;
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
		String a=(mapper.myPrcFlow(vo)).getPrcSeq().substring(0,1);//내공정흐름번호
		if(flowMin==Integer.parseInt(a)) { //공정흐름 1번이 들어온경우
			mapper.endUpdate(vo); //시간업데이트
			vo=mapper.endTimeSelect(vo);  //입력된시간불러와서 리턴
			vo.setMsg("공정종료.");
			return vo;
		}
		else if(mapper.lineEndCheck(vo).get(0).getPrcEndNull()==0) { //라인종료시간찍힌 로우의 합이 0일때
			vo.setMsg("앞공정종료안됨!!!.");
			return vo; 
		}
		else if(Integer.parseInt(a)!=flowMax &&  Integer.parseInt(a)-1==mapper.endFlowCheck(vo)) { //1번흐름이 아니고 엔드시간찍힌애들의 합이 내플로우 -1과같을떄(앞공정종료o)
			mapper.endUpdate(vo); //시간업데이트
			vo=mapper.endTimeSelect(vo);
			vo.setMsg("공정종료!!.");
			return vo;
		}
		else if(Integer.parseInt(a)-1==mapper.endFlowCheck(vo) &&  Integer.parseInt(a)==flowMax) {
			mapper.endUpdate(vo100); //시간업데이트
			vo=mapper.endTimeSelect(vo100);
			//lot 번호 부여
			System.out.println(vo100);
			String sect=mapper.sectSelect(vo100);
			System.out.println(sect);
			if(sect.equals("PDT_SECT001")) {
				String lot=(mapper.insertHrdLotSelect(vo100)).getPrdLot();
				vo100.setPrdLot(lot);
				vo.setPrdLot(lot);
				mapper.hrdInsert(vo100);
			}
			else if(sect.equals("PDT_SECT002")) {
				String lot=(mapper.insertLotSelect(vo100)).getPrdLot();
				vo100.setPrdLot(lot);
				vo.setPrdLot(lot);
				System.out.println(vo100);
				mapper.prdInsert(vo100);
			}
			vo.setMsg("라인가동 종료!!.");
			return vo;
		}
		else{
			mapper.endTimeSelect(vo);
			vo.setMsg("앞공정종료안됨!!!.");
			return vo; 
		}
		
		
	}
//void updateFlt(PrcVO vo);
//	PrcVO realFlt(PrcVO vo);
	
	@Override
	public PrcVO selectCheck(PrcVO vo) {

		PrcVO vo2=new PrcVO();
		vo2=vo;
		String fltSave=mapper.realFlt(vo).getSumFlt();
		while(true){
			String flt=mapper.realFlt(vo2).getSumFlt();
			if(!fltSave.equals(flt)||fltSave==vo.getGoalCnt()) {
				return mapper.realFlt(vo);
			}
		}
	}

	
	@Override
	public void updateFlt(PrcVO vo) {
		mapper.updateFlt(vo); //1
	}

	@Override
	public void fastStop(PrcVO vo) {
		//긴급중단 좀더생각해보자.
		mapper.fastStopUpdate(vo);
		mapper.fastStop(vo);
		
	}
	
	
	
	

}
