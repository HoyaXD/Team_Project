package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieVO;

//영화 등록/삭제/조회/수정 interface

@Mapper
public interface MovieCRUDMapper {
	//영화등록
	public int insertMovie(MovieVO movieVO);
	
	//영화목록조회
	public ArrayList<MovieVO> getList(int pageNum);
	
	//영화페이지넘버 조회
	public ArrayList<MovieVO> getListNum(int pageNum);
	
	//영화코드로 영화 조회하기
	public MovieVO selectOne(int movieCode);
	
	//영화 제목으로 영화 조회하기
	public ArrayList<MovieVO> getListByTitle(String movieTitle, int pageNum);
	
	//영화 제목 조회 cnt
	public int titleCnt(String movieTitle);
	
	//개봉일로 영화 조회하기
	public ArrayList<MovieVO> getListByreleaseDate(String start, String end, int pageNum);
	
	//개봉일 조회 cnt
	public int dateCnt(String start, String end);
	
	//제목 + 개봉일로 영화 조회하기
	public ArrayList<MovieVO> getListByTitleDate(String movieTitle, String start, String end, int pageNum);
	
	//제목 + 개봉일 조회 cnt
	public int titleDateCnt(String movieTitle, String startDate, String endDate);
	
	//영화정보수정
	public int update(MovieVO movieVO);
	
	//영화정보삭제
	public int delete(int movieCode);
	
	//영화 cnt
	public int movieCnt();
	

	
	
}
