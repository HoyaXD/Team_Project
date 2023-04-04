package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.MemberVO;

@Mapper
public interface MgmtMapper {
	
	//관리자가 회원목록보기
	public List<MemberVO> memberView();
	
	//관리자가 회원목록삭제
	public void memberDel(String id);
	
	//관리자가 수정을 위한 한명의 회원목록 출력
	public List<MemberVO> oneMemList(@Param("userid") String id);
	
	//관리자가 회원목록 수정하기
	public void editInfo(MemberVO v);
	
	//관리자가 아이디로 회원검색
	public List<MemberVO> idSearch(@Param("searchId") String id);
	
	//관리자가 이름으로 회원검색
	public List<MemberVO> nameSearch(@Param("searchName") String name);
	
	//관리자가 등급으로 회원검색
	public List<MemberVO> gradeSearch(@Param("searchGrade") String grade);

	// 관리자가 회원목록보기
	public int memberCount();
	
	// 관리자가 아이디로 회원검색
	public int memberIdCount(@Param("searchId") String id);

	// 관리자가 이름으로 회원검색
	public int memberNameCount(@Param("searchName") String name);

	// 관리자가 등급으로 회원검색
	public int memberGradeCount(@Param("searchGrade") String grade);


}
