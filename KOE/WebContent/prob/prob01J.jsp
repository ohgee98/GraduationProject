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
               <h3 style="margin-left:20px;">해시 > 완주하지 못한 선수 (Java)</h3>
                  <div class="left">
                  <div id="pc">
<strong id="probtitle">문제 설명</strong>
<div id="probcontent">
수많은 마라톤 선수들이 마라톤에 참여하였습니다. 단 한 명의 선수를 제외하고는 모든 선수가 마라톤을 완주하였습니다.

마라톤에 참여한 선수들의 이름이 담긴 배열 participant와 완주한 선수들의 이름이 담긴 배열 completion이 주어질 때, 완주하지 못한 선수의 이름을 return 하도록 solution 함수를 작성해주세요.
</div>
                     
<strong id="probtitle">제한사항</strong>
<div id="probcontent">
<li>마라톤 경기에 참여한 선수의 수는 1명 이상 100,000명 이하입니다.</li>
<li>completion의 길이는 participant의 길이보다 1 작습니다.</li>
<li>참가자의 이름은 1개 이상 20개 이하의 알파벳 소문자로 이루어져 있습니다.</li>
<li>참가자 중에는 동명이인이 있을 수 있습니다.</li>
</div>
                     
<strong id="probtitle">입출력 예</strong>
<div id="probcontent">
<table class="samT">
   <thead>
         <tr>
            <th>participant</th>
            <th>completion</th>
            <th>return</th>
         </tr>
   </thead>
   <tbody>
         <tr>
            <td>["leo", "kiki", "eden"]</td>
            <td>["eden", "kiki"]</td>
            <td>"leo"</td>
         </tr>
         <tr>
            <td>["marina","josipa","nikola","vinko","filipa"]</td>
            <td>["josipa","filipa","marina","nikola"]</td>
            <td>"vinko"</td>
         </tr>
         <tr>
            <td>["mislav","stanko","mislav","ana"]</td>
            <td>["stanko","ana","mislav"]</td>
            <td>"mislav"</td>
         </tr>
   </tbody>
</table>      
</div>

<strong id="probtitle">입출력 예 설명</strong>
<div id="probcontent">
<strong>예제 #1</strong>
leo는 참여자 명단에는 있지만, 완주자 명단에는 없기 때문에 완주하지 못했습니다.

<strong>예제 #2</strong>
vinko는 참여자 명단에는 있지만, 완주자 명단에는 없기 때문에 완주하지 못했습니다.

<strong>예제 #3</strong>
mislav는 참여자 명단에는 두 명이 있지만, 완주자 명단에는 한 명밖에 없기 때문에 한명은 완주하지 못했습니다.
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
    	  var algName = "해시"
          var probName = "완주하지+못한+선수"
          
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