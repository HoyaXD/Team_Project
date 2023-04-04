package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.*;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.ReservationVO;
import org.green.seenema.vo.TheaterVO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/user")
public class ReservationController {
    @Autowired
    ReservationMapper reservationMapper;
    @Autowired
    MovieMapper movieMapper;

    @Autowired
    TheaterCRUDMapper tcMapper;

    @Autowired
    MovieCRUDMapper movieCRUDMapper;

    @Autowired
    MemberMapper memberMapper;

    @GetMapping("/reservationMain") //예약 메인으로 가기
    public void reservation(Model model){
        List<TheaterVO> tlist = tcMapper.getListGroupByPlace();
        List<MovieVO> mlist = movieMapper.getMovieList();

        model.addAttribute("tlist",tlist);
        model.addAttribute("mlist",mlist);
    }

    @GetMapping("/getMovieList.do") //영화목록 불러오기
    public @ResponseBody List<MovieVO> getMovieList(){
        return movieMapper.getMovieList();
    }

    @GetMapping("/getTheaterList.do") //영화관 정보 불러오기
    public @ResponseBody List<TheaterVO> TheaterList(String place){
        return tcMapper.getListWherePlace(place);
    }

    @PostMapping("/reservationSeats") //영화관 좌석선택으로 이동하기
    public void reservationSeats(Model model, ReservationVO reservation){
        model.addAttribute("reservation", reservation); // 예매정보 불러오기
        TheaterVO theater = reservationMapper.selectTheater(reservation.getTheater().trim()); //영화관 정보 불러오기
        model.addAttribute("theater", theater);
        MovieVO movie = reservationMapper.getMovie(reservation.getMovieCode());
        model.addAttribute("movie", movie);
    }

    @PostMapping("/loadSeats")
    public @ResponseBody List<String> loadSeats(ReservationVO reservation){
        log.info("좌석 불러오기 실행중 ...");
        log.info("예약정보 : " + reservation.toString());
        log.info("좌석정보 : " + reservationMapper.loadSeats(reservation).toString());

        return  reservationMapper.loadSeats(reservation);
    }



    @PostMapping("/reservation.do") //예매실행
    @Transactional
    public String reservationdo(ReservationVO reservation, Model model, HttpSession session) {
        log.info("예약정보 : " + reservation.toString());
        reservationMapper.cntPlus(reservation.getMovieCode(), reservation.getVisitors());
        reservation.setId((String) session.getAttribute("logid"));
        log.info("아이디 : " + reservation.getId());
        memberMapper.stampPlus(reservation.getId());
        int result = reservationMapper.regReservation(reservation);
        MovieVO movie = movieCRUDMapper.selectOne(reservation.getMovieCode());
        model.addAttribute("reservation", reservation);
        model.addAttribute("movie", movie);
        return "user/reservationComplete";
    }

    @GetMapping("/reservationComplete") //예매 성공페이지로 이동
    public void reservationComplete(){}

    @GetMapping("/cancelReservation.do")
    public String deleteReservationdo(Long ticketCode, Model model){
        int result = reservationMapper.cancelReservation(ticketCode);

        if (result ==1){
            model.addAttribute("msg", "예매취소가 완료되었습니다.");
            model.addAttribute("url", "/user/myReservation");
        }else {
            model.addAttribute("msg", "예매취소가 실패하였습니다.");
            model.addAttribute("url", "/");
        }

        return "user/alert";
    }

//    @GetMapping ("/getScreenTheater.do")
//    public @ResponseBody String getScreenTheater(int movieCode){
//        return movieMapper.selectOne(movieCode);
//    }


    @GetMapping("/getScreenTheater.do")
    public @ResponseBody String getScreenTheater(int movieCode) {
        String theaterList = movieMapper.selectOne(movieCode);
        String[] theaterArray = theaterList.split(",");
        JSONArray jsonArray = new JSONArray();

        for (String theaterName : theaterArray) {
            JSONObject theaterObject = new JSONObject();
            theaterObject.put("theaterName", theaterName);
            jsonArray.put(theaterObject);
        }

        return jsonArray.toString();
    }


    @GetMapping("loadPlayingTime.do")
    public @ResponseBody String loadPlayingTime(int movieCode){
        log.info(movieMapper.loadPlayingTime(movieCode));
        return movieMapper.loadPlayingTime(movieCode);
    }

}
