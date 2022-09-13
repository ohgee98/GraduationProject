<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="forRefine.refineForSim" %>

<% request.setCharacterEncoding("UTF-8"); %>
<%

	String path="C://Users//hazur//KOE_project//KOE_project//crawlerURL.txt";
		
	JSONArray arr = new JSONArray();
	
		try {
			File readFile = new File(path);
			FileReader filereader = new FileReader(readFile);
			BufferedReader buf  =  new BufferedReader(new InputStreamReader(new FileInputStream(readFile),"utf-8"));
			//BufferedReader buf = new BufferedReader(filereader);
			String line="";
			
			while((line=buf.readLine())!=null) {
				String[] temp = line.split("#");
				
				JSONObject obj = new JSONObject();
				
				obj.put("algName", refineForSim.replaceString(temp[0]));
				obj.put("probNum", refineForSim.replaceString(temp[1]));
				obj.put("probURL", temp[2].trim());

				arr.add(obj);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
	out.print(arr);
	
%>