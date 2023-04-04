package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.NoticeVO;

@Mapper
public interface AdminNoticeMapper {

	// 공지사항출력
	public List<NoticeVO> noticeView();

	// 공지사항 선택시 출력
	public List<NoticeVO> noticeOneList(int noticeCode);

	// 공지사항 삭제
	public void noticeDel(int noticeCode);

	// 공지사항 수정
	public void noticeEdit(NoticeVO v);

	// 공지사항 등록
	public void noticeRegi(NoticeVO v);

	// 공지사항 코드로 검색
	public List<NoticeVO> noticeCodeSearch(@Param("searchCode") int noticeCode);

	// 공지사항 제목검색으로 찾기
	public List<NoticeVO> noticeTitleSearch(@Param("searchTitle") String title);

	// 공지사항 내용검색으로 찾기
	public List<NoticeVO> noticeContentsSearch(@Param("searchContents") String contents);
	
	// 공지사항 갯수 구하기
	public int noticeCount();

	// 공지사항 갯수 구하기
	public int noticeTitleCount(@Param("searchTitle")String title);

	// 공지사항 갯수 구하기
	public int noticeContentsCount(@Param("searchContents") String contents);

}
