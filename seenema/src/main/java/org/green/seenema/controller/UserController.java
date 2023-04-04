package org.green.seenema.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.MemberMapper;
import org.green.seenema.mapper.ReplyMapper;
import org.green.seenema.mapper.UserNoticeMapper;
import org.green.seenema.user.main.mapper.UserMainMapper;
import org.green.seenema.vo.MemberVO;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.NoticeVO;
import org.green.seenema.vo.QnaVO;
import org.green.seenema.vo.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private UserMainMapper mainMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private UserNoticeMapper noticeMapper;
	
	// 메인 페이지
	@GetMapping("/main")
	public void main() {}
	
	// 나의 스탬프
	@GetMapping("/myStamp")
	public void myStamp(String id, Model model) {
		MemberVO member = memberMapper.selectMember(id);
		model.addAttribute("member", member);
	}
	
	// Q&A 등록 페이지
	@GetMapping("/regQnaView")
	public void regQnaView() {}
	
	// 공지사항 가기
	@GetMapping("/userNoticeBoard")
	public void userNoticeBoard() {}
	
	// QnA가기
	@GetMapping("/userQnaView")
	public void userQnaView() {}
	
	// 상영관 이동
	@GetMapping("/theaterView")
	public void theaterView() {}
	
	// 공지 상세보기
	@GetMapping("/noticeDetailView")
	public void noticeDetailView(int noticeCode, Model model) {
		NoticeVO notice = noticeMapper.getNoticeInfo(noticeCode);
		notice.setContents(notice.getContents().replaceAll("\n", "<br>"));
		model.addAttribute("notice", notice);
		plusView(noticeCode);	// 조회수 메서드
	}
	
	// 조회수 증가
	public void plusView(int noticeCode) {
		noticeMapper.plusView(noticeCode);	// 조회수 +1
	}
	
	// Q&A 상세보기
	@GetMapping("/qnaDetailView")
	public void qnaDetailView(int qcode, Model model) {
		QnaVO qna = noticeMapper.getQnaInfo(qcode);
		//qna.setAnswer(qna.getAnswer().replaceAll("\n", "<br>")); 에러 발생
		model.addAttribute("qna", qna);
	}
	
	// 이벤트 상세보기
	@GetMapping("/eventDetailView")
	public void eventDetailView() {
		
	}
	
	
	// 영화 상세보기
	@GetMapping("/movieDetailView")
	public void movieDetailView(String movieCode, Model model) {
		MovieVO movie = mainMapper.getMovieDetail(movieCode);
		movie.setPlot(movie.getPlot().replaceAll("\n", "<br>"));
		model.addAttribute("movie", movie);
	}
	
	// 페이징 리스트
	@GetMapping("/getReplyList.do")
	@ResponseBody
	public ArrayList<ReplyVO> getReplyList(int movieCode, int pageNum){
		int count = (pageNum - 1) * 10;
		ArrayList<ReplyVO> list = mapper.getReplyList(movieCode, count);
		return list;
	}
	
	// 댓글 총 갯수
	@GetMapping("/getReplyCount.do")
	@ResponseBody
	public int getReplyCount(int movieCode) {
		int result = mapper.getReplyCount(movieCode);
		return result;
	}
	
	// 댓글등록
	@PostMapping("/regReply.do")
	@ResponseBody
	public int regReplyDo(ReplyVO reply) {
		int result = mapper.regReply(reply);
		return result;
	}
	
	// 수정 댓글 정보
	@PostMapping("/getReplyInfo.do")
	@ResponseBody
	public ReplyVO getReplyInfo(int replyCode) {
		ReplyVO reply = mapper.getReplyInfo(replyCode);
		return reply;
	}
	
	// 댓글 수정
	@PostMapping("/updateReply.do")
	@ResponseBody
	public int updateReply(ReplyVO reply) {
		int result = mapper.updateReply(reply);
		log.info(reply.toString());
		return result;
	}
	
	// 댓글 삭제
	@PostMapping("/deleteReply.do")
	@ResponseBody
	public int deleteReply(int replyCode) {
		int result = mapper.deleteReply(replyCode);
		return result;
	}

	@GetMapping("/header")
	public void header(){
		log.info("헤더");
	}

	@GetMapping("/footer")
	public void footer(){
	}
}
