package community.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class BoardDao {
	private String namespace = "board.model.Board";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getFreeBoardCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetFreeBoardCount",map);
		return cnt;
	}

	public List<BoardBean> getFreeBoardList(Paging pageInfo, Map<String, String> map) {
		List<BoardBean> freeBoardList = new ArrayList<BoardBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		freeBoardList = sqlSessionTemplate.selectList(namespace + ".GetFreeBoardList", map, rowBounds);
		return freeBoardList;
	}
	
	public List<BoardBean> getHotFreeBoardList() {
		List<BoardBean> hotFreeBoardList = new ArrayList<BoardBean>();
		hotFreeBoardList = sqlSessionTemplate.selectList(namespace + ".GetHotFreeBoardList");
		return hotFreeBoardList;
	}

	public int updateBreadcount(int bnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".UpdateBreadcount", bnum);
		return cnt;
	}

	public BoardBean getOneFreeBoard(int bnum) {
		BoardBean boardBean = null;
		boardBean = sqlSessionTemplate.selectOne(namespace + ".GetOneFreeBoard", bnum);
		return boardBean;
	}

	public int insertFreeBoard(BoardBean boardBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertFreeBoard", boardBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}

	public int deleteFreeBoard(int bnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteFreeBoard", bnum);
		return cnt;
	}

	public int updateFreeBoard(BoardBean boardBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.update(namespace + ".UpdateFreeBoard", boardBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}
	public int replyFreeBoard(BoardBean boardBean) {
		int up_cnt = -1, cnt = -1;
		up_cnt = sqlSessionTemplate.update(namespace + ".UpdateBrestep", boardBean);
		System.out.println("up_cnt : " + up_cnt);
		if(up_cnt != -1) {
			boardBean.setBrestep(boardBean.getBrestep() + 1);
			boardBean.setBrelevel(boardBean.getBrelevel() + 1);
			try {
				cnt = sqlSessionTemplate.insert(namespace + ".ReplyFreeBoard", boardBean);
			} catch(Exception e){
				
			}
		}
		return cnt;
	}
}
