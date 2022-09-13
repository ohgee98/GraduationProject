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
               <h3 style="margin-left:20px;">그래프 > 가장 먼 노드 (Java)</h3>
                  <div class="left">
                  <div id="pc">
<strong id="probtitle">문제 설명</strong>
<div id="probcontent">
n개의 노드가 있는 그래프가 있습니다. 각 노드는 1부터 n까지 번호가 적혀있습니다. 1번 노드에서 가장 멀리 떨어진 노드의 갯수를 구하려고 합니다. 가장 멀리 떨어진 노드란 최단경로로 이동했을 때 간선의 개수가 가장 많은 노드들을 의미합니다.

노드의 개수 n, 간선에 대한 정보가 담긴 2차원 배열 vertex가 매개변수로 주어질 때, 1번 노드로부터 가장 멀리 떨어진 노드가 몇 개인지를 return 하도록 solution 함수를 작성해주세요.
</div>
                     
<strong id="probtitle">제한사항</strong>
<div id="probcontent">
<li>노드의 개수 n은 2 이상 20,000 이하입니다.</li>
<li>간선은 양방향이며 총 1개 이상 50,000개 이하의 간선이 있습니다.</li>
<li>vertex 배열 각 행 [a, b]는 a번 노드와 b번 노드 사이에 간선이 있다는 의미입니다.</li>
</div>
                     
<strong id="probtitle">입출력 예</strong>
<div id="probcontent">
<table class="samT">
   <thead>
         <tr>
         	<th>n</th>
            <th>vertex</th>
            <th>return</th>
         </tr>
   </thead>
   <tbody>
         <tr>
         	<td>6</td>
            <td>[[3, 6], [4, 3], [3, 2], [1, 3], [1, 2], [2, 4], [5, 2]]</td>
            <td>3</td>
         </tr>
   </tbody>
</table>      
</div>

<strong id="probtitle">입출력 예 설명</strong>
<div id="probcontent">
<strong>입출력 예 #1</strong>

예제의 그래프를 표현하면 아래 그림과 같고, 1번 노드에서 가장 멀리 떨어진 노드는 4,5,6번 노드입니다.

<img src="https://grepp-programmers.s3.amazonaws.com/files/ybm/fadbae38bb/dec85ab5-0273-47b3-ba73-fc0b5f6be28a.png">
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
	 	  var algName = "그래프"
	       var probName = "가장+먼+노드"
	       
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