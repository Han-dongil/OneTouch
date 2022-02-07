package com.onetouch.web.mtr.in.dao;

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
public class MtrlnExcelView  extends  AbstractXlsxView {

	private static final Logger LOGGER  = LoggerFactory.getLogger(MtrlnExcelView.class);
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {


		Sheet sheet = workbook.createSheet("MtrlnExcel");
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
				String[] headers  = {"IN_NO","IN_DATE","MTR_CD","MTR_NM","UNIT_NM","COMP_NM","ORD_NO","FLT_AMT","IN_AMT","UNIT_COST","TOT_COST"};
				Map<String, String> headerMap = new HashMap<>();
				headerMap.put("IN_NO", "입고번호");
				headerMap.put("IN_DATE", "입고일자");
				headerMap.put("MTR_CD", "자재코드");
				headerMap.put("MTR_NM", "자재명");
				headerMap.put("UNIT_NM", "단위");
				headerMap.put("COMP_NM", "업체");
				headerMap.put("ORD_NO", "발주번호");
				headerMap.put("FLT_AMT", "불량량");
				headerMap.put("IN_AMT", "입고량");
				headerMap.put("UNIT_COST", "단가");
				headerMap.put("TOT_COST", "총금액");
				

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
        List<Map<String, Object>> list  =   (List<Map<String, Object>>) model.get("datas");
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