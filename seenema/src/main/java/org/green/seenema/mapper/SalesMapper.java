package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieSalesVO;
import org.green.seenema.vo.ReservationVO;

@Mapper
public interface SalesMapper {
	public ArrayList<ReservationVO> getMovieSales(String yearMonth);

	public ArrayList<ReservationVO> getMovieTopfive(String yearMonth);
	
	//모든 영화 관객수
	public int getAllMovieCnt(String yearMonth);
	
	//영화관 별 관객수
	public ArrayList<ReservationVO> getTheaterTopfive(String yearMonth);

	//성별별 예매율
	public ArrayList<ReservationVO> genderReservedCnt(String gender, String yearMonth);
	
	//예매된 장르조회
	public ArrayList<MovieSalesVO> allGenre();
}
