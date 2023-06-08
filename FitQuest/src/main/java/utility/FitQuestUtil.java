package utility;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

public class FitQuestUtil {
	
	public static String getValueFromProjectProperties(String key) {
		// /config/project.properties 파일이 있는 경로를 찾음
		String path = Thread.currentThread().getContextClassLoader().getResource("/config/project.properties").getPath();
		
		// 찾았을때 해당 키에 대한 값을 넣는 변수
		String propertiesValue = null;
		
		try {
			// 경로에 있는 파일의 내용을 한줄씩 읽어서 list타입의 변수에 저장
			List<String> projectProperties = FileUtils.readLines(new File(path));
			// 반복자. 리스트 순회에 사용
			Iterator i$ = projectProperties.iterator();
			
			while(i$.hasNext()) {
				String property = (String)i$.next();
				if (NullUtil.notNone(property) && property.startsWith(key)) {
					propertiesValue = StringUtils.substringAfter(property, "=");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return propertiesValue;
	}

}
