<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="forRefine.refineForSim" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="info.debatty.java.stringsimilarity.JaroWinkler" %>

<% request.setCharacterEncoding("UTF-8"); %>
<%

	String code = request.getParameter("inputCode");
	String tempPath1 = request.getParameter("algPath");
	String tempPath2 = request.getParameter("probPath");
	
	//비교되는 input 코드 정제 (all white space remove)
	String sb1 = code.replaceAll("(?:/\\*(?:[^*]|(?:\\*+[^*/]))*\\*+/)|(?://.*)","");
	sb1 = sb1.replaceAll("(\r\n|\r|\n|\n\r|\\p{Z}|\\t)", "");

	JaroWinkler jaro = new JaroWinkler();
	String path="C://Users//hazur//KOE_project//KOE_project//programmers//"+tempPath1+"//"+tempPath2;

	//System.out.println("설정 경로: "+path);
	
	String simPath="C://Users//hazur//KOE_project//KOE_project//meta//"+tempPath1+"//"+tempPath2+"//calSim.txt";
	//유사도 기준 가져올 파일 경로
	
	double compareSim=0; //기준이 될 유사도
		
		try {
			File readFile = new File(simPath);
			FileReader filereader = new FileReader(readFile);
			BufferedReader buf = new BufferedReader(filereader);
			String line="";
			while((line=buf.readLine())!=null) {
				String[] temp = line.split(":");
				compareSim = Double.parseDouble(temp[1].trim());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	System.out.println("기준 되는 유사도 : "+compareSim);
	
	File parentFolder = new File(path);
	Map<String, StringBuilder> map = new LinkedHashMap<>();
	// id, 소스내용

	List<String> except = new ArrayList<String>();
	except.add(" ");
	
	for (File file : parentFolder.listFiles()) {
		try {
			map.put(file.getName().replace(".txt", ""), refineForSim.readCodeWithRemove(file, except));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	Map<String, List<Double>> distanceMap = new LinkedHashMap<>();

	int num = map.size();
	String checkId="";//유사도 높은 코드 탐지용
	boolean flag=true;
	double total=0; //유사도 검사 후 다 더하는 값
	double avg = 0; //유사도 평균 값
	double result=0; //최종 유사도 값(소수점 둘째 자리까지)
	List<String> studentList = new LinkedList<>(map.keySet());
	studentList.sort(String.CASE_INSENSITIVE_ORDER);

	JSONArray arr=new JSONArray();
	
	for(String id : studentList) {
		
		StringBuilder sb2 = map.get(id);
		//System.out.println("기준 코드 : "+sb1);
		//System.out.println("비교 코드: "+sb2.toString());
		double d = 1 - jaro.distance(sb1, sb2.toString());
		//System.out.println("<< d의 결과 : "+d+ "vs 기준 유사도 결과 : "+comapereSim+" >>");
		
		if((d*100)>=compareSim+5){
			//System.out.println("유사도 기준보다 훨씬 높음!!!");
			flag = false;
			checkId=id;
			break;
		}
		
		total += d;
	}
	
	JSONObject obj = new JSONObject();
	
	if(flag){
		avg = total/num;
		result = Double.parseDouble(String.format("%.2f",avg*100));
		System.out.println("유사도 전체 결과 : "+result);
		obj.put("flag","true");
		obj.put("SimResult",result);
		obj.put("SimCode","");
	}else{
		System.out.println("유사도 높은 결과 탐지");
		obj.put("flag","flase");
		obj.put("SimResult","");
		obj.put("SimCode",refineForSim.outputSimCode(checkId).toString());
	}

	arr.add(obj);
	out.print(arr);
	
%>