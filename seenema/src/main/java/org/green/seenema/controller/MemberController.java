package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.MemberMapper;
import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.mapper.ReservationMapper;
import org.green.seenema.vo.MemberVO;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.OrderVO;
import org.green.seenema.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
@Slf4j
public class MemberController {
    @Autowired
    MemberMapper mapper;

    @Autowired
    ReservationMapper reservationMapper;

    @Autowired
    MovieCRUDMapper movieCRUDMapper;

    @GetMapping("/loginForm")  //로그인폼으로 가기
    public void loginForm(){}

@PostMapping("/login.do")  //로그인 확인
public String login(MemberVO memberVO, HttpSession session, Model model, HttpServletRequest request) {
    MemberVO member = mapper.loginCheck(memberVO);
    String msg;
    if(member == null) {
        model.addAttribute("msg", "아이디와 비밀번호를 다시 확인해주세요");
        model.addAttribute("url", "/user/loginForm");
        return "user/alert";

    } else if(member.getGrade().equals("admin")){
        session.setAttribute("logid", memberVO.getId());
        msg ="redirect:/admin/adminPage";
    }else {
        session.setAttribute("logid", memberVO.getId());
        session.setAttribute("name", member.getName());
        session.setAttribute("tel", member.getTel());
        session.setAttribute("stamp", member.getStamp());
        model.addAttribute("msg", memberVO.getId()+"님 환영합니다!");
        model.addAttribute("url", "/");

        return "user/alert";
    }
    return msg;
}

    @GetMapping("/logout") //로그아웃
    public String logout(HttpSession session, HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        session.setAttribute("prevPage", referer);

        session.removeAttribute("logid"); // 로그인 아이디 세션 삭제

        return "redirect:" + referer;
    }

    @GetMapping("/idcheck.do") //아이디 중복확인
    public @ResponseBody String idcheck(String id, Model model) {
        String msg = null;
        int n = mapper.idCheck(id);
        if(n == 1) {
            msg = "<span style = 'color : red';>이미 사용 중인 아이디입니다.</span>";
        }else {
            msg = "<span style = 'color : green';>사용가능</span>";
        }
        return msg;
    }

    @GetMapping("/regMemberForm") //회원등록 폼으로 가기
    public void regMemberForm(){}

    @PostMapping("/reg.do") //회원등록
    public String regdo(MemberVO member){
        mapper.regMember(member);

        return "user/regMemberComplete";
    }

    @GetMapping("/myPage") // 마이페이지로가기
    public void mypage(Model model, HttpSession session){
        model.addAttribute("member", mapper.selectMember((String) session.getAttribute("logid")));
    }


    @GetMapping("/reservationHistory") //예매내역으로 가기
    public void reservationHistory(Model model, HttpSession session){
        List<ReservationVO> list =  reservationMapper.searchReservationList((String) session.getAttribute("logid"));
        model.addAttribute("list", list);
    }
    @GetMapping("/myReservation") //예매내역으로 가기
    public void myReservation(Model model, HttpSession session){
        model.addAttribute("member", mapper.selectMember((String) session.getAttribute("logid")));
    }
    @GetMapping("/myUpdate") //내 정보 수정으로 가기
    public void myUpdate(Model model, HttpSession session){
        model.addAttribute("member", mapper.selectMember((String) session.getAttribute("logid")));
    }

    @PostMapping("update.do") //내 정보 수정
    public String updatedo(Model model, MemberVO member){
        mapper.updateMember(member);
        model.addAttribute("msg", "회원정보 수정이 완료되었습니다!");
        model.addAttribute("url", "myUpdate");
        return "user/alert";
    }

    @GetMapping({"regMemberComplete", "/regAgree"})
    public void regMemberComplete(){}

    @GetMapping("/getReservationList.do")
    public @ResponseBody List<ReservationVO> getReservationList(String id){
        List<ReservationVO> list = reservationMapper.searchReservationList(id);
        for (int i = 0 ; i <list.size() ; i++){
        log.info("예매내역 정보 : " + list.get(i).toString());
        }
        return list;
    }

    @GetMapping("/reservationDetailView") //예매 상세 페이지로 이동하기
    public void reservationDetailView(Long ticketCode, Model model){
        ReservationVO reservation = reservationMapper.searchReservation(ticketCode);
        MovieVO movie = movieCRUDMapper.selectOne(reservation.getMovieCode());
        model.addAttribute("reservation", reservation);
        model.addAttribute("movie", movie);
    }


    @GetMapping("/searchGetReservationList.do")
    public @ResponseBody List<ReservationVO> searchGetReservationList(String id, String startDate, String endDate, int status){
        List<ReservationVO> list = reservationMapper.getSearchReservationList(id, startDate, endDate, status);
        for (int i = 0 ; i <list.size() ; i++){
            log.info("조회하기"+i+"번 : " + list.get(0).toString());
        }

        return list;
    }

}
