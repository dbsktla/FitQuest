package reservation.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;

@Controller
public class TrainerScheduleUpdateController {
	private final String command = "/tScheduleUpdate.rv";
	private final String getPage = "trainerScheduleUpdate";
	private final String gotoPage = "redirect:/trainerCalendar.rv";

	@Autowired
	TscheduleDao tscheduleDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(HttpSession session,Model model,
			@RequestParam("tspeople") int tspeople) {
		
		//설정해놓은 스케줄 가져가기(인원수 기준)
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<TscheduleBean> tsList = tscheduleDao.findTscheduleByTspeople(tspeople,tid); 
		
		String[] tsdateArr = null;
		TscheduleBean timeBean = new TscheduleBean();
		
		//날짜 문자열 date 타입으로 변환(기본값으로 넣기 위해)
		for(TscheduleBean tb : tsList) {
			if(tb.getTsdate() != null) {
				tsdateArr = tb.getTsdate().split(","); //2023-06-23 2023-06-24
			}
			// 요일에 따라 변수 설정
    	    if (tb.getTsday().equals("sun")) {
    	    	timeBean.setSuntime(tb.getTstime());
    	    }else if (tb.getTsday().equals("mon")) {
    	    	timeBean.setMontime(tb.getTstime());
    	    }else if (tb.getTsday().equals("tue")) {
    	    	timeBean.setTuetime(tb.getTstime());
    	    }else if (tb.getTsday().equals("wed")) {
    	    	timeBean.setWedtime(tb.getTstime());
    	    }else if (tb.getTsday().equals("thu")) {
    	    	timeBean.setThutime(tb.getTstime());
    	    }else if (tb.getTsday().equals("fri")) {
    	    	timeBean.setFritime(tb.getTstime());
    	    }else if (tb.getTsday().equals("sat")) {
    	    	timeBean.setSattime(tb.getTstime());
    	    }
		}
		
		List<java.sql.Date> dateList = null;
		if(tsdateArr != null) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateList = new ArrayList<java.sql.Date>();
			
			try {
				for (String dateString : tsdateArr) {
					java.util.Date utilDate = dateFormat.parse(dateString);
					java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
					dateList.add(sqlDate);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
    	
    	//요일별 선점된 시간대 가져가기
    	model.addAttribute("existSun",timeBean.getSuntime());
    	model.addAttribute("existMon",timeBean.getMontime());
    	model.addAttribute("existTue",timeBean.getTuetime());
    	model.addAttribute("existWed",timeBean.getWedtime());
    	model.addAttribute("existThu",timeBean.getThutime());
    	model.addAttribute("existFri",timeBean.getFritime());
    	model.addAttribute("existSat",timeBean.getSattime());
        
        model.addAttribute("dateList",dateList); //쉬는날
        model.addAttribute("tspeople",tspeople);
        if(tspeople == 1) {
        	model.addAttribute("tstype","개인");
        }else {
        	model.addAttribute("tstype","그룹");
        }
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public String doAction(TscheduleBean tscheduleBean, HttpServletRequest request, Model model, HttpSession session,
			@RequestParam("tsdate") List<String> tsdateList,
			@RequestParam("tspeople") int tspeople,
			@RequestParam("tstype") String tstype,
			@RequestParam("selectedDays") String[] selectedDays) {
		
		System.out.println("빈 안에 tsdate:"+tscheduleBean.getTsdate());
		
		for(String tsdatelist : tsdateList) {
			System.out.println("날짜 리스트로 받은거:"+tsdatelist);
		}
		for(String day : selectedDays) {
			System.out.println("선택한 요일:"+day);
		}
		
		
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<TscheduleBean> tsList = tscheduleDao.findTscheduleByTspeople(tspeople,tid); 
		
		//기존에 있던 요일과 비교하기
		for (TscheduleBean tb : tsList) {
			
			if (tsdateList.isEmpty()) {
			    System.out.println("값이 누락되었습니다.");
			    tb.setTsdate("null");
			}else {
				//쉬는날이 여러날일 경우 한번에 담아 가져가기
				String tsdate = ""; 
				
				if(tsdateList.size() > 1) {
					for(int i=0;i<tsdateList.size();i++) {
						tsdate += tsdateList.get(i);
						if (i < tsdateList.size() - 1) {
							tsdate += ",";
						}
					}
				} 
				tb.setTsdate(tsdate);
			}
			
		    if (Arrays.asList(selectedDays).contains(tb.getTsday())) { // 요일 일치 - update
		    	String tsday = tb.getTsday();
		    	System.out.println("update-요일:"+tsday);
		        String tstime = "";

		        if (tsday.equals("sun")) {
		            tstime = tscheduleBean.getSuntime();
		        } else if (tsday.equals("mon")) {
		            tstime = tscheduleBean.getMontime();
		        } else if (tsday.equals("tue")) {
		            tstime = tscheduleBean.getTuetime();
		        } else if (tsday.equals("wed")) {
		            tstime = tscheduleBean.getWedtime();
		        } else if (tsday.equals("thu")) {
		            tstime = tscheduleBean.getThutime();
		        } else if (tsday.equals("fri")) {
		            tstime = tscheduleBean.getFritime();
		        } else if (tsday.equals("sat")) {
		            tstime = tscheduleBean.getSattime();
		        }

		        tb.setTstime(tstime);
		    	
		        int cnt = tscheduleDao.updateTschedule(tb);
		        if (cnt != -1) {
		            System.out.println("수정 성공");
		        } else {
		            System.out.println("수정 실패");
		        }
		    } else { // 요일 일치하지 않음 - delete
		    	TscheduleBean tsb = new TscheduleBean();
		    	tsb.setTid(tid);
		    	tsb.setTsday(tb.getTsday());
		    	tsb.setTspeople(tspeople);
		    	System.out.println("delete-요일:"+tb.getTsday());
		        int cnt = tscheduleDao.deleteTschedule(tsb);
		        if (cnt != -1) {
		            System.out.println("삭제 성공");
		            return gotoPage;
		        } else {
		            System.out.println("삭제 실패");
		            return getPage;
		        }
		    }
		}

		// selectedDays에만 있는 값은 insert
		for (String selectedDay : selectedDays) {
		    boolean isExisting = false;
		    for (TscheduleBean tb : tsList) {
		        if (selectedDay.equals(tb.getTsday())) {
		            isExisting = true;
		            break;
		        }
		    }
		    if (!isExisting) { // insert
		        tscheduleBean.setTid(tid);
		        tscheduleBean.setTsday(selectedDay);
		        tscheduleBean.setTstype(tstype);
		        tscheduleBean.setTspeople(tspeople);

		        if (tsdateList.isEmpty()) {
		            System.out.println("값이 누락되었습니다.");
		            tscheduleBean.setTsdate("null");
		        } else {
		            // 쉬는날이 여러날일 경우 한번에 담아 가져가기
		            String tsdate = "";

		            if (tsdateList.size() > 1) {
		                for (int i = 0; i < tsdateList.size(); i++) {
		                    tsdate += tsdateList.get(i);
		                    if (i < tsdateList.size() - 1) {
		                        tsdate += ",";
		                    }
		                }
		            }
		            tscheduleBean.setTsdate(tsdate);
		        }
		        // 요일에 따른 시간 설정
		        if (selectedDay.equals("sun")) {
		            tscheduleBean.setTstime(tscheduleBean.getSuntime());
		        } else if (selectedDay.equals("mon")) {
		            tscheduleBean.setTstime(tscheduleBean.getMontime());
		        } else if (selectedDay.equals("tue")) {
		            tscheduleBean.setTstime(tscheduleBean.getTuetime());
		        } else if (selectedDay.equals("wed")) {
		            tscheduleBean.setTstime(tscheduleBean.getWedtime());
		        } else if (selectedDay.equals("thu")) {
		            tscheduleBean.setTstime(tscheduleBean.getThutime());
		        } else if (selectedDay.equals("fri")) {
		            tscheduleBean.setTstime(tscheduleBean.getFritime());
		        } else if (selectedDay.equals("sat")) {
		            tscheduleBean.setTstime(tscheduleBean.getSattime());
		        }
		        System.out.println("insert-요일:"+selectedDay);
		        int cnt = tscheduleDao.insertTschedule(tscheduleBean);
		        if (cnt != -1) {
		            System.out.println("추가 성공");
		            return gotoPage;
		        } else {
		            System.out.println("추가 실패");
		            return getPage;
		        }
		    }//if
		}//for
			
		return null;
	}
}
