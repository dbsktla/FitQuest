package reservation.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import product.model.ProductBean;
import product.model.ProductDao;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;

@Controller
public class TrainerScheduleInsertController {
	private final String command = "/tScheduleInsert.rv";
	private final String getPage = "trainerScheduleInsert";
	private final String gotoPage = "redirect:/trainerCalendar.rv";

	@Autowired
	TscheduleDao tscheduleDao;
	
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(HttpSession session,Model model) {
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<ProductBean> pList = productDao.getProductListById(tid);
		
		//중복된 운동인원(개월수에 따라 분리됨) 하나로 합치기
		Set<Integer> uniqueNumbers = new HashSet<Integer>();
        for (ProductBean pb : pList) {
            uniqueNumbers.add(pb.getPeople());
        }
        Integer[] peopleArr = uniqueNumbers.toArray(new Integer[0]);
        
        //중복된 개인/단체 유형 하나로 합치기
        Set<String> uniqueTypes = new HashSet<String>();
        for (ProductBean pb : pList) {
            uniqueTypes.add(pb.getPtype());
        }
        String[] typeArr = uniqueTypes.toArray(new String[0]);
        
        for(String type : typeArr) {
        	System.out.println("합쳐졌나 체크:"+type);
        }
        //이미 등록한 유형은 제외시키고 가져가기
        List<TscheduleBean> tsList = tscheduleDao.findTschedule(tid);
        
        //배열에서 tsList에 있는 값과 일치하는 항목 삭제(인원수,유형)하고 등록된 시간 묶어서 가져가기
        if(!tsList.isEmpty()) {
        	//중복된 tstype과 tspeople을 하나로 합친 배열
        	Set<String> uniqueTstypes = new HashSet<String>();
        	Set<Integer> uniqueTspeople = new HashSet<Integer>();
        	
        	for (TscheduleBean tsb : tsList) {
        		uniqueTstypes.add(tsb.getTstype());
        		uniqueTspeople.add(tsb.getTspeople());
        	}
        	
        	//배열에서 tsList에 있는 값과 일치하는 항목 삭제
        	List<String> typeList = new ArrayList<String>(Arrays.asList(typeArr));
        	List<Integer> peopleList = new ArrayList<Integer>(Arrays.asList(peopleArr));
        	
        	for (String tstype : uniqueTstypes) {
        		typeList.remove(tstype);
        	}
        	for (Integer tspeople : uniqueTspeople) {
        		peopleList.remove(tspeople);
        	}
        	//최종적으로 제외된 값들이 들어있는 배열
        	String[] typeArray = typeList.toArray(new String[0]);
        	Integer[] peopleArray = peopleList.toArray(new Integer[0]);
        	
        	//그룹에 해당하는 값이 남아있다면 '그룹' 추가
        	for(int i=0;i<peopleArray.length;i++) {
        		System.out.println("남은 인원:"+peopleArray[i]);
        		if(peopleArray[i] != 1) {
        			String[] newTypeArray = new String[typeArray.length + 1];
        	        System.arraycopy(typeArray, 0, newTypeArray, 0, typeArray.length);
        	        newTypeArray[typeArray.length] = "그룹";
        	        typeArray = newTypeArray;
        		}
        	}
        	//중복값 제거
        	Set<String> uniqueType = new HashSet<String>(Arrays.asList(typeArray));
        	String[] combinedTypeArray = uniqueType.toArray(new String[0]);
        	
        	//이미 등록된 시간 묶어서 가져가기(제외시켜야 함)
        	String[] dayArr = {"sun", "mon", "tue", "wed", "thu", "fri", "sat"};
        	StringBuilder[][] timeBuilders = new StringBuilder[dayArr.length][];

        	for (int i = 0; i < dayArr.length; i++) {
        	    timeBuilders[i] = new StringBuilder[tsList.size()];
        	}

        	// tsList의 레코드를 요일별로 timeBuilders에 저장
        	for (int i = 0; i < tsList.size(); i++) {
        	    TscheduleBean tsb = tsList.get(i);
        	    String tsday = tsb.getTsday();
        	    int dayIndex = Arrays.asList(dayArr).indexOf(tsday);

        	    if (dayIndex >= 0) {
        	        if (timeBuilders[dayIndex][i] == null) {
        	            timeBuilders[dayIndex][i] = new StringBuilder();
        	        }
        	        timeBuilders[dayIndex][i].append(tsb.getTstime()).append(",");
        	    }
        	}

        	TscheduleBean timeBean = new TscheduleBean();
        	// 각 요일별 StringBuilder 값을 하나의 문자열로 합치고 변수에 저장
        	for (int i = 0; i < dayArr.length; i++) {
        	    StringBuilder combinedTime = new StringBuilder();
        	    for (int j = 0; j < timeBuilders[i].length; j++) {
        	        if (timeBuilders[i][j] != null) {
        	            combinedTime.append(timeBuilders[i][j].toString());
        	        }
        	    }
        	    
        	    // 마지막 쉼표 제거
        	    if (combinedTime.length() > 0) {
        	        combinedTime.deleteCharAt(combinedTime.length() - 1);
        	    }

        	    // 요일에 따라 변수 설정
        	    if (dayArr[i].equals("sun")) {
        	    	timeBean.setSuntime(combinedTime.toString());
        	    }else if (dayArr[i].equals("mon")) {
        	    	timeBean.setMontime(combinedTime.toString());
        	    }else if (dayArr[i].equals("tue")) {
        	    	timeBean.setTuetime(combinedTime.toString());
        	    }else if (dayArr[i].equals("wed")) {
        	    	timeBean.setWedtime(combinedTime.toString());
        	    }else if (dayArr[i].equals("thu")) {
        	    	timeBean.setThutime(combinedTime.toString());
        	    }else if (dayArr[i].equals("fri")) {
        	    	timeBean.setFritime(combinedTime.toString());
        	    }else if (dayArr[i].equals("sat")) {
        	    	timeBean.setSattime(combinedTime.toString());
        	    }
        	}
        	System.out.println("합친거 테스트 sun:"+timeBean.getSuntime());
        	System.out.println("합친거 테스트 mon:"+timeBean.getMontime());
        	System.out.println("합친거 테스트 tue:"+timeBean.getTuetime());
        	System.out.println("합친거 테스트 wed:"+timeBean.getWedtime());
        	System.out.println("합친거 테스트 thu:"+timeBean.getThutime());
        	System.out.println("합친거 테스트 fri:"+timeBean.getFritime());
        	System.out.println("합친거 테스트 sat:"+timeBean.getSattime());
        	
        	//최종 인원,유형 갖고가기
        	model.addAttribute("peopleArray",peopleArray);
        	model.addAttribute("typeArray",combinedTypeArray);
        	
        	//요일별 선점된 시간대 가져가기
        	model.addAttribute("existSun",timeBean.getSuntime());
        	model.addAttribute("existMon",timeBean.getMontime());
        	model.addAttribute("existTue",timeBean.getTuetime());
        	model.addAttribute("existWed",timeBean.getWedtime());
        	model.addAttribute("existThu",timeBean.getThutime());
        	model.addAttribute("existFri",timeBean.getFritime());
        	model.addAttribute("existSat",timeBean.getSattime());
        }else {
        	model.addAttribute("peopleArray",peopleArr);
        	model.addAttribute("typeArray",typeArr);
        }
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public String doAction(TscheduleBean tscheduleBean, HttpServletRequest request, 
			Model model, HttpSession session, 
			@RequestParam("tsdate") List<String> tsdateList,
			@RequestParam("selectedDays") String[] selectedDays 
			) {
			
		System.out.println("타입"+tscheduleBean.getTstype());
		System.out.println("인원수"+tscheduleBean.getTspeople());
		System.out.println("요일"+tscheduleBean.getTsday());
		System.out.println("쉬는날"+tscheduleBean.getTsdate());
		System.out.println("일"+tscheduleBean.getSuntime());
		System.out.println("월"+tscheduleBean.getMontime());
		System.out.println("화"+tscheduleBean.getTuetime());
		System.out.println("수"+tscheduleBean.getWedtime());
		System.out.println("목"+tscheduleBean.getThutime());
		System.out.println("금"+tscheduleBean.getFritime());
		System.out.println("토"+tscheduleBean.getSattime());
		
		for(int i=0;i<selectedDays.length;i++) {
			System.out.println("선택한 요일: "+selectedDays[i]);
		}
		
		
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		tscheduleBean.setTid(tid);
		
		if (tsdateList.isEmpty()) {
		    System.out.println("값이 누락되었습니다.");
		    tscheduleBean.setTsdate("null");
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
			tscheduleBean.setTsdate(tsdate);
		}
		
		//요일 개수만큼 tsday에 요일 집어넣고 tstime에 해당 요일의 시간대 집어넣기
		int cnt = 0;
		for(int i=0;i<selectedDays.length;i++) {
			System.out.println("들어오나 체크 요일:"+selectedDays[i]);
			tscheduleBean.setTsday(selectedDays[i]); //요일 저장
			
			if(selectedDays[i].equals("sun")) {
				tscheduleBean.setTstime(tscheduleBean.getSuntime()); //요일에 따른 시간 저장
			}else if(selectedDays[i].equals("mon")) {
				tscheduleBean.setTstime(tscheduleBean.getMontime()); 
			}else if(selectedDays[i].equals("tue")) {
				tscheduleBean.setTstime(tscheduleBean.getTuetime());
			}else if(selectedDays[i].equals("wed")) {
				tscheduleBean.setTstime(tscheduleBean.getWedtime()); 
			}else if(selectedDays[i].equals("thu")) {
				tscheduleBean.setTstime(tscheduleBean.getThutime()); 
			}else if(selectedDays[i].equals("fri")) {
				tscheduleBean.setTstime(tscheduleBean.getFritime());
			}else if(selectedDays[i].equals("sat")) {
				tscheduleBean.setTstime(tscheduleBean.getSattime());
			}
			System.out.println("요일 테스트: "+tscheduleBean.getTsday());
			System.out.println("시간 테스트: "+tscheduleBean.getTstime());
			System.out.println("쉬는날 테스트: "+tscheduleBean.getTsdate());
			
			cnt = tscheduleDao.insertTschedule(tscheduleBean);
			
		}
	
		
		
		if(cnt != -1) {
			return gotoPage;
		}else {
			return getPage;
		}
			
		
	}
}
