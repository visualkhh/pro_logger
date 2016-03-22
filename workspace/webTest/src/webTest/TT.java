package webTest;

import java.util.LinkedHashMap;

public class TT extends LinkedHashMap<String, String>{
	private String name;
	private String age;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	@Override
	public String toString() {
		return "TT [name=" + name + ", age=" + age + "]"+super.toString();
	}
	

}
