package com.onetouch.web.fct.info.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.onetouch.web.adm.bas.dao.BasDtlVO;
import com.onetouch.web.adm.bas.dao.BasMapper;
import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.dao.LineVO;
import com.onetouch.web.fct.info.service.InfoService;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;
@RequestMapping("/fct")
@Log
@Controller
public class InfoController {
	@Autowired InfoService infoservice;
	@Autowired InfoMapper infomapper;
	@Autowired BasMapper basservice;
	
	
	
	//엑셀출력
	@RequestMapping("/fctExcelView.do")
	public ModelAndView excelView() throws IOException{
		List<Map<String, Object>> list = infomapper.findFctList();
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		/*
		 * for(Map<String, Object> data : list) { System.out.println(data); }
		 */
		
		
		 //String[] header = ("설비회사","설비코드","성비 상태");
		 //map.put("headers", header);
		 
		 
		
		map.put("filename", "excel_dept");
		map.put("datas", list);
		return new ModelAndView("excelView", map);
	}
	
	//공정 시작 설비상태 가동으로 변경
	@ResponseBody
	@PostMapping("/updateStringFctPhs")
	public List<InfoVO> changeStartFctPhs(@RequestBody InfoVO infoVO) {
		infoservice.updateStartFctPhs();
		 return infoservice.selectFctInfoAll(infoVO); 
	}
	
	
	//설비이름 조회
	@ResponseBody
	@PostMapping("/selectFctNm")
	public InfoVO selectFctNm(@RequestBody InfoVO infoVO) {
		System.out.println("설비이름 조회 ");
		System.out.println(infoVO.getFctCd());
		return infoservice.selectFctNm(infoVO);
		
		
	}
	
	//현재 날자 조회
	@ResponseBody
	@GetMapping("/selectTodayDate")
	public InfoVO selectTodaDate(){
		System.out.println("날짜가져오는 메서드 ");
		System.out.println(infoservice.todayDate());
		return infoservice.todayDate();
	}
	//라인 수정
	@ResponseBody
	@PostMapping("/LineUpdate")
	public List<LineVO> lineUpdate(@RequestBody LineVO lineVO){
		System.out.println("라인 업데이투");
		infoservice.LineUpdate(lineVO);
		return infoservice.LineSelect(lineVO);
	}
	
	//라인 삭제
	@ResponseBody
	@PostMapping("/LineDelete")
	public List<LineVO> lineDelete(@RequestBody LineVO lineVO){
		System.out.println("라인 삭제 컨트롤러 연결완료");
		infoservice.LineDelete(lineVO);
		return infoservice.LineSelect(lineVO);
	}
	
	//라인 조회
	@ResponseBody
	@PostMapping("/LineSelect")
	public List<LineVO> lineSelect(@RequestBody LineVO lineVO){
		System.out.println("라인 조회 컨트롤러 연결완료");
		return infoservice.LineSelect(lineVO);
	}
	//라인 등록
	@ResponseBody
	@PostMapping("/LineInsert")
	public List<LineVO> lineInsert(@RequestBody LineVO lineVO){
		System.out.println("라인 등록 컨트롤러 연결");
		System.out.println(lineVO);
		infoservice.LineInsert(lineVO);
		return infoservice.LineSelect(lineVO);
	}
	
	
//수정
  @ResponseBody
  @PostMapping(value ="/Updateinfo" ,produces = MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE)
  public List<InfoVO> InfoUpdate(MultipartFile uploadFile, InfoVO infoVO) {

	  String uploadFolder = "C:\\upload";			
	  String uploadFolderPath = getFolder();
	  
	  if(uploadFile != null && uploadFile.getSize() >0) {
		  
		  File uploadPath = new File(uploadFolder, uploadFolderPath);
			
			MultipartFile multipartFile = uploadFile;
			
			
			log.info("---------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("!!!!!!!!!!!!!!!!!!");
			log.info(uploadFileName);
			
			UUID uuid =  UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);		//파일 경로에 만들어주는 메서드
				infoVO.setFctImg(uploadFileName);
				infoVO.setUuid(uuid.toString());
				infoVO.setUploadPath(uploadFolderPath);
				
				//파일이 이미지 타입인지 확인
				if(checkImageType(saveFile)) {
					
					infoVO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					thumbnail.close();
					
				}
			
				
				
			} catch (Exception e) {
				//log.error(e.getMessage());
				e.printStackTrace();
			}//end catch
		  }
	  
	  System.out.println("업데이트할 때 infoVO 확인하기");
	  System.out.println(infoVO);
	  
