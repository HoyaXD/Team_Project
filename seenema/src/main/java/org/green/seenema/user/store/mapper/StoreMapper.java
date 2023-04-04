package org.green.seenema.user.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.CartVO;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface StoreMapper {
	// 제품 상세정보
	public ProductVO getProductInfo(int productCode);
	
	// 장바구니 담기
	public int addCart(@Param("cart") CartVO cart);
	
	// 장바구니에 상품이 존재하는지 확인
	public int checkCart(@Param("id") String id, @Param("productCode") int productCode);
	
	// 장바구니 목록
	public List<CartVO> getCartList(String id);
	
	// 장바구니에서 삭제
	public int deleteProduct(@Param("productCode") int productCodes, @Param("id")String id);
	
	// 장바구니 상품 수량변경
	public int updateProductCount(@Param("productCode") int productCode, @Param("id")String id, @Param("productCount") int count);
	
	// 스토어 상품목록 리스트
	public List<ProductVO> getProductList();
}
