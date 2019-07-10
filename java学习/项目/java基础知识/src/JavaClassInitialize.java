public class JavaClassInitialize {


    public static void main(String[] args) {


        JavaClassInitialize obj = new JavaClassInitialize(3);

        System.out.println("obj.index = " + obj.index);

        JavaClassInitialize.mutableParametersFuntion(3.d, 5.3d,232.d);



        //GC
        obj = null;
        System.gc();
    }


    /*
    *
    *   构造方法
    * */
    public int index;

    JavaClassInitialize(int i){

        index = i;
    }


    /*
    *
    *   传递可变参数
    *
    * */

    public static void mutableParametersFuntion(double... args){


        if (args.length == 0){

            System.out.println("no args in parameters");
        }else {

            for (double temp: args ) {

                System.out.println("hhh args = " + temp);
            }
        }
    }


    /*
    *
    *  GC析构之前 （回收）调用finalize()方法
    *
    * */

    protected void finalize() throws java.lang.Throwable {


        try {

            System.out.println("GC 析构" + new Exception().getStackTrace()[0].getMethodName());
            ;


        } catch (Exception e) {


        } finally {

            super.finalize();


        }
    }

}
