package com.sbs.lhh.hp.util;

import java.math.BigInteger;
import java.util.Map;

public class Util {
	
	// 키 변환
	public static void changeMapKey(Map<String, Object> param, String oldKey, String newKey) {
		Object value = param.get(oldKey);
		param.remove(oldKey);
		param.put(newKey, value);
	}
	
	// String 가져오기
	public static String getAsStr(Object object) {
		if (object == null) {
			return "";
		}

		return object.toString();
	}
	
	// int 가져오기
	public static int getAsInt(Object object) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof Long) {
			return (int) object;
		} else if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return -1;
	}
}
