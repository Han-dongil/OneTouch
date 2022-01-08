package com.onetouch.web.fct.info.dao;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class ModifyVO {



	List<Object> createdRows;
	List<Map> updatedRows;
	List<Map> deletedRows;
}
