package com.onetouch.web.mtr.stck.dao;

import java.util.List;
import java.util.Map;

import com.onetouch.web.mtr.in.dao.MtrInVO;
import com.onetouch.web.mtr.in.dao.MtrSearchVO;

public interface MtrLotMapper {
	
	
	List<Map<String, Object>> listExcelCheckMtr(MtrSearchVO vo); //엑셀
	//List<Map<String, Object>> listExcelMtr();	//엑셀
	List<Map<String, Object>> listExcelLot(MtrSearchVO vo);	//엑셀
	List<LotVO> listLot(MtrSearchVO vo);
	List<LotVO> listMtr(MtrSearchVO vo);
	void insertLot(MtrInVO vo);
//	List<LotVO> selectLot(list);
}
