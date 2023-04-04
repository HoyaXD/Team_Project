package org.green.seenema.user.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.OrderVO;

@Mapper
public interface OrderMapper {
	// 제품 구매
	public int buy(@Param("order") OrderVO order);
	
	// 구매 목록
	public List<OrderVO> getOrderList(@Param("id") String id, @Param("count") int count);
	
	// 구매목록 조회
	public List<OrderVO> getSearchOrderList(
			@Param("id") String id,
			@Param("startDate") String startDate,
			@Param("endDate") String endDate,
			@Param("status") int status,
			@Param("count") int count);
	
	public OrderVO getOrderDetail(Long orderNum);
	public int refund(Long orderNum);
	
	//==========================================
	public int getOrderCount(String id);
	public int getSearchOrderCount(@Param("id") String id, @Param("status") int status);
	
	public int updateProductSales(int productCode);
}