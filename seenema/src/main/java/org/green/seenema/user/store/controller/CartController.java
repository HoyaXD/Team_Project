package org.green.seenema.user.store.controller;

import java.util.List;

import org.green.seenema.user.store.mapper.StoreMapper;
import org.green.seenema.vo.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@Slf4j
public class CartController {
	@Autowired
	private StoreMapper mapper;
	
	// 장바구니 목록 불러오기
	@PostMapping("/cart/getCartList.do")
	public List<CartVO> getCartList(String id){
		List<CartVO> list = mapper.getCartList(id);
		return list;
	}
	
	// 카트에 상품 추가
	@PostMapping("/cart/addCart.do")
	public int addCart(CartVO cart) {
		int checkResult = mapper.checkCart(cart.getId(), cart.getProductCode());
		if(checkResult == 1) {
			// 이미 상품이 존재하면 -1 리턴
			return -1;
		}else {
			// 상품이 존재하지 않으면 1 리턴
			int result = mapper.addCart(cart);
			return result;
		}
	}
	
	// 상품 수량 업데이트
	@PostMapping("/cart/updateProductCount.do")
	public int updateProductCount(@RequestParam int productCode, @RequestParam String id, @RequestParam("count") int productCount) {
		int result = mapper.updateProductCount(productCode, id, productCount);
		return result;
	}
	
	// 장바구니 개별삭제
	@PostMapping("/cart/deleteProduct.do")
	public int deleteUser(@RequestParam int productCode, @RequestParam String id) {
		//log.info(productCode + ", " + id);
		int result = mapper.deleteProduct(productCode, id);
		return result;
	}
	
	// 장바구니 선택삭제
	@PostMapping("/cart/selectDelete.do")
	public int selectDelete(@RequestParam("productCodes") int[] productCodes, String id) {
		int result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			result = mapper.deleteProduct(productCodes[i], id);
		}
		return result;
	}
}
