package org.green.seenema.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.green.seenema.mapper.AdminEventMapper;
import org.green.seenema.vo.EventVO;
import org.green.seenema.vo.MemberVO;
import org.green.seenema.vo.MovieVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RequestMapping("/admin")
@Controller
public class adminEventController {

	@Autowired
	AdminEventMapper aeMapper;

	@GetMapping("/adminEventRegi")
	public void adminEventRegiGo() {

	}

	@GetMapping("/adminEventView")
	public void adminEventViewGo() {

	}

	@PostMapping("/regiEvent")
	public String regiEvent(EventVO ev, @RequestParam("eventFileName") MultipartFile file, HttpServletRequest request,
			RedirectAttributes rs, BindingResult bindingResult) {

		String fileName = file.getOriginalFilename();
		ev.setFileName(fileName);

		ServletContext ctx = request.getServletContext();
		String uploadPath = "resources/images";
		String path = ctx.getRealPath(uploadPath);
		File saveFile = new File(path, file.getOriginalFilename());

		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		aeMapper.insertEvent(ev);
		// 성공시 이벤트 리스트 출력창으로
		return "redirect:adminEventView";
	}

	@GetMapping("/getEventList")
	public @ResponseBody List<EventVO> getEventList() {
		return aeMapper.getEventList();
	}

	/*
	 * @GetMapping("/getEvenetDetail") public @ResponseBody EventVO
	 * getEvenetDetail(@Param("eventNo") int eventNo) { System.out.println(eventNo);
	 * 
	 * }
	 */

	@GetMapping("/eventEditPop")
	public List<EventVO> eventEditPop(@Param("eventNo") int eventNo, Model model) {
		List<EventVO> list = aeMapper.getEvenetDetail(eventNo);
		model.addAttribute("event", list);
		return list;
	}
	
	@PostMapping("/editEvent")
	public String editEvent(EventVO ev, @RequestParam("eventFileName") MultipartFile file, HttpServletRequest request,
			RedirectAttributes rs) {

		String fileName = file.getOriginalFilename();
		ev.setFileName(fileName);

		ServletContext ctx = request.getServletContext();
		String uploadPath = "resources/images";
		String path = ctx.getRealPath(uploadPath);
		File saveFile = new File(path, file.getOriginalFilename());

		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		aeMapper.editEvent(ev);
		return "redirect:eventClose";
	}
	@GetMapping("/eventClose")
	public void eventCloseGo() {
		
	}
	
	@GetMapping("/eventDel")
	public @ResponseBody void delEvent(@Param("eventNo") int eventNo) {
		aeMapper.delEvent(eventNo);
	}

}
