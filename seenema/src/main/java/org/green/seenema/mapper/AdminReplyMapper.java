package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.ReplyVO;

@Mapper
public interface AdminReplyMapper {

	// 관리자 한줄평 목록 보기
	public List<ReplyVO> replyListView();

	// 아이디로 한줄평 목록 출력
	public List<ReplyVO> replyLIdSearch(@Param("searchId") String id);

	// 영화코드로 한줄평 목록 출력
	public List<ReplyVO> replyMovieCodeSearch(@Param("searchMovieCode") String movieCode);

	// 별점으로 한줄평 목록 출력
	public List<ReplyVO> replyRateSearch(@Param("searchRate") int rate);

	// 별점으로 한줄평 목록 삭제
	public int replyDel(int replyCode);

	// 한줄평 갯수 구하기
	public int replyCount();

	// 한줄평 id 갯수 구하기
	public int replyIdCount(@Param("searchId") String id);

	// 한줄평 영화코드 갯수 구하기
	public int replymovieCodeCount(@Param("searchMovieCode") String movieCode);

	// 한줄평 별점으로 갯수 구하기
	public int replyRateCount(@Param("searchRate") int rate);

	// 메인페이지에 최근 3개의 리플 보여줌
	public List<ReplyVO> replyMainView();
}
