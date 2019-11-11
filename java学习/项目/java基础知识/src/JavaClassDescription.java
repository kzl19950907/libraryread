import java.lang.reflect.Array;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;

public class JavaClassDescription {


    public static void main(String[] args) {


        Number num = new Number() {
            @Override
            public int intValue() {
                return 100;
            }

            @Override
            public long longValue() {
                return 20;
            }

            @Override
            public float floatValue() {
                return 15.f;
            }

            @Override
            public double doubleValue() {
                return 12.d;
            }
        };
        System.out.println(Math.sin(Math.PI/2));
        System.out.println(num.doubleValue());


        /*
        *   format
        * */
        System.out.format("format string "+ "%f\n",num.floatValue());


        System.out.println(new JavaClassDescription().createJavaString());


        JavaClassDescription desc = new JavaClassDescription();

        desc.arrayEnumeration();

        desc.javaDate();

        JavaClassDescription.testClassFuntion();
    }


    /*
    *
    * StringBuilder 的方法不是线程安全的（不能同步访问）。

    *  由于 StringBuilder 相较于 StringBuffer 有速度优势，所以多数情况下建议使用 StringBuilder 类。然而在应用程序要求线程安全的情况下，则必须使用 StringBuffer 类。


    * */

    public String createJavaString(){


        StringBuffer sBuffer = new StringBuffer("see you later");

        sBuffer.append(" hh ");

        return sBuffer.toString();
    }



    /*
    *   Array
    *
    * */

    public void arrayEnumeration(){


        int[] list = {1, 2, 5, 4};

        int max = list.length == 0?list[0]:0;
        for (int temp : list) {

            max = Math.max(max, temp);
        }

        System.out.println("max value " + max);


        ArrayList javaArray = new ArrayList<Integer>();
        javaArray.add(3);
        javaArray.add(2);
        javaArray.add(5);

        System.out.println("javaArray =  " + javaArray);

    }


    /*
    *
    *   Date时间
    * */

    public void javaDate(){

        Date now = new Date();

        System.out.println(now);

        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");

        System.out.println(format.format(now));

    }


    public static void testClassFuntion(){

        System.out.println("Class Funtion no initialize a obj");
    }




    /*
    *
    *  协议
    * */

    public interface JavaProtocol {


        public void eat();

        public void run();
    }


    class SubJavaClassDescription extends JavaClassDescription implements JavaProtocol{


        public void testProtocol(){

            this.eat();
            this.run();
        }

        @Override
        public void eat() {


        }

        @Override
        public void run() {

        }
    }

}
