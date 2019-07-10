## **Markdown语法**

  # 一级标题
  ## 二级标题
  ...
  ###### 六级标题

  <br></br>


- **加粗**  
  文字左右 ** 包起来

+ *斜体*
  文字左右 * 包起来

* ***斜体加粗***  
  文字左右 *** 包起来

* ~~删除线~~   
  文字左右 ~~ 包起来

* <font color=red size=14>彩色字体</font>   
  使用内嵌html方法实现字体更换

* <table>
    <tr>
      <td bgcolor =orange>
        <font color=red size=12>彩色带背景字体</font>
      </td>
    </tr>
  </table>
    采用内置html的方式实现：借助 table, tr, td 等表格标签的 bgcolor 属性来实现背景色的功能。

  <br></br>


* <font size=5>分割线</font>
  
  ***
  ---
  _ _ _
  在一行中使用三个以上的* - _ 来建立一个分割线，并且行内不能有其他字符 可以在*-_ 中间穿插字符


* 引用内容
>引用内容1
>>引用内容2
>>
>>>引用内容3    

...引用可以无限制嵌套


* ### 添加图片
![这是一张图片](./1.jpg)

* 设置图片大小
<img src="https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1562208066&di=e2840ef40d5d0a566a4c70e81469da36&src=http://imgq.duitang.com/uploads/item/201501/31/20150131174003_hVwik.jpeg" width="150" />


* ### 超链接
  [百度](www.baidu.com)


* 列表嵌套
  + a1
  - a2
  * a3

* 单个字符表示无序列表    

  1. a1
  2. a2
  3. a3

* 数字加点表示有序列表

  * 一级无序列表
    * 二级无序列表
      * 三级无序列表
  * 二级无序列表
    1. 二级有序列表

* ### 表格

表头1|表头2|。。。   
:--|:--:|--:|   
a|b|c
...|...|...   

:文字 居左 默认   
:文字: 居中   
文字: 居右    

* ### 代码块

`单行代码 `   

```objective-c
多行代码
多行代码
多行代码
```

# Markdown高阶语法
- 内容目录    

[TOC]

