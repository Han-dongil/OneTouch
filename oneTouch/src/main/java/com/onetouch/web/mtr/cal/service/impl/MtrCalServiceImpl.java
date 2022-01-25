package com.onetouch.web.mtr.cal.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.mtr.cal.dao.MtrCalMapper;
import com.onetouch.web.mtr.cal.dao.MtrCalVO;
import com.onetouch.web.mtr.cal.service.MtrCalService;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.stck.dao.LotVO;

@Service
public class MtrCalServiceImpl implements MtrCalService {
	@Autowired MtrCalMapper calMapper;
	@Override
	public List<MtrCalVO> selectCal(MtrSearchVO inSearchVO) {
		return calMapper.selectCal(inSearchVO);
	}
	@Override
	public List<LotVO> selectLot(MtrCalVO mtrCalVO) {
		return calMapper.selectLot(mtrCalVO);
	}
	
//	@Transactional
//	public void modifyIn(ModifyVO<MtrInVO> mvo) {
//		int no=0;
//		int inAmt=0;
//		int mngAmt=0;
//		int quotient=0;
//		int remainder=0;
//		String seq="";
//		String dt="";
//		String in="";
//		MtrInVO vo;
//		
//		//LOT번호 부여 + LOT별재고테이블 insert
//		if(mvo.getCreatedRows() != null) {
//			for(int i=0; i<mvo.getCreatedRows().size(); i++) {
//				no = inMapper.selectInNo()+i;
//				seq = String.format("%04d", no);
//				dt = format1.format(time);
//				in = "MIN"+ dt + seq;
//				vo = mvo.getCreatedRows().get(i);
//				vo.setInNo(in);
//				vo.setStckCnt(vo.getMngAmt());
//				inMapper.insertIn(vo);
//				inMapper.updateOrd(vo);
//				
//				
//				inAmt = Integer.parseInt(vo.getInAmt());
//				mngAmt = Integer.parseInt(vo.getMngAmt());
//				quotient = inAmt/mngAmt;
//				remainder = inAmt%mngAmt;
//				
//					if(remainder > 0) {
//						for(int j=0; j<quotient+1; j++) {
//							lotMapper.insertLot(vo);
//							if(j == quotient) {
//								vo.setStckCnt(Integer.toString(remainder));
//								lotMapper.insertLot(vo);
//							}
//						}
//					} else {
//						for(int j=0; j<quotient; j++) {
//							lotMapper.insertLot(vo);
//						}
//					}
//			}
//		}
//		if(mvo.getUpdatedRows() != null) {
//		    for(MtrInVO data : mvo.getUpdatedRows()){
//		    	inMapper.updateIn(data);
//		    	};
//		}
//		if(mvo.getDeletedRows() != null) {
//		    for(MtrInVO data : mvo.getDeletedRows()){
//		    	inMapper.deleteIn(data); };
//		}
//	}


}
