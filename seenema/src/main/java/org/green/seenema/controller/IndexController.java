package org.green.seenema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class IndexController {
	@GetMapping("/")
	public String index() {
		return "index";
	}
	@GetMapping("/adminPage")
	public void adminPageGo() {
		
	}
	@GetMapping("/adminSidebar")
	public void adminPageGo2() {
		
	}
}
