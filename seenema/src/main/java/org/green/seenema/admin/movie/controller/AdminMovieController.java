package org.green.seenema.admin.movie.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.vo.MovieVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminMovieController {
	
	@Autowired
	MovieCRUDMapper mapper;
	
	@GetMapping("/serchMvByTitle.do")
	public @ResponseBody ArrayList<MovieVO> serchByNameDo(String movieTitle, int pageNum) {
		//영화제목으로 조회
		
		String _movieTitle = "%" + movieTitle + "%";
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<MovieVO> list = mapper.getListByTitle(_movieTitle, _pageNum);
		
		return list;
	}
	@GetMapping("/titleCnt")
	public @ResponseBody int titleCnt(String movieTitle) {
		//제목조회 cnt
		String _movieTitle = "%" + movieTitle + "%";
		int cnt = mapper.titleCnt(_movieTitle);
		
		return cnt;
	}
	@GetMapping("/serchMvByDate.do")
	public @ResponseBody ArrayList<MovieVO> serchByDateDo(String startDate, String endDate, int pageNum) {
		//영화 개봉일로 조회 
		
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<MovieVO> list = mapper.getListByreleaseDate(startDate, endDate, _pageNum);
		
		return list;
	}
	@GetMapping("/dateCnt")
	public @ResponseBody int dateCnt(String start, String end) {
		//개봉일 조회 cnt
		
		int cnt = mapper.dateCnt(start, end);
		
		return cnt;
	}
	@GetMapping("/serchMvByTitleDate.do")
	public @ResponseBody ArrayList<MovieVO> serchByNameDateDo(String movieTitle, String startDate, String endDate, int pageNum) {
		//영화 제목 + 개봉일로 조회
		int _pageNum = 10 * (pageNum - 1);
		String _movieTitle = "%" + movieTitle + "%";
		ArrayList<MovieVO> list = mapper.getListByTitleDate(_movieTitle, startDate, endDate, _pageNum);
		
		return list;
	}
	@GetMapping("/titleDateCnt")
	public @ResponseBody int titleDateCnt(String movieTitle, String startDate, String endDate) {
		//제목+개봉일 조회 cnt
		String _movieTitle = "%" + movieTitle + "%";
		int cnt = mapper.titleDateCnt(_movieTitle, startDate, endDate);
		
		return cnt;
	}
	@GetMapping("/delMoviesByCodes.do")
	public @ResponseBody int delMoviesByCodesDo(int[] movieCodes) {
		int del_result = 0;
		for(int i = 0; i < movieCodes.length; i++) {
			del_result = mapper.delete(movieCodes[i]);
		}
		//System.out.println(del_result);
		return del_result;
	}
}
