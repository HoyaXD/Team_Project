package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.NoticeVO;
import org.green.seenema.vo.QnaVO;
import org.green.seenema.vo.TheaterVO;

@Mapper
public interface UserNoticeMapper {
	// 공지 목록
	public List<NoticeVO> getNoticeList(int count);
	// 공지 갯수
	public int getNoticeCount();
	// 공지 상세
	public NoticeVO getNoticeInfo(int noticeCode);
	// 공지 이전글 가져오기
	public NoticeVO getPrevContent(int noticeCode);
	// 공지 다음글 가져오기
	public NoticeVO getNextContent(int noticeCode);
	// 공지 조회수 업데이트
	public void plusView(int noticeCode);
	// Q&A 목록
	public List<QnaVO> getQnaList(int count);
	// Q&A 상세
	public QnaVO getQnaInfo(int qcode);
	// Q&A 삭제
	public int deleteQna(int qCode);
	// 공지 갯수
	public int getQnaCount();
	// 키워드 조회(제목)
	public List<NoticeVO> searchByTitleList(@Param("keyword") String keyword, @Param("count") int count);
	// 키워드 조회(내용)
	public List<NoticeVO> searchByContentsList(@Param("keyword") String keyword, @Param("count") int count);
	// Q&A 등록
	public int regQna(@Param("title") String title, @Param("contents") String contents, @Param("id") String id);
	// 상영관 정보
	public TheaterVO getTheaterInfo(String theaterName);
	// 페이징(제목)
	public int getSearchByTitleCount(String keyword);
	// 페이징(내용)
	public int getSearchByContentsCount(String keyword);
}
