package forRefine;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.List;

public class refineForSim {

   //문자열 하나당 주석 및 키워드 제거
   public static String oneLineWithRemove(String s, List<String> except) {
         
      int i1 = s.indexOf("//");
      if (i1 != -1) {
         s = s.substring(0, i1);
      }

      if (except != null) {
         for (String ex : except) {
            s = s.replace(ex, "");
         }
      }

      return s;
   }

   //Porb 파일에서 저장된 코드 파일들 개행문자 제거하여 정제 및 읽어오기
   public static StringBuilder readCodeWithRemove(File file, List<String> except) throws Exception {
      // 파일 읽어오기
      StringBuilder sb = new StringBuilder();
      BufferedReader br = new BufferedReader(new FileReader(file));
      String s;

      while ((s = br.readLine()) != null) {
         s = s.replaceAll("혻"," ");
         sb.append(oneLineWithRemove(s, except));
      }
      br.close();
      return sb;
   }
   
   //유사도 높은 결과 탐지한 경우 해당 블로그 주소 출력해주는 코드
   public static StringBuilder outputSimCode(String id) {
      StringBuilder s = new StringBuilder();
      //System.out.println("refine에 들어온 주소 :"+id);
      id=id.replaceAll("#", "/");
      s.append(id);
      //System.out.println("s출력: "+s);
            
      return s;
   }
   
   public static String replaceString(String s) {
	   String temp = "";
	   temp = s.replaceAll("_", "/");
	   temp = temp.replaceAll("\\+", " ");
	   return temp;
   }
   
   public static String replaceStringforUse(String s) {
	   String temp = "";
	   temp = s.replaceAll("/", "_");
	   temp = temp.replaceAll(" ", "\\+");
	   return temp;
   }

}