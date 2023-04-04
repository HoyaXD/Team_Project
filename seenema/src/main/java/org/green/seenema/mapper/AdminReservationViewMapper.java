package org.green.seenema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.ReservationVO;

@Mapper
public interface AdminReservationViewMapper {


	public List<Map<String, Object>> reservationMainView();

	public List<ReservationVO> reservationAllView(@Param("searchKeyword") String searchKeyword, @Param("start") int start);

	public int reservationAllCount();
	
	public int reservationIdCount(@Param("searchKeyword") String searchKeyword);

	public int reservationCodeCount(@Param("searchKeyword") String searchKeyword);

	public int reservationTitleCount(@Param("searchKeyword") String searchKeyword);

	public int reservationDateCount(@Param("searchKeyword") String searchKeyword);

	public List<ReservationVO> reservationId(@Param("searchKeyword") String searchKeyword, @Param("start") int start);

	// ticketcode
	public List<ReservationVO> reservationCode(@Param("searchKeyword") String searchKeyword, @Param("start") int start);

	// 영화제목
	public List<ReservationVO> reservationTitle(@Param("searchKeyword") String searchKeyword, @Param("start") int start);

	// 상영날짜
	public List<ReservationVO> reservationDate(@Param("searchKeyword") String searchKeyword, @Param("start") int start);

	public List<Map<String, Object>> reservationMainViewCount();
}
