package org.green.seenema.admin.qna.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.seenema.mapper.AdminQnaMapper;
import org.green.seenema.vo.QnaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminQnaController {
	   @Autowired
	   AdminQnaMapper adMapper;

	   @GetMapping("/qnaView")
	   public void qnaView() {
	   }

	   // 문의글 호출
	   @GetMapping("/qnaList")
	   public @ResponseBody List<QnaVO> getQnaList() {
	      return adMapper.qnaListView();
	   }

	   // 선택한 문의글 호출
	   @GetMapping("/qnaOneList")
	   public @ResponseBody QnaVO oneQnaList(int qcode) {
	      QnaVO qv = adMapper.qnaOneList(qcode);
	      return qv;
	   }

	   // 관리자가 문의글목록에서 아이디 검색
	   @GetMapping("/qnaIdSearch")
	   public @ResponseBody List<QnaVO> qnaIdSearch(@Param("searchId") String id) {
	      
	      return adMapper.qnaIdSearch(id);
	   }

	   // 관리자가 문의글목록에서 제목 검색
	   @GetMapping("/qnaTitleSearch")
	   public @ResponseBody List<QnaVO> qnaTitleSearch(@Param("searchTitle") String title) {
	      return adMapper.qnaTitleSearch(title);
	   }

	   // 관리자가 문의글목록에서 내용 검색
	   @GetMapping("/qnaContentsSearch")
	   public @ResponseBody List<QnaVO> qnaContentsSearch(@Param("searchContents") String contents) {
	      return adMapper.qnaContentsSearch(contents);
	   }
	   
		// 문의글 갯수
		@GetMapping("qnaCount")
		public @ResponseBody int qnaCount() {
			return adMapper.qnaCount();
		}

		// 문의글 id갯수
		@GetMapping("qnaIdCount")
		public @ResponseBody int qnaIdCount(@Param("searchId") String id) {
			return adMapper.qnaIdCount(id);
		}

		// 문의글 제목갯수
		@GetMapping("qnaTitleCount")
		public @ResponseBody int qnaTitleCount(@Param("searchTitle") String title) {
			return adMapper.qnaTitleCount(title);
		}

		// 문의글 내용갯수
		@GetMapping("qnaContentsCount")
		public @ResponseBody int qnaContentsCount(@Param("searchContents") String contents) {
			return adMapper.qnaContentsCount(contents);
		}
		
		// 문의글 호출
		@GetMapping("/qnaMainView")
		public @ResponseBody List<QnaVO> qnaMainView() {
		   return adMapper.qnaMainView();
		}
		
		@PostMapping("/qnaAdminAnswer")
		public @ResponseBody void qnaAdminAnswer(int qcode, String answer) {
			adMapper.qnaAdminAnswer(qcode, answer);
		}

}
