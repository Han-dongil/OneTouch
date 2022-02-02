package com.onetouch.web.adm.mtr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.adm.mtr.dao.MtrMapper;
import com.onetouch.web.adm.mtr.dao.MtrVO;
import com.onetouch.web.adm.mtr.service.MtrService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Service
public class MtrServiceImpl implements MtrService{

	@Autowired	MtrMapper mapper;
	@Override
	public List<MtrVO> selectAdmMtrAll() {
		return mapper.selectAdmMtrAll();
	}

	@Override
	public List<MtrVO> selectAdmMtrDtl(MtrVO mtrvo) {
		return mapper.selectAdmMtrDtl(mtrvo);
	}

	@Override
	public List<MtrVO> selectUseAdmMtr() {
		return mapper.selectUseAdmMtr();
	}

	@Override
	public void updateMtr(MtrVO mtrvo) {
		mapper.updateMtr(mtrvo);
	}

	@Override
	public void insertMtr(MtrVO mtrvo) {
		mapper.insertMtr(mtrvo);
	}

	@Override
	public void deleteMtr(MtrVO mtrvo) {
		mapper.deleteMtr(mtrvo);
	}
	@Override
	public void modify(ModifyVO<MtrVO> mvo) {
		if(mvo.getDeletedRows() != null) {
			for(MtrVO mtrvo : mvo.getDeletedRows()) {
				mapper.deleteMtr(mtrvo);
			};
		}
	}

	@Override
	public List<MtrVO> selectMtrSize() {
		return mapper.selectMtrSize();
	}

	@Override
	public List<MtrVO> selectMtrSect() {
		return mapper.selectMtrSect();
	}





}
