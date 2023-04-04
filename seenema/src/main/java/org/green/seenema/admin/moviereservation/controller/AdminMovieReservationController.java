package org.green.seenema.admin.moviereservation.controller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.green.seenema.mapper.AdminReservationViewMapper;
import org.green.seenema.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminMovieReservationController {

	@Autowired
	AdminReservationViewMapper arMapper;

	// 영화 예매페이지
		@GetMapping("/adminReservationView")
		public void adminReplyView() {
		}

		@GetMapping("/reservationMainView")
		public @ResponseBody List<Map<String, Object>> reservationMainView() {
			return arMapper.reservationMainView();
		}
		@GetMapping("/reservationAllView")
		public @ResponseBody List<ReservationVO> getNoticeList(@Param("searchKeyword") String searchKeyword, @Param("start") int start) {
			return arMapper.reservationAllView(searchKeyword,start);
		}
		@GetMapping("/reservationAllCount")
		public @ResponseBody int reservationAllCount() {
			return arMapper.reservationAllCount();
		}

		// 관리자 예매페이지 검색기능 실행시
		@GetMapping("/reservationIdCount")
		public @ResponseBody int reservationIdCount(@Param("searchKeyword") String searchKeyword) {
			return arMapper.reservationIdCount(searchKeyword);
		}

		// 관리자 예매페이지 검색기능 실행시
		@GetMapping("/reservationCodeCount")
		public @ResponseBody int reservationCodeCount(@Param("searchKeyword") String searchKeyword) {
			return arMapper.reservationCodeCount(searchKeyword);
		}// 관리자 예매페이지 검색기능 실행시

		@GetMapping("/reservationTitleCount")
		public @ResponseBody int reservationTitleCount(@Param("searchKeyword") String searchKeyword) {
			return arMapper.reservationTitleCount(searchKeyword);
		}// 관리자 예매페이지 검색기능 실행시

		@GetMapping("/reservationDateCount")
		public @ResponseBody int reservationDateCount(@Param("searchKeyword") String searchKeyword) {
			return arMapper.reservationDateCount(searchKeyword);
		}

		@GetMapping("/reservationId")
		public @ResponseBody List<ReservationVO> reservationId(@Param("searchKeyword") String searchKeyword,
				@Param("start") int start) {
			return arMapper.reservationId(searchKeyword, start);
		}

		@GetMapping("/reservationCode")
		public @ResponseBody List<ReservationVO> reservationCode(@Param("searmseprchKeyword") String searchKeyword, @Param("start") int start) {
			return arMapper.reservationCode(searchKeyword, start);
		}

		@GetMapping("/reservationTitle")
		public @ResponseBody List<ReservationVO> reservationTitle(@Param("searchKeyword") String searchKeyword, @Param("start") int start) {
			return arMapper.reservationTitle(searchKeyword, start);
		}

		@GetMapping("/reservationDate")
		public @ResponseBody List<ReservationVO> reservationDate(@Param("searchKeyword") String searchKeyword, @Param("start") int start) {
			return arMapper.reservationDate(searchKeyword, start);
		}
		
		@GetMapping("/reservationMainViewCount")
		public @ResponseBody List<Map<String, Object>> reservationMainViewCount() {
			return arMapper.reservationMainViewCount();
		}
}
