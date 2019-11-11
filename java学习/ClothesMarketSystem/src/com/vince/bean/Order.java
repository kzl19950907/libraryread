package com.vince.bean;


import com.vince.utils.*;

import java.io.Serializable;

import java.util.*;




public class Order implements Serializable {

    private String createDate;
    private List <OrderItem> orderItemList = new ArrayList<OrderItem>();
    private int userId;
    private OrderStatusType status = OrderStatusType.UNPAID;

    private float sumPrice; //订单总价


    public float goodsSumPrice(List<OrderItem>) {


        float sumprice = 0.f;
        for (OrderItem item : orderItemList){

            sumprice += item.getPrice();

        }

        return sumprice;
    }

}
