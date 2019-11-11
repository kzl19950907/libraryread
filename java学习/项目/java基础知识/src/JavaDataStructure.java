import java.lang.reflect.Array;
import java.util.*;

public class JavaDataStructure {


    public static void main(String[] args) {


        HashMap map = new HashMap();
        map.put("a", "b");
        System.out.println(map);
//        Object a = map.remove("a");
//        System.out.println(a);



        /*
        *
        *   HashTable
        *
        * */

        Hashtable hashtable = new Hashtable(map);

        System.out.println(" hashtable " +hashtable + hashtable.size());




        /*
        *
        *   Set无序集合
        *   List有序集合
        *
        * */

//        Set set = new Set();




        /*
        *
        *
        *  ArrayList 本身是一个可改变大小的数组  ArrayList 增长当前长度的50%
        *  ArrayList 相对于 LinkList 查找更高效
        *  Linklist 插入删除比ArrayList高效
        *
        *
        *
        * */
        ArrayList <String> arrayList = new ArrayList();

        arrayList.add("s");

        arrayList.add("a");



        /*
        *
        *
        *   泛型
        *
        * */


        JavaDataStructure.printArray(arrayList);

    }


    public static <A> void printArray( ArrayList <A> parameters){


        for (A temp: parameters
             ) {


            System.out.println(temp);

        }
    }


}
