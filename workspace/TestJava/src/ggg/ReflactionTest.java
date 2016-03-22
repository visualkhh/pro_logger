package ggg;

abstract  class A{
	
	String name= "na";
	
	public void printName(){
		System.out.println(name);
	}
	
	
	
	
}

class B extends A {
	
}


public class ReflactionTest {

	public static void main(String[] args) {
		new B().printName();
		
	}
	
	
	
}
