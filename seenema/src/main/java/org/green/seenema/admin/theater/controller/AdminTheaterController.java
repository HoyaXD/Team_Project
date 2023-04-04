package org.green.seenema.admin.theater.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminTheaterController {
	
	@Autowired
	TheaterCRUDMapper tmapper;
	
	@GetMapping("/theaterShcByName.do")
	public @ResponseBody ArrayList<TheaterVO> theaterSerchByNameDo(String name, int pageNum) {
		//이름으로 영화관찾기
		String _name = "%" + name + "%";
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<TheaterVO> list = tmapper.getListByName(_name, _pageNum);
		
		return list;
	}
	
	@GetMapping("/teaterNameCnt")
	public @ResponseBody int nameCnt(String name) {
		//이름으로 영화관 조회 cnt
		String _name = "%" + name + "%";
		int cnt = tmapper.theaterNameCnt(_name);
		
		return cnt;
	}
	
	@GetMapping("/theaterShcByPlace.do")
	public @ResponseBody ArrayList<TheaterVO> theaterShcByPlaceDo(String place, int pageNum){
		//지역으로 영화관찾기
		String _place = "%" + place + "%";
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<TheaterVO> list = tmapper.getListByPlace(_place, _pageNum);
		
		return list;
	}
	
	@GetMapping("/theaterPlaceCnt")
	public @ResponseBody int theaterPlaceCnt(String place) {
		//지역으로 영화관 조회 cnt
		String _place = "%" + place + "%";
		int cnt = tmapper.theaterPlaceCnt(_place);
		
		return cnt;
	}
	@GetMapping("/theaterShcByTel.do")
	public @ResponseBody ArrayList<TheaterVO> theaterShcByTelDo(String tel, int pageNum){
		//연락처로 영화관찾기
		String _tel = "%" + tel + "%";
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<TheaterVO> list = tmapper.getListByTel(_tel, _pageNum);
		
		return list;
	}
	
	@GetMapping("/theaterTelCnt")
	public @ResponseBody int theaterTelCnt(String tel) {
		//연락처로 영화관 조회 cnt
		String _tel = "%" + tel + "%";
		int cnt = tmapper.theaterTelCnt(_tel);
		
		return cnt;
	}
}
