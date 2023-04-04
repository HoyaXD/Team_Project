package org.green.seenema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MemberVO;

@Mapper
public interface MemberMapper {

    public MemberVO loginCheck(MemberVO member);

    public int idCheck(String id);

    public void regMember(MemberVO member);

    public MemberVO selectMember(String id);

    public void updateMember(MemberVO member);

    public void stampPlus(String id);
}
