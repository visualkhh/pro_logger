package ggg;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import khh.conversion.util.ConversionUtil;
import khh.string.util.StringUtil;

public class Test {
	public static void main(String[] args) throws Exception {
		
		HashMap<String,String> a = new HashMap<>(); 
		a.put("a", "aa");
		a.put("b", "ab");
		
		HashMap<String,String> b = new HashMap<>(); 
		b.put("a", "ba");
		
		a.putAll(b);
		
		System.out.println(a);
		
		Map c = ConversionUtil.mergeToNewMap(a,b);
		Iterator iter = c.keySet().iterator();
		while(iter.hasNext()){
	      String key =(String) iter.next();
	      System.out.println(a.get(key));
		}
	}
}
