package org.green.seenema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.OrderVO;
import org.green.seenema.vo.ReservationVO;
import org.green.seenema.vo.TheaterVO;

import java.util.List;
import java.util.Stack;

@Mapper
public interface ReservationMapper {
    public List<ReservationVO> searchReservationList(String id);
    public ReservationVO searchReservation(Long ticketCode);

    public int regReservation(ReservationVO reservation);

    public List<String> loadSeats(ReservationVO reservation);

    public void cntPlus(@Param("movieCode") int movieCode, @Param("visitors") int visitors);

    public TheaterVO loadTheater (String theaterPlace, String theaterName);

    public List<ReservationVO> getReservationList(String id);

    public List<ReservationVO> getSearchReservationList(
            @Param("id") String id,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate,
            @Param("status") int status);

    public TheaterVO selectTheater(String theaterName);

    public int cancelReservation (Long ticketCode);

    public MovieVO getMovie (int movieCode);
}
