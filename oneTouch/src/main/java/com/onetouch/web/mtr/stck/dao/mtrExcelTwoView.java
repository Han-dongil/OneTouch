package com.onetouch.web.mtr.stck.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

@Component
public class mtrExcelTwoView  extends  AbstractXlsxView {

	private static final Logger LOGGER  = LoggerFactory.getLogger(mtrExcelTwoView.class);
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {


		Sheet sheet = workbook.createSheet("Datatypes in Java");
		Row row;
		Cell cell;
        int rowNum = 0;
        
        // 테이블 헤더용 스타일

        CellStyle cs = workbook.createCellStyle();
        
     
        
        //셀 만들기전에 스타일 지정
		cs.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      

		XSSFFont f2 = (XSSFFont) workbook.createFont();
		f2.setFontName("맑은 고딕");
		f2.setItalic(true);
		cs.setFont(f2);
        
		//헤더명 영어로 배열에 담기(수정필요)
				String[] headers  = {"MTR_CD","MTR_NM","UNIT_NM","MTR_SECT_NM","HLD_CNT","MTR_STCK_CNT","STCK_USE","SAFE_STCK","USE_YN"};
				Map<String, String> headerMap = new HashMap<>();
				headerMap.put("MTR_CD", "자재코드");
				headerMap.put("MTR_NM", "자재명");
				headerMap.put("UNIT_NM", "단위명");
				headerMap.put("MTR_SECT_NM", "자재구분");
				headerMap.put("HLD_CNT", "홀딩수량");
				headerMap.put("MTR_STCK_CNT", "현재고");
				headerMap.put("STCK_USE", "사용가능수량");
				headerMap.put("SAFE_STCK", "안전재고");
				headerMap.put("USE_YN", "사용구분");

        String file_name =(String) model.get("filename") + System.currentTimeMillis() + ".xlsx";
		response.setHeader("Content-Disposition", "attachment; filename=\""+ file_name+"\"");
		
		
		//header 출력
		//String[] headers  = (String[])model.get("headers");
		if(headers != null) {
			row = sheet.createRow(rowNum++);
			int colNum = 0;
			sheet.autoSizeColumn(rowNum);
			for (String header : headers) {
				cell = row.createCell(colNum++);
				cell.setCellValue(headerMap.get(header));
				cell.setCellStyle(cs);	
			}
		}
		
		//body 출력
        List<Map<String, Object>> list  = (List<Map<String, Object>>)model.get("datas");
        if(headers != null) {
        	for (Map<String, Object> map : list) {
        		row = sheet.createRow(rowNum++);
        		 int colNum = 0;
        		 int colCnt =0;
        		 for (String header : headers) {
        			cell = row.createCell(colNum++);		//해당 로우에 cell 만들고 
 					Object field = map.get(header);
 					sheet.autoSizeColumn(colCnt++);
 					if(field == null) {
 						field = "";
 					}
 					
 					if (field instanceof String) {
 						cell.setCellValue((String) field);		
 					} else if (field instanceof BigDecimal) {
 						cell.setCellValue(((BigDecimal) field).doubleValue());
 					} else if (field instanceof Date) {
 						cell.setCellValue((Date) field);
 					} else {
 						cell.setCellValue(field.toString());
 					}
 					
        		 }
        	}
        } else {
	        for (Map<String, Object> map : list) {
	            row = sheet.createRow(rowNum++);
	            int colNum = 0;
	            Iterator<String> iter = map.keySet().iterator();
				while(iter.hasNext()) {
					cell = row.createCell(colNum++);
					Object field = map.get(iter.next());
					if (field instanceof String) {
						cell.setCellValue((String) field);
					} else if (field instanceof BigDecimal) {
						cell.setCellValue(((BigDecimal) field).doubleValue());
					} else if (field instanceof Date) {
						cell.setCellValue((Date) field);
					} else {
						cell.setCellValue(field.toString());
					}
				} 
	        }
        }

		LOGGER.debug("### buildExcelDocument Map : {} end!!");	
	}

}