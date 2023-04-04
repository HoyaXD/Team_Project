package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TheaterVO {
   private int theaterCode;         //영화관코드
   private String theaterPlace;      //영화관지역
   private String theaterName;         //상영관
   private String theaterAddress;      //영화관주소
   private String theaterTel;         //영화관연락처
   private String theaterImage; //영화관 이미지
   private int cnt; //
   private int seat_column; //좌석 행
   private int seat_row; //좌석 열
}
