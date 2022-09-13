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
               <h3 style="margin-left:20px;">완전탐색 > 모의고사 (Java)</h3>
                  <div class="left">
                  <div id="pc">
<strong id="probtitle">문제 설명</strong>
<div id="probcontent">
수포자는 수학을 포기한 사람의 준말입니다. 수포자 삼인방은 모의고사에 수학 문제를 전부 찍으려 합니다. 수포자는 1번 문제부터 마지막 문제까지 다음과 같이 찍습니다.

1번 수포자가 찍는 방식: 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, ...
2번 수포자가 찍는 방식: 2, 1, 2, 3, 2, 4, 2, 5, 2, 1, 2, 3, 2, 4, 2, 5, ...
3번 수포자가 찍는 방식: 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, ...

1번 문제부터 마지막 문제까지의 정답이 순서대로 들은 배열 answers가 주어졌을 때, 가장 많은 문제를 맞힌 사람이 누구인지 배열에 담아 return 하도록 solution 함수를 작성해주세요.
</div>
                     
<strong id="probtitle">제한사항</strong>
<div id="probcontent">
<li>시험은 최대 10,000 문제로 구성되어있습니다.</li>
<li>문제의 정답은 1, 2, 3, 4, 5중 하나입니다.</li>
<li>가장 높은 점수를 받은 사람이 여럿일 경우, return하는 값을 오름차순 정렬해주세요.</li>
</div>
                     
<strong id="probtitle">입출력 예</strong>
<div id="probcontent">
<table class="samT">
   <thead>
         <tr>
            <th>answers</th>
            <th>return</th>
         </tr>
   </thead>
   <tbody>
         <tr>
            <td>[1,2,3,4,5]</td>
            <td>[1]</td>
         </tr>
          <tr>
            <td>[1,3,2,4,2]</td>
            <td>[1,2,3]</td>
         </tr>
   </tbody>
</table>      
</div>

<strong id="probtitle">입출력 예 설명</strong>
<div id="probcontent">
<strong>입출력 예 #1</strong>

<li>수포자 1은 모든 문제를 맞혔습니다.</li>
<li>수포자 2는 모든 문제를 틀렸습니다.</li>
<li>수포자 3은 모든 문제를 틀렸습니다.</li>

따라서 가장 문제를 많이 맞힌 사람은 수포자 1입니다.

<strong>입출력 예 #2</strong>

<li>모든 사람이 2문제씩을 맞췄습니다.</li>
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
	 	  var algName = "완전탐색"
	       var probName = "모의고사"
	       
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