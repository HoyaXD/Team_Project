package org.green.seenema.controller;

import org.green.seenema.mapper.AdminMainPageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/admin")
@Controller
public class AdminMainPageController {
	
	@Autowired
	AdminMainPageMapper mc;
	
	
	@GetMapping("/todayMainMovieCount")
	public @ResponseBody int todayMovieCount() {
		return mc.todayMainMovieCount();
	}
	
	@GetMapping("/getTodayEndMovieCount")
	public @ResponseBody int getTodayEndMovieCount() {
		return mc.getTodayEndMovieCount();
	}

	@GetMapping("/getTodayReservationCount")
	public @ResponseBody int getTodayReservationCount() {
		return mc.getTodayReservationCount();
	}
	
	@GetMapping("/getTodayReservationCancelCount")
	public @ResponseBody int getTodayReservationCancelCount() {
		return mc.getTodayReservationCancelCount();
	}
	
	@GetMapping("/getTodayQnaWaitingCount")
	public @ResponseBody int getTodayQnaWaitingCount() {
		return mc.getTodayQnaWaitingCount();
	}
	
	@GetMapping("/getTodayQnaCompleteCount")
	public @ResponseBody int getTodayQnaCompleteCount() {
		return mc.getTodayQnaCompleteCount();
	}
	
	@GetMapping("/getTodayProductSalesCount")
	public @ResponseBody int getTodayProductSalesCount() {
		return mc.getTodayProductSalesCount();
	}
	
	@GetMapping("/getTodayProductCancelCount")
	public @ResponseBody int getTodayProductCancelCount() {
		return mc.getTodayProductCancelCount();
	}	

}
