package org.green.seenema.admin.product.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.green.seenema.mapper.ProductCRUDMapper;
import org.green.seenema.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminProductController {
	@Autowired
	ProductCRUDMapper mapper;
	
	@Autowired
	ProductVO pVo;
	
	@GetMapping("/productReg")
	public void regProduct() {
		//상품등록페이지
	}
	
	@PostMapping("/productReg.do")
	public String regProductDo(ProductVO product, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//상품등록실행
		String fileName = file.getOriginalFilename();
		
		product.setProductImage("images/" + fileName);
		
		ServletContext ctx = request.getServletContext();
		String uploadPath = "rosources/images";
		String path = ctx.getRealPath(uploadPath);
		
		File saveFile = new File(path, file.getOriginalFilename());
		
		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int result = mapper.insert(product);
		rs.addAttribute("insert_result", result);
		
		return "redirect:productList";
	}
	
	@GetMapping("/productList")
	public void productList(Model model) {
		//상품조회페이지
		
		ArrayList<ProductVO> pList = mapper.getList(0);
		model.addAttribute("pList", pList);
		
	}
	
	@GetMapping("/productUpdate")
	public void productUpdate(int productCode, Model model) {
		//상품정보수정페이지
		ProductVO product = mapper.selectOne(productCode);
		model.addAttribute("p", product);
	}
	
	@PostMapping("/productUpdate.do")
	public String productUpdateDo(ProductVO product, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//상품정보 수정 실행

		String fileName = file.getOriginalFilename();
		
		int update_result = -1;
		
		if(fileName.equals("")) {
			update_result = mapper.update(product);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:productList";
			
		}else {
			
			product.setProductImage("images/" + fileName);
			
			ServletContext ctx = request.getServletContext();
			String uploadPath = "resources/images";
			String path = ctx.getRealPath(uploadPath);
			
			File saveFile = new File(path, file.getOriginalFilename());
			
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			update_result = mapper.update(product);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:productList";
		}
	}
	@GetMapping("/productDelete.do")
	public String productDeleteDo(int productCode, RedirectAttributes rs) {
		//상품정보 삭제
		int result = mapper.delete(productCode);
		rs.addAttribute("del_result", result);
		
		return "redirect:productList";
	}
	
	@GetMapping("/products_delete.do")
	public @ResponseBody int products_deleteDo(int[] productCodes) {
		//상품 선택 삭제 실행
		int del_result = 0;
		
		for(int i = 0; i < productCodes.length; i++) {
			del_result = mapper.delete(productCodes[i]);
			System.out.println(productCodes[i]);
		}
		return del_result;
	}
	@GetMapping("/productList.do")
	public @ResponseBody ArrayList<ProductVO> productListDo() {
		//상품조회
		ArrayList<ProductVO> pList = mapper.getList(0);
		return pList;
	}
	@GetMapping("/productNameCnt")
	public @ResponseBody int productNameCnt(String productName) {
		//이름으로 상품 조회 cnt
		String _productName = "%" + productName + "%";
		
		int cnt = mapper.getListByNameCnt(_productName);
		
		return cnt;
	}
	@GetMapping("/getListByName.do")
	public @ResponseBody ArrayList<ProductVO> getListByName(String productName, int pageNum){
		//이름으로 상품 조회
		
		String _productName = "%" + productName + "%";
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<ProductVO> listByName = mapper.getListByName(_productName, _pageNum);
		
		System.out.println(listByName);
		
		return listByName;
	}
	@GetMapping("/productByPriceCnt")
	public @ResponseBody int productByPriceCnt(int start, int end) {
		//가격대로 상품조회 cnt
		int cnt = mapper.productByPriceCnt(start, end);
		return cnt;
	}
	@GetMapping("/getListByPrice.do")
	public @ResponseBody ArrayList<ProductVO> getListByPrice(int start, int end, int pageNum){
		//가격대로 상품 조회
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<ProductVO> listByPrice = mapper.getListByPrice(start, end, _pageNum);
		
		return listByPrice;
	}
	@GetMapping("/productByCategoryCnt")
	public @ResponseBody int productByCategoryCnt(String category) {
		//카테고리 검색 cnt
		String _category = "%" + category + "%";
		int cnt = mapper.productByCategoryCnt(_category);
		
		return cnt;
	}
	@GetMapping("/getListByCategory.do")
	public @ResponseBody ArrayList<ProductVO> getListByCategory(String category, int pageNum){
		//카테고리 검색
		String _category = "%" + category + "%";
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<ProductVO> listByCategory = mapper.getListByCategory(_category, _pageNum);
		
		return listByCategory;
	}
	
	
	//--정렬
	@GetMapping("/listByLowPriceCnt")
	public @ResponseBody int listByLowPriceCnt() {
		int cnt = mapper.listByLowPriceCnt();
		return cnt;
	}
	@GetMapping("/getListByLowPrice")
	public @ResponseBody ArrayList<ProductVO> getListByLowPrice(int pageNum){
		//낮은 가격 순으로 정렬
		
		int _pageNum = 10 * (pageNum - 1);
		ArrayList<ProductVO> getListByLowPrice = mapper.getListByLowPrice(_pageNum);
		
		return getListByLowPrice;
	}
	
	@GetMapping("/getListByHighPrice")
	public @ResponseBody ArrayList<ProductVO> getListByHighPrice(){
		//높은 가격 순으로 정렬
		ArrayList<ProductVO> getListByHighPrice = mapper.getListByHighPrice();
		
		return getListByHighPrice;
	}
	
	@GetMapping("/getListByLowSales")
	public @ResponseBody ArrayList<ProductVO> getListByLowSales(){
		//판매량 적은 순으로 정렬
		ArrayList<ProductVO> getListByLowSales = mapper.getListByLowSales();
		
		return getListByLowSales;
	}
	
	@GetMapping("/getListByHighSales")
	public @ResponseBody ArrayList<ProductVO> getListByHighSales(){
		//판매량 높은 순으로 정렬
		ArrayList<ProductVO> getListByHighSales = mapper.getListByHighSales();
		
		return getListByHighSales;
	}
	
	@GetMapping("/getListNameCategory")
	public @ResponseBody ArrayList<ProductVO> getListNameBest(String productName, String category){
		//상품명 > 카테고리 별 정렬
		String _productName = "%" + productName + "%";
		
		ArrayList<ProductVO> getListNameCategory = mapper.getListNameCategory(_productName, category);
		
		return getListNameCategory;
	}
	
	@GetMapping("/getListNamePrice")
	public @ResponseBody ArrayList<ProductVO> getListNamePrice(String productName, String price){
		//상품명 > 가격 순으로 정렬
		String _productName = "%" + productName + "%";
		if(price.equals("low")) {
			ArrayList<ProductVO> getListNameLowPrice = mapper.getListNameLowPrice(_productName);
			
			return getListNameLowPrice;
			
		}else {
			ArrayList<ProductVO> getListNameHighPrice = mapper.getListNameHighPrice(_productName);
			
			return getListNameHighPrice;
		}	
	}
	
	@GetMapping("/getListNameSales")
	public @ResponseBody ArrayList<ProductVO> getListNameSales(String productName, String sales){
		//상품명 > 판매량으로 정렬
		String _productName = "%" + productName + "%";
		if(sales.equals("low")) {
			ArrayList<ProductVO> getListNameLowSales = mapper.getListNameLowSales(_productName);
			
			return getListNameLowSales;
		}else {
			ArrayList<ProductVO> getListNameHighSales = mapper.getListNameHighSales(_productName);
			
			return getListNameHighSales;
		}
	}
	
	@GetMapping("/getListPriceCategory")
	public @ResponseBody ArrayList<ProductVO> getListPriceCategory(int start, int end, String category){
		//가격대 > 카테고리별 정렬
		ArrayList<ProductVO> getListPriceCategory = mapper.geListPriceCategory(start, end, category);
		
		return getListPriceCategory;
	}
	
	@GetMapping("/getListPricePrice")
	public @ResponseBody ArrayList<ProductVO> getListPricePrice(int start, int end, String price){
		//가격대 > 가격대 별 정렬
		if(price.equals("low")) {
			ArrayList<ProductVO> getListPriceLowPrice = mapper.getListPriceLowPrice(start, end);
			
			return getListPriceLowPrice;
		}else {
			ArrayList<ProductVO> getListPriceHighPrice = mapper.getListPriceHighPrice(start, end);
			
			return getListPriceHighPrice;
		}
	}
	
	@GetMapping("/getListPriceSales")
	public @ResponseBody ArrayList<ProductVO> getListPriceLowSales(int start, int end, String sales){
		
		//가격대 > 판매량 별 정렬
		
		if(sales.equals("low")) {
			ArrayList<ProductVO> getListPriceLowSales = mapper.getListPriceLowSales(start, end);
			
			return getListPriceLowSales;
		}else {
			ArrayList<ProductVO> getListPriceHighSales = mapper.getListPriceHighSales(start, end);
			
			return getListPriceHighSales;
		}
	}
	@GetMapping("/getListCategoryCategory")
	public @ResponseBody ArrayList<ProductVO> getListCategoryCategory(String category1, String category2){
		//다른카테고리로 정렬시 없는 카테고리로 화면출력
		if(category2.contains(category1)) {
			ArrayList<ProductVO> getListCategoryCategory = mapper.getListByCategory(category2 ,1);
			return getListCategoryCategory;
		}else {
			ArrayList<ProductVO> zero = mapper.getListPriceHighPrice(1, 0);
			return zero;			
		}
	}
	
	@GetMapping("/getListCategoryPrice")
	public @ResponseBody ArrayList<ProductVO> getListCategoryPrice(String category, String price){
		//카테고리 > 가격 순으로 정렬
		
		String _category = "%" + category + "%";
		
		if(price.equals("low")) {
			ArrayList<ProductVO> getListCategoryLowPrice = mapper.getListCategoryLowPrice(_category);
			
			return getListCategoryLowPrice;
		}else {
			ArrayList<ProductVO> getListCategoryHighPrice = mapper.getListCategoryHighPrice(_category);
			
			return getListCategoryHighPrice;
		}
	}
	
	@GetMapping("/getListCategorySales")
	public @ResponseBody ArrayList<ProductVO> getListCategorySales(String category, String sales){
		//카테고리 > 판매량 순으로 정렬
		String _category = "%" + category + "%";
		
		if(sales.equals("low")) {
			ArrayList<ProductVO> getListCategoryLowSales = mapper.getListCategoryLowSales(_category);
			
			return getListCategoryLowSales;
		}else {
			ArrayList<ProductVO> getListCategoryHighSales = mapper.getListCategoryHighSales(_category);
			
			return getListCategoryHighSales;
		}
	}
	
	@GetMapping("/getCnt")
	public @ResponseBody int getCnt() {
		//게시글 카운트
		int total = mapper.getCnt();
		
		return total;
	}
	@GetMapping("/goPage")
	public @ResponseBody ArrayList<ProductVO> goPage(int pageNum){
		ArrayList<ProductVO> list = mapper.getList(10 * (pageNum -1));
		return list;
	}
	
}
