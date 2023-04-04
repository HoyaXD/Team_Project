package org.green.seenema.admin.sales.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.mapper.SalesMapper;
import org.green.seenema.vo.MovieSalesVO;
import org.green.seenema.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminSalesController {
	
	@Autowired
	MovieCRUDMapper mvsMapper;
	 
	@Autowired
	SalesMapper mapper;

	@GetMapping("/movieSalesPage")
	public void movieSalesPage() {
		
	}
	@GetMapping("/topFive")
	public @ResponseBody ArrayList<ReservationVO> topFive(String year, String month) {
		//예매율 top5
		String yearMonth = "%" + year + "-" + month + "%";
		
		ArrayList<ReservationVO> mList = mapper.getMovieTopfive(yearMonth);
		
		return mList;
	}
	
	@GetMapping("/allMovies")
	public @ResponseBody ArrayList<ReservationVO> allMovies(String year, String month){
		//한달 전체영화예매율
		String yearMonth = "%" + year + "-" + month + "%";
		ArrayList<ReservationVO> list = mapper.getMovieSales(yearMonth);
		
		return list;
	}
	
	@GetMapping("/getAllMovieCnt")
	public @ResponseBody int getAllMovieCnt(String year, String month) {
		//한달 영화 전체 관람객수
		String yearMonth = "%" + year + "-" + month + "%";
		int cnt = mapper.getAllMovieCnt(yearMonth);
		
		return cnt;
	}
	
	@GetMapping("/getTheaterTopfive")
	public @ResponseBody ArrayList<ReservationVO> getTheaterTopfive(String year, String month) {
		//영화관 별 관객수 top5
		String yearMonth = "%" + year + "-" + month + "%";
		ArrayList<ReservationVO> list = mapper.getTheaterTopfive(yearMonth);
		
		return list;
	}
	
	@GetMapping("/genderReservedCnt")
	public @ResponseBody ArrayList<ReservationVO> genderReservedCnt(String gender, String year, String month){
		//성별에 따른 예매 카운트
		String yearMonth = "%" + year + "-" + month + "%";
		ArrayList<ReservationVO> list = mapper.genderReservedCnt(gender, yearMonth);
		
		return list;
	}
	
	@GetMapping("/allGenre")
	public @ResponseBody ArrayList<MovieSalesVO> allGenre(){
		//예매된 장르 조회하기
		ArrayList<MovieSalesVO> list = mapper.allGenre();
		
		return list;
	}
	@GetMapping("/test")
	public void test() {
		
	}
}
