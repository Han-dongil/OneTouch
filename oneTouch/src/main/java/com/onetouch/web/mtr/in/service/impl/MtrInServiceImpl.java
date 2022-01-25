package com.onetouch.web.mtr.in.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onetouch.web.mtr.in.dao.MtrInMapper;
import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;
import com.onetouch.web.mtr.in.service.MtrInService;
import com.onetouch.web.mtr.stck.dao.MtrLotMapper;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MtrInServiceImpl implements MtrInService {
	SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
	Date time = new Date();
	@Autowired MtrInMapper inMapper;
	@Autowired MtrLotMapper lotMapper;
	@Override
	public List<MtrInVO> selectIn(MtrSearchVO inSearchVO) {
		return inMapper.selectIn(inSearchVO);
	}
	
	@Transactional
	public void modifyIn(ModifyVO<MtrInVO> mvo) {
		int no=0;
		int inAmt=0;
		int mngAmt=0;
		int quotient=0;
		int remainder=0;
		String seq="";
		String dt="";
		String in="";
		MtrInVO vo;
		
		//LOT번호 부여 + LOT별재고테이블 insert
		if(mvo.getCreatedRows() != null) {
			for(int i=0; i<mvo.getCreatedRows().size(); i++) {
				no = inMapper.selectInNo()+i;
				seq = String.format("%04d", no);
				dt = format1.format(time);
				in = "MIN"+ dt + seq;
				vo = mvo.getCreatedRows().get(i);
				vo.setInNo(in);
				vo.setStckCnt(vo.getMngAmt());
				inMapper.insertIn(vo);
				inMapper.updateOrd(vo);
				
				
				inAmt = Integer.parseInt(vo.getInAmt());
				mngAmt = Integer.parseInt(vo.getMngAmt());
				quotient = inAmt/mngAmt;
				remainder = inAmt%mngAmt;
				
					if(remainder > 0) {
						for(int j=0; j<quotient+1; j++) {
							lotMapper.insertLot(vo);
							if(j == quotient) {
								vo.setStckCnt(Integer.toString(remainder));
								lotMapper.insertLot(vo);
							}
						}
					} else {
						for(int j=0; j<quotient; j++) {
							lotMapper.insertLot(vo);
						}
					}
			}
		}
		if(mvo.getUpdatedRows() != null) {
		    for(MtrInVO data : mvo.getUpdatedRows()){
		    	inMapper.updateIn(data);
		    	};
		}
		if(mvo.getDeletedRows() != null) {
		    for(MtrInVO data : mvo.getDeletedRows()){
		    	inMapper.deleteIn(data); };
		}
	}


}
