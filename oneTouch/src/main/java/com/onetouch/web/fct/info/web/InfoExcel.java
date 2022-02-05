package com.onetouch.web.fct.info.web;

import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;

@Controller
public class InfoExcel {

	@Autowired
	InfoMapper infoMapper;
	
	@RequestMapping("/fct/ExcelCreate.do")
	public void ExcelCreate(HttpServletResponse response, InfoVO infoVO)throws IOException{
		//엑셀 wookbook 생성 / 엑셀 스타일 및 글꼴 설정
		response.setCharacterEncoding("utf-8");
		
		//PrintWriter out = response.getWriter();
		Workbook wb = new XSSFWorkbook();
		CellStyle cs = wb.createCellStyle();
		
		//가운데 정렬
		cs.setAlignment(HorizontalAlignment.CENTER);
		
		//가느선 테두리
		cs.setBorderTop(BorderStyle.THIN);
		cs.setBorderBottom(BorderStyle.THIN);
		cs.setBorderLeft(BorderStyle.THIN);
		cs.setBorderRight(BorderStyle.THIN);
		
		cs.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		
		XSSFFont f2 = (XSSFFont) wb.createFont();
		f2.setFontName("맑은 고딕");
		f2.setItalic(true);
		cs.setFont(f2);
		
	
		
		//시트추가
		wb.createSheet("first sheet");
		
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
	
		//엑셀 헤더 출력
		Row row;
		Cell cell = null;
		Sheet sheet = wb.getSheetAt(0);	//시트번호
		int rowNum =0;	//행번호
		
		if(headers != null) {
			row = sheet.createRow(rowNum++);
			int colNum = 0; //행번호
			sheet.autoSizeColumn(rowNum);
			for(String header : headers) {
				cell = row.createCell(colNum++);
				cell.setCellValue(headerMap.get(header));
				 
				cell.setCellStyle(cs);
				
				
			}
		}//헤더 출력 end
		
		//body 부분 시작 
		
		List<Map<String, Object>> list = infoMapper.findFctList();	// db에서 리스트 받아옴
		
		for(Map<String, Object> map: list) {	//리스트 결과 행수만큼 반복
			row = sheet.createRow(rowNum++);
			int colNum =0;
			int colCnt =0;
			for(String header : headers) {	//영어로된 헤더 배열크기만큼 반복
				cell = row.createCell(colNum++);	//데이터 넣을 cell 생성 / 다음 데이터 넣기 위해 반복할 때마다 다음 컬럼 번호 ++
				
				Object field = map.get(header);	//리스트 결과에서 key값을 영어로 된 헤더명인 value 값 field에 담기 
				sheet.autoSizeColumn(colCnt++);
				if(field == null) {		//field가 빈 값일 경우 공백
					field="";
				}//field 타입에 맞춰 cell에 입력
				if(field instanceof String) {
					cell.setCellValue((String) field);
				}else if (field instanceof BigDecimal) {
					cell.setCellValue(((BigDecimal) field).doubleValue());
				}else if(field instanceof Date) {
					Date nowdate = (Date) field;
					SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
					cell.setCellValue(simple.format(nowdate));
				}else {
					cell.setCellValue(field.toString());
				}
			}
		}
		
		
		
		//서버에 엑셀 파일 저장( 경로에 Temp 폴더 있는지 확인
		String filename = "c:/Temp/excel_" + System.currentTimeMillis() + ".xlsx";
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(filename);
			try {
				wb.write(fos);
				fos.close();
			}catch(IOException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//
		
	}
	
}
