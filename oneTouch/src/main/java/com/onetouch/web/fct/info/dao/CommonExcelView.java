package com.onetouch.web.fct.info.dao;

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

        CellStyle cs = workbook.createCellStyle();
        
     
        
        //셀 만들기전에 스타일 지정
		cs.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      

		XSSFFont f2 = (XSSFFont) workbook.createFont();
		f2.setFontName("맑은 고딕");
		f2.setItalic(true);
		cs.setFont(f2);
        
		//헤더명 영어로 배열에 담기(수정필요)
				String[] headers  = {"FCT_CD","FCT_NM","LINE_NO","PRC_CD","FCT_STD","FCT_MODEL","COMP_CD","IN_DATE","PURCH_COST","CHK_PROD","CHK_PROD_UNIT","FCT_PHS","FCT_IMG","UPLOAD_PATH"};
				Map<String, String> headerMap = new HashMap<>();
				headerMap.put("FCT_CD", "설비코드");
				headerMap.put("FCT_NM", "설비이름");
				headerMap.put("LINE_NO", "라인번호");
				headerMap.put("PRC_CD", "공정코드");
				headerMap.put("FCT_STD", "설비규격");
				headerMap.put("FCT_MODEL", "설비모델코드");
				headerMap.put("COMP_CD", "설비 판매회사");
				headerMap.put("IN_DATE", "입고일");
				headerMap.put("PURCH_COST", "설비금액");
				headerMap.put("CHK_PROD", "정기점검");
				headerMap.put("CHK_PROD_UNIT", "정기점검단위");
				headerMap.put("FCT_PHS", "설비상태");
				headerMap.put("FCT_IMG", "설비이미지");
				headerMap.put("UPLOAD_PATH", "이미지경로");

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
        System.out.println(list);
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