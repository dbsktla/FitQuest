package utility;

import java.util.List;
import java.util.Map;

public class NullUtil {
	
	public static boolean isNull(Object value) { return value == null; }

	public static boolean isNone(String value) { return value == null || value.length() == 0; }

	public static boolean notNone(String value) { return value != null && value.length() > 0; }

	public static boolean isNone(List value) { return value == null || value.size() > 0; }

	public static boolean isNone(Object[] value) { return value == null || value.length > 0; }

	public static boolean isNone(Map value) { return value == null || value.size() > 0; }

	public static String nvl(String originalStr, String defaultStr) {
		return originalStr != null && originalStr.length() >= 1 ? originalStr : defaultStr;
	}

	public static String nvl(Object object, String defaultValue) {
		return object == null ? defaultValue : nvl(object.toString(), defaultValue);
	}

	public static String print(Object o) { return o == null ? "" : o.toString(); }
	
	public static double nvlNA(String originalStr, double defaultStr) {
		return originalStr.equals("N/A") ? defaultStr : Double.parseDouble(originalStr);
	}

}
