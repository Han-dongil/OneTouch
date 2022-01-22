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
	public List<PrcVO> prcFlowMinMax(PrcVO vo) {
//		String flowMax;=mapper.prcFlowMinMax(vo).get(0).getFlowMax();
//		String flowMin;=mapper.prcFlowMinMax(vo).get(0).getFlowMin();
		List<PrcVO> list=prcFlowMinMax(vo);
		int flowMax=0;
		int flowMin=100;
		// flow min max 구하는 for문
		for(PrcVO resultVo: list) {
			if(flowMax<Integer.parseInt(resultVo.getPrcSeq())) {
				flowMax=Integer.parseInt(resultVo.getPrcSeq());
			};
			if(flowMin>Integer.parseInt(resultVo.getPrcSeq())) {
				flowMin=Integer.parseInt(resultVo.getPrcSeq());
			}
		}
		if(flowMin==Integer.parseInt(vo.getPrcSeq())) {
			
		}
		
		
		return null;
	}
	

}