	  infoservice.InfoUpdate(infoVO);
	  return infoservice.selectFctInfoAll(infoVO);
  }
  
  	//검색조건 설비코드 조회 
  @ResponseBody
  @GetMapping("/selelctCheckFct")
  public List<InfoVO> showCheckfCT(){
	  return infomapper.selectCheckFct();
  }
	
	//공정코드 조회 
	@ResponseBody
	@GetMapping("/selectPrc")
	public List<BasDtlVO> showPrc() {
		BasDtlVO basdtlVO = new BasDtlVO();
		basdtlVO.setBasCd("FCT_DIV");
		List<BasDtlVO> list = basservice.selectBasDtl(basdtlVO);
		System.out.println(list);
		return list;
	}
	
	//목록조회 페이지이동
	@RequestMapping("/fctInfoIns")
	public String moveList( ) {
		
		
		
		return "tiles/fct/infoIns";
	}
	
	//목록조회 페이지이동
	@RequestMapping("/fctInfoSel")
	public String showList( ) {
		
		
		
		return "tiles/fct/infoSel";
	}
	
	  //목록조회 처리
	  @ResponseBody
	  @PostMapping("/list1") //s는 공정코드 키 값으로 들어감 
	  public List<InfoVO> list(@RequestBody InfoVO infoVO) {
		  System.out.println("검색조건 넘어온지 확인하기 ");
		  System.out.println(infoVO.getCheckPrcCd());
		  List<InfoVO> list = new ArrayList<>();
		  list = infoservice.selectFctInfoAll(infoVO);
		  System.out.println(list);
	  return list; 
	  }
	  
	
	  @ResponseBody      
	  @PostMapping("/deleteInfo")
	  public List<InfoVO> delete(@RequestBody InfoVO infoVO) {
		 
		  infoservice.deleteFctInfo(infoVO);
		  return infoservice.selectFctInfoAll(infoVO);
	  }
	  
	  // 설비 등록 아작스 -------------------------------------------------------------------------------------------//
	  @ResponseBody
	  @PostMapping(value = "/infoInsert", produces = MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE)
	  public ResponseEntity<InfoVO> InfoInsert(MultipartFile uploadFile, InfoVO infoVO) {
		  System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		  log.info("update ahax post.......");
		  
		  
		  String uploadFolder = "C:\\upload";			
		  String uploadFolderPath = getFolder();
		  
			/* uploadFile 매개변수에 값이 있는지 확인 */
		  if(uploadFile != null && uploadFile.getSize() >0) {
			  
			//make folder-------------------------------
			File uploadPath = new File(uploadFolder, uploadFolderPath);
			log.info("upload path: " + uploadPath );
			System.out.println(uploadPath);
			
			// 경로에 파일이 없으면 mkdirs로 만들어주는 메서드 
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
			
			MultipartFile multipartFile = uploadFile;
			
			
			log.info("---------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("!!!!!!!!!!!!!!!!!!");
			log.info(uploadFileName);
			
			UUID uuid =  UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);		//파일 경로에 만들어주는 메서드

				infoVO.setFctImg(uploadFileName);
				infoVO.setUuid(uuid.toString());
				infoVO.setUploadPath(uploadFolderPath);
				
				//파일이 이미지 타입인지 확인
				if(checkImageType(saveFile)) {
					
					infoVO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					thumbnail.close();
					
				}
			
				
				
			} catch (Exception e) {
				//log.error(e.getMessage());
				e.printStackTrace();
			}//end catch
		  }
		  
		 System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(infoVO.getFctImg());
		  infoservice.insertFctInfo(infoVO);
		  return new ResponseEntity<>(infoVO, HttpStatus.OK);
				  //infoservice.selectFctInfoAll(infoVO);
	  }
	  
	//특정한 파일이 이미지 타입인지를 검사하는 메서드
		private boolean checkImageType(File file) {
			try {
				String contentType = Files.probeContentType(file.toPath());
				
				return contentType.startsWith("image");
			}catch(IOException e) {
				e.printStackTrace();
			}
			return false;
		}
		
		//날짜별로 파일경로 만드는 함수
		private String getFolder() {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date date = new Date();
			String str= sdf.format(date);
			return str.replace("-", File.separator);
		}
		
		//섬네일 데이터 전송하기
		@GetMapping("/display")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(String fileName)  {
			log.info("fileName:" + fileName);
			File file = new File("c:\\upload\\" + fileName);
			
			log.info("file" + file);
			
			ResponseEntity<byte[]> result = null;
			
			
			try {
				HttpHeaders header = new HttpHeaders();

				header.add("Content-Type", Files.probeContentType(file.toPath()));
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return result;
		}
		
}
