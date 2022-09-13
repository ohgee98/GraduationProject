<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
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
                  <a href="../main.jsp" class="logo"><strong>KOE</strong> <span>코드 유사도 검사 프로그램</span></a>
               </header>

            <!-- Main -->
               <div id="main" class="alt">

            <!-- Box -->
               <h3 style="margin-left:20px;">탐욕법(Greedy) > 체육복 (Java)</h3>
                  <div class="left">
                  <div id="pc">
<strong id="probtitle">문제 설명</strong>
<div id="probcontent">
점심시간에 도둑이 들어, 일부 학생이 체육복을 도난당했습니다. 다행히 여벌 체육복이 있는 학생이 이들에게 체육복을 빌려주려 합니다. 학생들의 번호는 체격 순으로 매겨져 있어, 바로 앞번호의 학생이나 바로 뒷번호의 학생에게만 체육복을 빌려줄 수 있습니다. 예를 들어, 4번 학생은 3번 학생이나 5번 학생에게만 체육복을 빌려줄 수 있습니다. 체육복이 없으면 수업을 들을 수 없기 때문에 체육복을 적절히 빌려 최대한 많은 학생이 체육수업을 들어야 합니다.

전체 학생의 수 n, 체육복을 도난당한 학생들의 번호가 담긴 배열 lost, 여벌의 체육복을 가져온 학생들의 번호가 담긴 배열 reserve가 매개변수로 주어질 때, 체육수업을 들을 수 있는 학생의 최댓값을 return 하도록 solution 함수를 작성해주세요.
</div>
                     
<strong id="probtitle">제한사항</strong>
<div id="probcontent">
<li>전체 학생의 수는 2명 이상 30명 이하입니다.</li>
<li>체육복을 도난당한 학생의 수는 1명 이상 n명 이하이고 중복되는 번호는 없습니다.</li>
<li>여벌의 체육복을 가져온 학생의 수는 1명 이상 n명 이하이고 중복되는 번호는 없습니다.</li>
<li>여벌 체육복이 있는 학생만 다른 학생에게 체육복을 빌려줄 수 있습니다.</li>
<li>여벌 체육복을 가져온 학생이 체육복을 도난당했을 수 있습니다. 이때 이 학생은 체육복을 하나만 도난당했다고 가정하며, 남은 체육복이 하나이기에 다른 학생에게는 체육복을 빌려줄 수 없습니다.</li>
</div>
                     
<strong id="probtitle">입출력 예</strong>
<div id="probcontent">
<table class="samT">
   <thead>
         <tr>
         	<th>n</th>
            <th>lost</th>
            <th>reserve</th>
            <th>return</th>
         </tr>
   </thead>
   <tbody>
         <tr>
         	<td>5</td>
            <td>[2, 4]</td>
            <td>[1, 3, 5]</td>
            <td>5</td>
         </tr>
          <tr>
          	<td>5</td>
            <td>[2, 4]</td>
            <td>[3]</td>
            <td>4</td>
         </tr>
         <tr>
          	<td>3</td>
            <td>[3]</td>
            <td>[1]</td>
            <td>2</td>
         </tr>
   </tbody>
</table>      
</div>

<strong id="probtitle">입출력 예 설명</strong>
<div id="probcontent">
<strong>예제 #1</strong>

1번 학생이 2번 학생에게 체육복을 빌려주고, 3번 학생이나 5번 학생이 4번 학생에게 체육복을 빌려주면 학생 5명이 체육수업을 들을 수 있습니다.

<strong>예제 #2</strong>

3번 학생이 2번 학생이나 4번 학생에게 체육복을 빌려주면 학생 4명이 체육수업을 들을 수 있습니다.
</div>
                     </div>
                  </div>
                  
                  <div class="right">
                     <br/>
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
	 	  var algName = "탐욕법(Greedy)"
	       var probName = "체육복"
	       
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