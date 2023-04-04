package org.green.seenema.sales.Controller;

import java.util.List;

import org.green.seenema.mapper.ProductSalesMapper;
import org.green.seenema.vo.ProductSalesVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdmimSalesViewController {
	
	@Autowired
	ProductSalesMapper prMapper;
	
	@GetMapping("/adminProductSalesView")
	public void adminProductSalesViewGo() {
		
	}
	
	@GetMapping("monthTotalPirce")
	public @ResponseBody List<ProductSalesVO> monthTotalPirceView() {
		return prMapper.monthTotalPirce();	
	}
	
	@GetMapping("productTotalView")
	public @ResponseBody List<ProductSalesVO> productTotalView() {
		return prMapper.productTotalView();	
	}
	
	@GetMapping("productManView")
	public @ResponseBody List<ProductSalesVO> productManView() {
		return prMapper.productManView();	
	}
	
	@GetMapping("productWomanView")
	public @ResponseBody List<ProductSalesVO> productWomanView() {
		return prMapper.productWomanView();	
	}
	
	@GetMapping("genderTotalPriceView")
	public @ResponseBody List<ProductSalesVO> genderTotalPriceView() {
		return prMapper.genderTotalPriceView();	
	}
	

}
