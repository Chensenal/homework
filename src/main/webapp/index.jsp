<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/11
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户登录</title>
    <link rel="stylesheet" href="${APP_PATH }/css/css/bootstrap.min.css">
    <script src="${APP_PATH }/static/js/jquery.1.12.4.min.js" charset="UTF-8"></script>
    <script src="${APP_PATH }/static/js/bootstrap.min.js" charset="UTF-8"></script>
    <script src="${APP_PATH }/static/js/vue.js"></script>
    <style>
        .bgimg{
            border:1px solid #000fff;
            height:500px;
            background-image: url(${APP_PATH}/images/2.jpg);
        }
        .container{
            display:table;
            height:100%;
        }

        .row{
            display: table-cell;
            vertical-align: middle;
        }
        /* centered columns styles */
        .row-centered {
            text-align:center;
        }
        .col-centered {
            display:inline-block;
            float:none;
            text-align:left;
            margin-right:-4px;
        }

    </style>
</head>
<body>
<center>
    <h1>欢迎游客来到设备查询网站</h1>
    <a href="${APP_PATH}/user/jumpLogin">点击这个连接出发</a>
</center>

</body>
</html>

