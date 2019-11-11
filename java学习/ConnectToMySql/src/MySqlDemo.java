//package com.runoob.test;

import java.io.InputStream;
import java.sql.*;
import java.util.Scanner;

public class MySqlDemo {


        static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
        static final String DB_URL = "jdbc:mysql://localhost:3306/java_test_database";


        static final String USERNAME = "root";
        static final String PASSWORD = "kkk0907";

        public static void main(String[] args) {


            Connection connect = null;
            Statement stmt = null;

            PreparedStatement pstmt = null;

            try {




                Class.forName(JDBC_DRIVER);
                connect = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
                stmt = connect.createStatement();

                //  ?占位符 pstmt预编译
//                pstmt = connect.prepareStatement("select * from user where name=?;");




//                Scanner sc = new Scanner(System.in);
//
//                String uname = sc.nextLine();

//                pstmt = connect.prepareStatement("insert  into  user  value (?,?,?,?);");
                pstmt = connect.prepareStatement("update  user set age = ? where uid>100;");


                pstmt.addBatch();
//                for (int i = 0 ; i < 1000; i++){
//
//                    Integer temp =  i + 3;
//
//                    pstmt.setInt(1, i+3);
//                    pstmt.setString(2, temp.toString());
//                    pstmt.setInt(3, temp);
//                    pstmt.setBoolean(4, true);
//
                    boolean res = pstmt.execute();
//
                    if (res){

                        System.out.println("插入成功");
                    }
//                }

//                pstmt.setString(1, uname);
//
//                ResultSet pst = pstmt.executeQuery();
//                while (pst.next()){
//
//                    System.out.println(pst.getString(2));
//
//                }
//                String sql = "select * from user where name='" + uname + "';";
//                ResultSet rs = stmt.executeQuery(sql);

//                System.out.println("查询输出中");
//                while (rs.next()){
//
//                    System.out.println(rs.getInt("age"));
//
//                }



//                rs.close();

                stmt.close();

                connect.close();


            }catch (SQLException sqle){

                sqle.printStackTrace();
            } catch (Exception e){

                e.printStackTrace();

                System.out.println("exception" + e);

            }finally {

                System.out.println("查询完毕");

            }


        }


}




