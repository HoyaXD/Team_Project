package org.green.seenema.controller;

import java.util.List;

import org.green.seenema.mapper.MgmtMapper;
import org.green.seenema.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin/memberView")
@Controller
public class AdminViewMemberController {

	@Autowired
	MgmtMapper mgmt;

	@GetMapping("/MemberMGMT")
	public void memberMGMTViewGo() {

	}
	// 관리자가 회원목록에서 아이디 검색
	@GetMapping("/MemberIdView")
	public @ResponseBody List<MemberVO> memberIdSearch(String id) {
		return mgmt.idSearch(id);
	}

	// 관리자가 회원목록에서 아이디 검색
	@GetMapping("/MemberNameView")
	public @ResponseBody List<MemberVO> memberNameSearch(String name) {
		return mgmt.nameSearch(name);
	}

	// 관리자가 회원목록에서 아이디 검색
	@GetMapping("/MemberGradeView")
	public @ResponseBody List<MemberVO> memberGradeSearch(String grade) {
		return mgmt.gradeSearch(grade);
	}

}
