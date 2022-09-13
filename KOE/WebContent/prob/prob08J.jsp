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
               <h3 style="margin-left:20px;">깊이/너비 우선 탐색(DFS/BFS) > 타겟 넘버 (Java)</h3>
                  <div class="left">
                  <div id="pc">
<strong id="probtitle">문제 설명</strong>
<div id="probcontent">
n개의 음이 아닌 정수가 있습니다. 이 수를 적절히 더하거나 빼서 타겟 넘버를 만들려고 합니다. 예를 들어 [1, 1, 1, 1, 1]로 숫자 3을 만들려면 다음 다섯 방법을 쓸 수 있습니다.

<div id="probBox">
	-1+1+1+1+1 = 3
	+1-1+1+1+1 = 3
	+1+1-1+1+1 = 3
	+1+1+1-1+1 = 3
	+1+1+1+1-1 = 3

</div>

사용할 수 있는 숫자가 담긴 배열 numbers, 타겟 넘버 target이 매개변수로 주어질 때 숫자를 적절히 더하고 빼서 타겟 넘버를 만드는 방법의 수를 return 하도록 solution 함수를 작성해주세요.
</div>
                     
<strong id="probtitle">제한사항</strong>
<div id="probcontent">
<li>주어지는 숫자의 개수는 2개 이상 20개 이하입니다.</li>
<li>각 숫자는 1 이상 50 이하인 자연수입니다.</li>
<li>타겟 넘버는 1 이상 1000 이하인 자연수입니다.</li>
</div>
                     
<strong id="probtitle">입출력 예</strong>
<div id="probcontent">
<table class="samT">
   <thead>
         <tr>
         	<th>numbers</th>
            <th>target</th>
            <th>return</th>
         </tr>
   </thead>
   <tbody>
         <tr>
         	<td>[1, 1, 1, 1, 1]</td>
            <td>3</td>
            <td>5</td>
         </tr>
   </tbody>
</table>      
</div>

<strong id="probtitle">입출력 예 설명</strong>
<div id="probcontent">
문제에 나온 예와 같습니다.

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
	 	  var algName = "깊이_너비+우선+탐색(DFS_BFS)"
	       var probName = "타겟+넘버"
	       
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