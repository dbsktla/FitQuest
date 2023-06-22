package composite.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import reservation.model.ReservationBean;
import reservation.model.TscheduleBean;
import trainer.model.TrainerBean;
import usage.model.UsageBean;
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
	public List<TrainerListSBean> getTrainerListByTid(String mid,String tid) {
		UsageBean ub = new UsageBean();
		ub.setTid(tid);
		ub.setMid(mid);
		List<TrainerListSBean> tList = new ArrayList<TrainerListSBean>();
		tList = sqlSessionTemplate.selectList(namespace + ".GetTrainerListByTid", ub);
		return tList;
	}
	public List<ReservationDetailBean> getReservationDetail(String tid, String date, String time, int people) {
		ReservationBean rb = new ReservationBean();
		rb.setTid(tid);
		rb.setRdate(date);
		rb.setRtime(time);
		rb.setPeople(people);
		List<ReservationDetailBean> rList = new ArrayList<ReservationDetailBean>();
		rList = sqlSessionTemplate.selectOne(namespace+".ReservationDetailBean",rb);
		return rList;
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
	public List<MyOrderBean> getMyOrderList(String id) {
		List<MyOrderBean> mList = new ArrayList<MyOrderBean>();
		mList = sqlSessionTemplate.selectList(namespace + ".GetOrderList", id);
		return mList;
	}
	public List<TscheduleBean> getTscheduleByUsage(String mid, String tid, int people) {
		UsageBean ub = new UsageBean();
		ub.setMid(mid);
		ub.setTid(tid);
		ub.setPeople(people);
		List<TscheduleBean> tsList = new ArrayList<TscheduleBean>();
		tsList = sqlSessionTemplate.selectList(namespace + ".GetTscheduleByUsage",ub);
		return tsList;
	}
	public List<ReservationBean> getReservationNotComplete(String mid, String tid, int people) {
		ReservationBean rb = new ReservationBean();
		rb.setMid(mid);
		rb.setTid(tid);
		rb.setPeople(people);
		List<ReservationBean> rtList = new ArrayList<ReservationBean>();
		rtList = sqlSessionTemplate.selectList(namespace+".GetReservationNotComplete",rb);
		return rtList;
	}
}
