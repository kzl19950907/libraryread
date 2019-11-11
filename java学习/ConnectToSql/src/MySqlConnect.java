//package com.runoob.test;

import java.sql.*;



public class MySqlConnect {


    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/RUNOOB";


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


                System.out.println(rs);
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
