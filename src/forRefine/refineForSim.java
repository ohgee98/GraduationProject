package forRefine;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.List;

public class refineForSim {

   //���ڿ� �ϳ��� �ּ� �� Ű���� ����
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

   //Porb ���Ͽ��� ����� �ڵ� ���ϵ� ���๮�� �����Ͽ� ���� �� �о����
   public static StringBuilder readCodeWithRemove(File file, List<String> except) throws Exception {
      // ���� �о����
      StringBuilder sb = new StringBuilder();
      BufferedReader br = new BufferedReader(new FileReader(file));
      String s;

      while ((s = br.readLine()) != null) {
         s = s.replaceAll(" "," ");
         sb.append(oneLineWithRemove(s, except));
      }
      br.close();
      return sb;
   }
   
   //���絵 ���� ��� Ž���� ��� �ش� ��α� �ּ� ������ִ� �ڵ�
   public static StringBuilder outputSimCode(String id) {
      StringBuilder s = new StringBuilder();
      //System.out.println("refine�� ���� �ּ� :"+id);
      id=id.replaceAll("#", "/");
      s.append(id);
      //System.out.println("s���: "+s);
            
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