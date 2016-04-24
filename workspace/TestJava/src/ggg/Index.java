package ggg;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.regex.Pattern;

import com.sun.xml.internal.ws.util.StringUtils;

import khh.db.terminal.DBTerminal;
import khh.reflection.ReflectionUtil;
import khh.string.util.StringUtil;
interface wowI{
}

class wow implements wowI{
	
}

interface gg{
	public void wow();
}
public class Index implements gg{
	
	public void gogo(String a, Integer b){
		System.out.println(a+"  ,  "+b);
	}
	@Override
	public void wow() {
	}
	
	public void a(wowI w){
		System.out.println("+   >>   "+w);
	}
	public void b(Object...a){
		System.out.println(a.length);
	}
	
	
	public static void main(String[] args) throws SecurityException, NoSuchMethodException, IllegalArgumentException, IllegalAccessException, InvocationTargetException, InstantiationException {
//		String regex = "^.*(hello|world).do";
//		String inputText = "http://naver.com/hello.do";
//		boolean sss = StringUtil.isMatches(inputText, regex);
//		System.out.println(sss);
//		boolean s = Pattern.matches(regex, inputText);
//		System.out.println(s);
		
		
//		Object[] g ={"asd", new Integer(1)};
//		ReflectionUtil.executeMethod(new Index(),"a", new Object[]{new Object()});
		DBTerminal i = new DBTerminal(null);
//		Index i = new Index();
        Class klass =i.getClass();
//        Method setSalaryMethod =  klass.getMethod("a", wowI.class);
//        Method sSalaryMethod =  klass.getDeclaredMethod("a", wowI.class);
//        System.outet.println(setSalaryMethod);
        
//        String executeMethodName="a";
        
        
//        Method setSalaryMethod =  klass.getMethod("a", wowI.class);
//        setSalaryMethod.invoke(object, parameters);
        
//        String exeucteMethodName = "a";
//        Class[] executeParameterClass = {wow.class};
//        Object[] executeParameterObject = {new wow()};
//        Method setSalaryMethod =  klass.getMethod(exeucteMethodName, executeParameterClass);
//        setSalaryMethod.invoke(klass, executeParameterObject);
        
        Method[] method = klass.getMethods();
        for (int j = 0; j < method.length; j++) {
			System.out.println(method[j].getName()+" "+method[j].getParameterCount());
			Class[] mclass = method[j].getParameterTypes();
			for (int k = 0; k < mclass.length; k++) {
				System.out.println("\t"+mclass[k]);
			}
//			for (int k = 0; k < mclass.length; k++) {
//				
//			}
		}
        
        
        //for( Method method : klass.getDeclaredMethods() )
      //  	method.getParameterCount();
       // 	System.out.println(method.getName());
        //System.out.println(method.ge);
//        	System.out.println(method.getName());
//        	Class[] c = method.getParameterTypes();
//            if( method.getName().equals("getInt") && method.getParameterTypes().length == 0 ){
////                theGetInt = method;
////                break OUTER;
//            }
        
        
      //return  setSalaryMethod.invoke(object, parameters);
		
	}



	
}
