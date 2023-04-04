package org.green.seenema.admin.reply.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.seenema.mapper.AdminReplyMapper;
import org.green.seenema.vo.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminReplyController {

	@Autowired
	AdminReplyMapper arMapper;

	// 리플페이지
	@GetMapping("/adminReplyView")
	public void adminReplyView() {
	}

	// 리플출력
	@GetMapping("/replyListView")
	public @ResponseBody List<ReplyVO> replyListView() {
		return arMapper.replyListView();
	}

	// 한줄평 id검색
	@GetMapping("/replyIdListView")
	public @ResponseBody List<ReplyVO> replyLIdSearch(@Param("searchId") String id) {
		return arMapper.replyLIdSearch(id);
	}

	// 한줄평 영화코드검색
	@GetMapping("/replyMovieCodeListView")
	public @ResponseBody List<ReplyVO> replyMovieCodeSearch(@Param("searchMovieCode") String movieCode) {
		return arMapper.replyMovieCodeSearch(movieCode);
	}

	// 한줄평 별점검색
	@GetMapping("/replyRateListView")
	public @ResponseBody List<ReplyVO> replyRateSearch(@Param("searchRate") int rate) {
		return arMapper.replyRateSearch(rate);
	}

	// 한줄평 별점검색
	@GetMapping("/replyDel")
	public void replyDel(int replyCode) {
		arMapper.replyDel(replyCode);
	}

	// 한줄평 갯수 구하기
	@GetMapping("/replyCount")
	public @ResponseBody int replyCount() {
		return arMapper.replyCount();
	}

	// 한줄평 갯수 구하기
	@GetMapping("/replyIdCount")
	public @ResponseBody int replyIdCount(@Param("searchId") String id) {
		return arMapper.replyIdCount(id);
	}

	// 한줄평 갯수 구하기
	@GetMapping("/replymovieCodeCount")
	public @ResponseBody int replymovieCodeCount(@Param("searchMovieCode") String movieCode) {
		return arMapper.replymovieCodeCount(movieCode);
	}

	// 한줄평 갯수 구하기
	@GetMapping("/replyRateCount")
	public @ResponseBody int replyRateCount(@Param("searchRate") int rate) {
		return arMapper.replyRateCount(rate);
	}

	// 메인페이지에
	@GetMapping("/replyMainView")
	public @ResponseBody List<ReplyVO> replyMainView() {
		return arMapper.replyMainView();
	}

}
