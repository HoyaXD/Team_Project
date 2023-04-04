package org.green.seenema.controller;

import java.util.List;

import org.green.seenema.mapper.UserNoticeMapper;
import org.green.seenema.vo.NoticeVO;
import org.green.seenema.vo.QnaVO;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@Slf4j
public class UserNoticeController {
	
	@Autowired
	private UserNoticeMapper mapper;
	
	// 공지목록
	@GetMapping("/getNoticeList.do")
	public List<NoticeVO> getNoticeList(int pageNum) {
		int count = (pageNum - 1) * 20;
		List<NoticeVO> list = mapper.getNoticeList(count);
		return list;
	}
	
	// 공지 갯수
	@GetMapping("/getNoticeCount.do")
	public int getNoticeCount() {
		int result = mapper.getNoticeCount();
		return result;
	}
	
	// 이전글
	@GetMapping("/getPrevContent")
	public NoticeVO getPrevContent(int noticeCode){
		NoticeVO notice = mapper.getPrevContent(noticeCode);
		return notice;
	}
	
	// 다음글
	@GetMapping("/getNextContent")
	public NoticeVO getNextContent(int noticeCode){
		NoticeVO notice = mapper.getNextContent(noticeCode);
		return notice;
	}
	
	// Q&A 목록 가져오기
	@GetMapping("/getQnaList.do")
	public List<QnaVO> getQnaList(int pageNum){
		int count = (pageNum - 1) * 20;
		List<QnaVO> list = mapper.getQnaList(count);
		//log.info(list.toString());
		return list;
	}
	
	// Q&A 삭제
	@GetMapping("/deleteQna.do")
	public int deleteQna(int qCode) {
		int result = mapper.deleteQna(qCode);
		return result;
	}
	
	// 공지 갯수
	@GetMapping("/getQnaCount.do")
	public int getQnaCount() {
		int result = mapper.getQnaCount();
		return result;
	}
	
	// 키워드 조회(공지)
	@GetMapping("/getSearchNoticeList.do")
	public List<NoticeVO> getSearchNoticeList(String select, String keyword, int pageNum){
		int count = (pageNum - 1) * 20;
		List<NoticeVO> list = null;
		if(select.equals("title")) {
			list = mapper.searchByTitleList(keyword, count);
		}else {
			list = mapper.searchByContentsList(keyword, count);
		}
		return list;
	}
	
	// Q&A 등록
	@PostMapping("/regQna.do")
	public int regQna(String title, String contents, String id) {
		int result = mapper.regQna(title, contents, id);
		return result;
	}
	
	// 상영관 정보
	@GetMapping("/getTheaterInfo.do")
	public TheaterVO getTheaterInfo(String theaterName) {
		TheaterVO theater = mapper.getTheaterInfo(theaterName);
		return theater;
	}
	
	// 조회 페이징
	@GetMapping("/getSearchCount.do")
	public int getSearchCount(String select, String keyword) {
		int result = 0;
		if(select.equals("title")) {
			result = mapper.getSearchByTitleCount(keyword);
		}else {
			result = mapper.getSearchByContentsCount(keyword);
		}
		return result;
	}
}
