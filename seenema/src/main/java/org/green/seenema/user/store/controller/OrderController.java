package org.green.seenema.user.store.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;

import org.green.seenema.user.store.mapper.OrderMapper;
import org.green.seenema.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@RestController
@RequestMapping("/user")
@Slf4j
public class OrderController {
	@Autowired
	private OrderMapper mapper;

	// 개별구매
	@PostMapping("/order/buy.do")
	public int buy(OrderVO order) {
		int result = mapper.buy(order);
		if(result == 1) {
			// 제품테이블 sales 반영
			mapper.updateProductSales(order.getProductCode());
		}
		return result;
	}
	
	final DefaultMessageService messageService;
	
    public OrderController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageService = NurigoApp.INSTANCE.initialize("NCSYUUMSYVNXTMC5", "SVLUDXYOALHHXR1VVVAMJQHQ7ZCL4UYT", "https://api.coolsms.co.kr");
    }
    
    // coolSms
	@PostMapping("/send-one")
 	public SingleMessageSentResponse sendOne(String orderNum) {
      Message message = new Message();
      // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
      message.setFrom("01047225462");
      message.setTo("01025955462");	// 고객 전화번호 필요
      message.setText("[SEENEMA]\n고객님의 관람권 번호는\n" + orderNum + "\n입니다.");

      SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
      //System.out.println(response);
      return response;
    }
	
	// 일괄구매
	@PostMapping("/order/buyProducts.do")
	public int buyProducts(@RequestParam("orderNum") Long orderNum
			, @RequestParam("productCodes") int[] productCodes
			, @RequestParam("prices") int[] prices
			, @RequestParam("counts") int[] counts
			, @RequestParam("id") String id
			, @RequestParam("userName") String userName
			, @RequestParam("refundCode") String refundCode) {
		int result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			OrderVO order = new OrderVO();
			order.setOrderNum(orderNum + (i + 1));
			order.setProductCode(productCodes[i]);
			order.setPrice(prices[i]);
			order.setCount(counts[i]);
			order.setId(id);
			order.setUserName(userName);
			order.setRefundCode(refundCode);
			
			result = mapper.buy(order);
			if(result == 1) {
				// 제품테이블 sales 반영
				mapper.updateProductSales(order.getProductCode());
			}
		}
		return result;
	}
	
	// 결제내역 목록 가져오기
	@GetMapping("/order/getOrderList.do")
	public List<OrderVO> getOrderList(String id, int pageNum) {
		int count = (pageNum - 1) * 10;
		List<OrderVO> list = mapper.getOrderList(id, count);
		return list;
	}
	
	// 결제내역 날짜선택 조회
	@PostMapping("/order/searchGetOrderList.do")
	public List<OrderVO> getSearchOrderList(String id, String startDate, String endDate, int status, int pageNum){
		int count = (pageNum - 1) * 10;
		if(status == 0) {
			List<OrderVO> list = mapper.getOrderList(id, count);
			return list;
		}else {
			List<OrderVO> list = mapper.getSearchOrderList(id, startDate, endDate, status, count);
			return list;
		}
	}
	
	// 결제 상세페이지 정보 가져오기
	@GetMapping("/order/getDetail.do")
	public OrderVO getDetail(Long orderNum){
		OrderVO order = mapper.getOrderDetail(orderNum);
		return order;
	}
	
	@PostMapping("/order/refund.do")
	public int refund(Long orderNum){
		int result = mapper.refund(orderNum);
		return result;
	}
	
	// 결제 취소 상태 변경
	@PostMapping("/order/changeStatus.do")
	public int changeStatus(Long orderNum) {
		int result = mapper.refund(orderNum);
		return result;
	}
	// 페이징
	@GetMapping("/order/getOrderCount.do")
	public int getOrderCount(String id, int status) {
		if(status == 0) {
			// 전체조회 행 갯수
			int result = mapper.getOrderCount(id);
			return result;
		}else {	
			// 만약 결제취소나 결제완료를 선택했을 경우 행 갯수
			int result = mapper.getSearchOrderCount(id, status);
			return result;
		}
	}
}