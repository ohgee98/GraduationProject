<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="forRefine.refineForSim" %>
<% request.setCharacterEncoding("utf-8");%>
<%
	String big = request.getParameter("algN");
	String small = request.getParameter("probN");
	String url = request.getParameter("urlN");
	
	String usebig = refineForSim.replaceStringforUse(big);
	String usesmall = refineForSim.replaceStringforUse(small);
%>
<!DOCTYPE html>
<html>
<head>
<!-- K번째수 Java -->
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="../assets/css/main.css" />
<noscript><link rel="stylesheet" href="../assets/css/noscript.css" /></noscript>
<script src="../plugin/codemirror/lib/codemirror.js"></script>
<script src="../plugin/codemirror/mode/clike/clike.js"></script>
<script src="../plugin/codemirror/addon/edit/closetag.js"></script>
<link rel="stylesheet" href="../plugin/codemirror/lib/codemirror.css"/>
<link rel="stylesheet" href="../plugin/codemirror/theme/dracula.css"/>
<link rel="stylesheet" href="../assets/css/prob.css"/>

<title>KOE 코드 유사도 검사 프로그램</title>
</head>

<body class="is-preload">

      <!-- Wrapper -->
         <div id="wrapper">

            <!-- Header -->
               <header id="header">
                  <a href="../realMain.jsp" class="logo"><strong>KOE</strong> <span>코드 유사도 검사 프로그램</span></a>
               </header>

            <!-- Main -->
               <div id="main" class="alt">

            <!-- Box -->
               <h3 style="margin-left:20px;"><%=big%>  >  <%=small%> (Java)</h3>
				<div>
					<br/><br/>
                  	<div style="text-align: center;"><p>문제 링크</p><a href="<%=url%>" target="_blank"><%=url%></a></div>

                     <div style="text-align:center;" class="lang">
                        <p>코드를 입력해 주세요.</p>
                     </div>
                     <div class="text">
                     <textarea id="editor" class="codemirror-textarea"></textarea>
                     </div>
                     
                     <br/>
                     <div style="text-align:center;" class="in">
                        <button onclick="submitCode()">submit</button>
                     </div>
                     <br/><br/>
                 </div>
                  
         </div>
   
   
   <!-- Script 영역 -->   

   <script>
      var editor = CodeMirror.fromTextArea
      (document.getElementById('editor'),{
         mode : "text/x-java",
         theme : "dracula",
         lineNumbers : true,
         lineWrapping : true,
         autoCloseTags : true,
      });
      
      editor.setSize(null,400);
   </script>
   
   <script>
      function submitCode(){
    	  var text = editor.getValue();
    	  var algName = "<%=usebig%>";
          var probName = "<%=usesmall%>";
          $.ajax({
              type:"POST",
              url:"../similarity/SimCheckProb.jsp",
              dataType:"text json",
              data:{"inputCode":text,
            	  	"algPath":algName,
                   	"probPath":probName},
              success:function(res){
                 var temp=res;
                 
                 if(temp[0].flag == "true"){
                    alert("유사도 결과 : "+temp[0].SimResult+"%");
                 }else{
                	 alert("copy 의심 블로그 주소 :"+temp[0].SimCode);
                 }
              },
              error:function(request,status,error){
                 alert("similarity result error \n code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
           }); 
      }
   </script>
   
   <script src="../assets/js/jquery.min.js"></script>
   <script src="../assets/js/jquery.scrolly.min.js"></script>
   <script src="../assets/js/jquery.scrollex.min.js"></script>
   <script src="../assets/js/browser.min.js"></script>
   <script src="../assets/js/breakpoints.min.js"></script>
   <script src="../assets/js/util.js"></script>
   <script src="../assets/js/main.js"></script>
   
</body>
</html>