package org.green.seenema.controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.green.seenema.mapper.MgmtMapper;
import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.MemberVO;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.ProductVO;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminController {
   
   @Autowired
   MgmtMapper mgmt;
   
   @GetMapping("/MemberMGMT")
   public void memberMGMTViewGo() {
      
   }
   
   //영화관 회원 목록 출력
   @GetMapping("/MemberListView")
   public @ResponseBody List<MemberVO> memberView() {
      return mgmt.memberView();
   }
   
   //영화관 회원 목록 삭제
   @GetMapping("/MemberDel")
   public void memberDel(String id) {
      mgmt.memberDel(id);
   }
   
   //영화관 회원 수정창
   @GetMapping("/memEditPop")
   public List<MemberVO> memEditViewGo(String id,Model model){
      log.info("수정창으로 ㄱㄱ");
      //id를 받음
      log.info("id를 받은 값 : " + id);
      log.info("투스트링 : "+mgmt.oneMemList(id).toString());
      List<MemberVO> list = mgmt.oneMemList(id);
      model.addAttribute("list", list);
      return list;
   }
   //수정창
   @ResponseBody
   @PostMapping("/editInfo")
   public int memberEdit(MemberVO m) {
      log.info("수정버튼누름 : " + m.toString());
      mgmt.editInfo(m);
   return 0;
   }
   
   
	@Autowired
	MovieCRUDMapper mapper;
	@Autowired
	TheaterCRUDMapper tmapper; 
	
	//--------------------영화 등록/수정/삭제
	@GetMapping("/movieReg")
	public void regMovie(Model model) {
		//영화 등록 페이지
		ArrayList<TheaterVO> theaterlist = tmapper.getList2();
		model.addAttribute("theater", theaterlist);
	}
	
	@PostMapping("/movieUplode.do")
	public String uploadMovieDo(MovieVO movieVO, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//영화등록실행
		String fileName = file.getOriginalFilename();
		
		movieVO.setPostFileName(fileName);
		
		ServletContext ctx = request.getServletContext();
		String uploadPath = "resources/images";
		String path = ctx.getRealPath(uploadPath);
		
		File saveFile = new File(path, file.getOriginalFilename());
		
		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int result = mapper.insertMovie(movieVO);
		
		rs.addAttribute("insert_result", result);
		
		return "redirect:movieList";
	}
	
	@GetMapping("/movieList")
	public void movieList(Model model) {
		//등록된 영화 목록 페이지
		ArrayList<MovieVO> mList = mapper.getList(0);
		
		model.addAttribute("mList", mList);
	}
	@GetMapping("/movieListByCode")
	public @ResponseBody MovieVO movieListByCode(int movieCode){
		//코드로 영화 조회하기
		MovieVO movie = mapper.selectOne(movieCode);
		//System.out.println(movieCode);
		return movie;
	}
	@GetMapping("/movieCnt")
	public @ResponseBody int movieCnt() {
		//영화개수
		int cnt = mapper.movieCnt();
		return cnt;
	}
	@GetMapping("/goMPage")
	public @ResponseBody ArrayList<MovieVO> goPage(int pageNum){
		//영화페이지이동
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<MovieVO> list = mapper.getList(_pageNum);
		
		return list;
	}
	@GetMapping("/movieUpdate")
	public void movieUpdate(int movieCode, Model model) {
		//영화 정보 수정 페이지
		
		MovieVO movie = mapper.selectOne(movieCode);
		model.addAttribute("movie", movie);
		
		ArrayList<TheaterVO> theaterlist = tmapper.getList2();
		model.addAttribute("theater", theaterlist);
	}

	@PostMapping("/movieUpdate.do")
	public String movieUpdateDo(MovieVO movieVO, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//영화정보 수정 실행
		
		String fileName = file.getOriginalFilename();
		
		int update_result = -1;
		
		if(fileName.equals("")) {
			
			update_result = mapper.update(movieVO);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:movieList";
			
		}else {
			
			movieVO.setPostFileName(fileName);
			ServletContext ctx = request.getServletContext();
			String uploadPath = "resources/images";
			String path = ctx.getRealPath(uploadPath);
			
			File saveFile = new File(path, file.getOriginalFilename());
			
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			update_result = mapper.update(movieVO);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:movieList";
		}
	}
	@GetMapping("/movieDelete.do")
	public String moviedeleteDo(int movieCode, RedirectAttributes rs) {
		//영화 삭제 실행
		int del_result = mapper.delete(movieCode);
		rs.addAttribute("del_result", del_result);
		
		return "redirect:movieList";
	}
	
	@GetMapping("/movies_delete.do")
	public @ResponseBody int movies_deleteDo(int[] movieCodes) {
		//영화 선택 삭제 실행
		int del_result = 0;
		for(int i = 0; i < movieCodes.length; i++) {
			del_result = mapper.delete(movieCodes[i]);
		}
		return del_result;
	}
	
	//--------------------영화관 등록/수정/삭제/조회

	
	@GetMapping("/theaterReg")
	public void theaterReg() {
		//영화관 등록페이지
	}
	
	@PostMapping("/theaterReg.do")
	public String theaterRegDo(TheaterVO theaterVO, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//영화관 등록실행
		
		String fileName = file.getOriginalFilename();
		theaterVO.setTheaterImage(fileName);
		
		ServletContext ctx = request.getServletContext();
		String uploadPath = "resources/images";
		String path = ctx.getRealPath(uploadPath);
		File saveFile = new File(path, file.getOriginalFilename());
		
		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		int insert_result = tmapper.insertTheater(theaterVO);
		rs.addAttribute("insert_result", insert_result);
		
		return "redirect:theaterList";
	}
	
	@GetMapping("/theaterList")
	public void theaterList(Model model) {
		//영화관 조회페이지
		ArrayList<TheaterVO> tList = tmapper.getList(0);
		model.addAttribute("tList", tList);	
	}
	
	@GetMapping("/theaterCnt")
	public @ResponseBody int theaterCnt() {
		//영화관 cnt
		int cnt = tmapper.theaterCnt();
		
		return cnt;
	}
	
	@GetMapping("/goTPage")
	public @ResponseBody ArrayList<TheaterVO> goTPage(int pageNum){
		//영화관 페이지
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<TheaterVO> list = tmapper.getList(_pageNum);
		
		return list;
		
	}
	
	
	@GetMapping("/theaterUpdate")
	public void theaterUpdate(int theaterCode, Model model) {
		//영화관 정보 수정 페이지
		
		TheaterVO theater = tmapper.selectOne(theaterCode);
		model.addAttribute("theater", theater);
		
	}
	@GetMapping("/theaterInfo")
	public @ResponseBody TheaterVO theaterInfo(int theaterCode){
		//영화관 코드로 영화관조회
		TheaterVO theater = tmapper.selectOne(theaterCode);
		
		return theater;
	}
	@PostMapping("/theaterUpdate.do")
	public String theaterUpdateDo(TheaterVO theaterVO, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//영화관 정보 수정 실행
		String fileName = file.getOriginalFilename();
		int update_result = -1;
		
		if(fileName.equals("")) {
			update_result = tmapper.update(theaterVO);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:theaterList";
		}else {
			theaterVO.setTheaterImage(fileName);
			
			ServletContext ctx = request.getServletContext();
			String uploadPath = "resources/images";
			String path = ctx.getRealPath(uploadPath);
			
			File saveFile = new File(path, file.getOriginalFilename());
			
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			update_result = tmapper.update(theaterVO);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:theaterList";
		}
	}
	@GetMapping("/theaterDelete.do")
	public String theaterDeleteDo(int theaterCode, RedirectAttributes rs) {
		//영화관 삭제 실행
		int del_result = tmapper.delete(theaterCode);
		rs.addAttribute("del_result", del_result);
		
		return "redirect:theaterList";
	}
	
	
}
