package com.onetouch.web.zzz.dao;

import java.util.List;

import lombok.Data;

@Data
public class ModifyVO<T> {
	/*
	 * private List<Map<String,Object>> createdRows; private
	 * List<Map<String,Object>> updatedRows; private List<Map<String,Object>>
	 * deletedRows;
	 */
	private List<T> createdRows;
	private List<T> updatedRows;
	private List<T> deletedRows;
}
