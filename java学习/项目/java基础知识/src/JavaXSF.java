
/*
*
* Java 修饰符
*
**/

import java.lang.reflect.Array;

public class JavaXSF {


    public String xsfString = "public修饰符";
    private String privateString = "private修饰符 同一类可访问";
    protected String protectdString = "protected修饰符 同一包内的类 以及子类能访问";


    /*序列化的对象包含被 transient 修饰的实例变量时，java 虚拟机(JVM)跳过该特定的变量。

      该修饰符包含在定义变量的语句中，用来预处理类和变量的数据类型。

      作用未知！！！！！！！！！！！！！
    */
    public transient int limit = 55;


    /*
    *   volatile保证多线程同时访问到的值是同一个
    * */
    public volatile int volatileValue = 10;

    public static void main(String[] args) {

        SubJavaXSF sub = new SubJavaXSF();

        sub.hello();

        sub.number ++;

        System.out.println("number = " + sub.number);

//        System.out.println("finalValue = " + (++sub.finalValue));



        int a = new JavaXSF().limit;

        System.out.println(a);

    }

    protected void hello(){

        System.out.println(this.getClass() + "hello");
    }


    /*
    *   synchronized 关键字声明的方法只能同时被一个线程访问
    * */
    public synchronized void onlyOneProcessCanComeIn(){


    }


    /*
    *   for循环
    * */
    public void loopFunction(){


        int[] number = {1, 2, 3, 4, 5};//C式写法
        for(int x : number){

            System.out.println("x");
        }
    }



}

class SubJavaXSF extends JavaXSF{


    public static int number = 0; //静态变量
    public final int finalValue = 100; //常量 不可修改
    public void hello(){

        System.out.println("class SubJavaXSF extends JavaXSF hello");
    }
}



/*
*   final修饰class 不可被继承
* */


final  class TestFinalClass{


}

//class SubFinalClass extends TestFinalClass{
//
//
//}


/*
*   abstract 修饰class 为抽象类
*            修饰的方法 为抽象方法
*
*   子类继承必须实现abstract的方法 除非子类也是抽象类
*
*   抽象类可以不包含任何抽象方法
*   一个类只能继承一个抽象类 实现多个接口
* */
abstract class NSObject{


    abstract void description();

}

class SubNsobject extends NSObject{


    @Override
    void description() {

        System.out.println("非抽象子类继承abstract修饰的父类 需要实现抽象方法");
    }
}















