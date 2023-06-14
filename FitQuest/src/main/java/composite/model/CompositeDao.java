package composite.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import trainer.model.TrainerBean;
import utility.Paging;

@Component
public class CompositeDao {
	private final String namespace = "composite.model.Composite";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getTrainerCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetTrainerCount", map);
		return cnt;
	}
	public List<TrainerListBean> getTrainerList(Map<String, String> map, Paging pageInfo) {
		List<TrainerListBean> tList = new ArrayList<TrainerListBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		tList = sqlSessionTemplate.selectList(namespace + ".GetTrainerList", map, rowBounds);
		return tList;
	}
	public List<TrainerListBean> getSimilarTrainerList(TrainerBean trainerBean) {
		List<TrainerListBean> tList = new ArrayList<TrainerListBean>();
		tList = sqlSessionTemplate.selectList(namespace + ".GetSimilarTrainers", trainerBean);
		return tList;
	}
	public TrainerListSBean getTrainerListByTid(String tid) {
		TrainerListSBean trainers = sqlSessionTemplate.selectOne(namespace + ".GetTrainerListByTid", tid);
		return trainers;
	}
	public ReservationDetailBean getReservationDetail(int rnum) {
		ReservationDetailBean reservationDetailBean = sqlSessionTemplate.selectOne(namespace+".ReservationDetailBean",rnum);
		return reservationDetailBean;
	}
	public List<SalesBean> getWeeklySales(String id) {
		List<SalesBean> weeklySalesList = sqlSessionTemplate.selectList(namespace + ".GetWeeklySales", id);
		return weeklySalesList;
	}
	public List<SalesBean> getMonthlySales(String id) {
		List<SalesBean> monthlySalesList = sqlSessionTemplate.selectList(namespace+".GetMonthlySales", id);
		return monthlySalesList;
	}
	public List<SalesBean> getTotalSales(String id) {
		List<SalesBean> totalSalesList = sqlSessionTemplate.selectList(namespace + ".GetTotalSales", id);
		return totalSalesList;
	}
	public double getAverageSaleByActivity(String activity) {
		double avgSale = sqlSessionTemplate.selectOne(namespace+ ".GetAverageSale", activity);
		return avgSale;
	}
	public List<SalesBean> getWeeklyCount(String id) {
		List<SalesBean> weeklyList = sqlSessionTemplate.selectList(namespace + ".GetWeeklyCount", id);
		return weeklyList;
	}
	public List<SalesBean> getMonthlyCount(String id) {
		List<SalesBean> monthlyList = sqlSessionTemplate.selectList(namespace + ".GetMonthlyCount", id);
		return monthlyList;
	}
	public List<ReservationListActBean> getReservationListAct(String mid) {
		List<ReservationListActBean> rList = new ArrayList<ReservationListActBean>();
		rList = sqlSessionTemplate.selectList(namespace + ".GetReservationListAct", mid);
		return rList;
	}
	public ReservationDetailGBean getReservationDetailG(int rnum) {
		ReservationDetailGBean reservationDetailGBean = sqlSessionTemplate.selectOne(namespace+".GetReservationDetailG",rnum);
		return reservationDetailGBean;
	}
}
