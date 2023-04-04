package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.QnaVO;
import org.springframework.ui.Model;

@Mapper
public interface AdminQnaMapper {

	// 관리자가 qna목록보기
	public List<QnaVO> qnaListView();

	// 관리자 qna선택한 목록출력
	public QnaVO qnaOneList(int qcode);

	// 관리자가 아이디로 qna검색
	public List<QnaVO> qnaIdSearch(@Param("searchId") String id);

	// 관리자가 제목으로 qna검색
	public List<QnaVO> qnaTitleSearch(@Param("searchTitle") String name);

	// 관리자가 내용으로 qna검색
	public List<QnaVO> qnaContentsSearch(@Param("searchContents") String grade);
	
	// qna 목록갯수
	public int qnaCount();

	// 공지사항 갯수 구하기
	public int qnaIdCount(@Param("searchId") String id);

	// 공지사항 갯수 구하기
	public int qnaTitleCount(@Param("searchTitle") String title);

	// 공지사항 갯수 구하기
	public int qnaContentsCount(@Param("searchContents") String contents);
	
	public List<QnaVO> qnaMainView();
	
	public void qnaAdminAnswer(@Param("updateCode") int qcode, @Param("updateContents") String answer);

}
