//package com.runoob.test;

import java.sql.*;

public class MySqlDemo {


    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/java_test_database";


    static final String USERNAME = "root";
    static final String PASSWORD = "kkk0907";

    public static void main(String[] args) {


        Connection connect = null;
        Statement stmt = null;

        try {

            Class.forName(JDBC_DRIVER);
            connect = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            stmt = connect.createStatement();
            String sql = "select * from user";
            ResultSet rs = stmt.executeQuery(sql);

            System.out.println("查询输出中");
            while (rs.next()){

                
                int obj = rs.getInt("uid");
                String name = rs.getString("name");
                System.out.println(obj + name);
            }


            rs.close();

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




