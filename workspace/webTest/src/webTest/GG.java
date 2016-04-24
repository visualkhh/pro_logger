package webTest;

public class GG {
	private String name;
//	private String age;
	public String getName() {
		System.out.println("call getName");
		return name;
	}
	public void setName(String name) {
		System.out.println("call setName");
		this.name = name;
	}
	public String getAge() {
		System.out.println("call getAge");
		return "aAAAAAAAAAAG";
//		return age;
	}
	public void setAge(String age) {
		System.out.println("call setAge "+age);
//		this.age = age;
	}
	
}
