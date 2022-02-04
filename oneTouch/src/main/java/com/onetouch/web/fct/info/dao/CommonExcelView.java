package com.onetouch.web.fct.info.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

@Component
public class CommonExcelView  extends  AbstractXlsxView {

	private static final Logger LOGGER  = LoggerFactory.getLogger(CommonExcelView.class);
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {


		Sheet sheet = workbook.createSheet("Datatypes in Java");
		Row row;
		Cell cell;
        int rowNum = 0;
        
        // 테이블 헤더용 스타일

        CellStyle headStyle = workbook.createCellStyle();
        
        //폰트지정
        Font font = workbook.createFont();
        font.setFontName("맑은고딕");
        
        //셀 만들기전에 스타일 지정
        headStyle .setFillForegroundColor(HSSFColor.GREEN.index);
        headStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);	//색 채우는 패턴 단색 넣음
        font.setBold(true);	//두께줌
        font.setColor(HSSFColor.WHITE.index); //글색
        headStyle.setFont(font);
        
        
        

        String file_name =(String) model.get("filename") + System.currentTimeMillis() + ".xlsx";
		response.setHeader("Content-Disposition", "attachment; filename=\""+ file_name+"\"");
		//header 출력
		String[] headers  = (String[])model.get("headers");
		if(headers != null) {
			row = sheet.createRow(rowNum++);
			int colNum = 0;
			for (String header : headers) {
				row.createCell(colNum++).setCellValue(header);
			}
		}
		
		//body 출력
        List<Map<String, Object>> list  = (List<Map<String, Object>>)model.get("datas");
        System.out.println(list);
        if(headers != null) {
        	for (Map<String, Object> map : list) {
        		row = sheet.createRow(rowNum++);
        		 int colNum = 0;
        		 for (String header : headers) {
        			cell = row.createCell(colNum++);		//해당 로우에 cell 만들고 
 					Object field = map.get(header);
 					if(field == null) {
 						field = "";
 						System.out.println(header);
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
