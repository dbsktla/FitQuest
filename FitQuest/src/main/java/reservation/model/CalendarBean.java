package reservation.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class CalendarBean {
	String year = "";
	String month = "";
	String date = "";
	String value = "";
	public CalendarBean() {
		
	}
	public CalendarBean(String year, String month, String date, String value) {
		super();
		this.year = year;
		this.month = month;
		this.date = date;
		this.value = value;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	public Map<String, Integer> today_info(CalendarBean dateData) {  //캘린더 함수 넣어주기
		Map<String, Integer> today_Data = new HashMap<String, Integer>(); 
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(dateData.getYear()), Integer.parseInt(dateData.getMonth()), 1);

		int startDay = cal.getMinimum(java.util.Calendar.DATE);
		int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		int start = cal.get(java.util.Calendar.DAY_OF_WEEK);

		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat ysdf = new SimpleDateFormat("yyyy");
		SimpleDateFormat msdf = new SimpleDateFormat("M");

		//오늘 날짜
		int today_year = Integer.parseInt(ysdf.format(todayCal.getTime()));
		int today_month = Integer.parseInt(msdf.format(todayCal.getTime()));

		int search_year = Integer.parseInt(dateData.getYear());
		int search_month = Integer.parseInt(dateData.getMonth()) + 1;

		int today = -1; //0부터 시작이라
		if (today_year == search_year && today_month == search_month) {
		SimpleDateFormat dsdf = new SimpleDateFormat("dd");
		today = Integer.parseInt(dsdf.format(todayCal.getTime()));
		}

		search_month = search_month-1; 

		Map<String, Integer> before_after_calendar = before_after_calendar(search_year,search_month);


		System.out.println("search_month : " + search_month);

		today_Data.put("start", start);
		today_Data.put("startDay", startDay);
		today_Data.put("endDay", endDay);
		today_Data.put("today", today);
		today_Data.put("search_year", search_year);
		today_Data.put("search_month", search_month+1);
		today_Data.put("before_year", before_after_calendar.get("before_year"));
		today_Data.put("before_month", before_after_calendar.get("before_month"));
		today_Data.put("after_year", before_after_calendar.get("after_year"));
		today_Data.put("after_month", before_after_calendar.get("after_month"));
		return today_Data;
		}

		private Map<String, Integer> before_after_calendar(int search_year, int search_month){
		Map<String, Integer> before_after_data = new HashMap<String, Integer>();
		int before_year = search_year;
		int before_month = search_month-1;
		int after_year = search_year;
		int after_month = search_month+1;

		if(before_month<0){
		before_month=11;
		before_year=search_year-1;
		}

		if(after_month>11){
		after_month=0;
		after_year=search_year+1;
		}

		before_after_data.put("before_year", before_year);
		before_after_data.put("before_month", before_month);
		before_after_data.put("after_year", after_year);
		before_after_data.put("after_month", after_month);

		return before_after_data;
		}

}