<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/11
  Time: 16:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<div class="bgimg">
    <div class="container">
        <div class="row row-centered">
            <div class="well col-md-6 col-centered">
                <center>
                    <h1>用户登录</h1>
                </center>
                <div id="login">
                    <div class="input-group input-group-md">
                        <span class="input-group-addon" id="sizing-addon1"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="text" name="name" id="name" class="form-control">
                        <span class="help-block"></span>
                        <br>
                    </div>
                    <div class="input-group input-group-md">
                        <span class="input-group-addon" id="sizing-addon2"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" name="password" id="password" class="form-control">
                        <span class="help-block"></span>
                        <br>
                    </div>
                    <button type="submit" id="confirmLogin" class="btn btn-success btn-block">登录</button>
                    <a href="${APP_PATH}/user/jumpRegist">没有账号去注册</a>
                </div>
                <center>
                    <c:if test="${user!=null}">
                        欢迎${user.name}<br>
                    </c:if>
                    <c:if test="${userAgentInfo!=null}">
                        设备:${userAgentInfo.osFamily}<br>
                        设备型号：${userAgentInfo.osName}<br>
                        RemoteIp:${ip}<br>
                        -----------------------------------------<br>
                        Browser:${userAgentInfo.uaFamily}<br>
                        ------------------------------------------<br>
                        User-Agent:${header}<br>
                    </c:if>
                </center>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<script>
    var vm = new Vue({
        el:  "#login",
        data:{
            name:'',
            password:'',
        },
        mounted: function () {
            this.login()
        },
        methods :{
            login(){
                $('#confirmLogin').click(function () {
                    var that = this;
                    that.name = $('#name').val().trim();
                    that.password = $('#password').val().trim();
                    $.ajax({
                        url:"${APP_PATH }/user/Login",
                        type:'post',
                        data:{
                            'username':that.name,
                            "password":that.password,
                        },
                        success :function (result) {
                            if(result.code==100){
                                alert("登录成功")
                            }else{
                                alert(result.extend.errorMsg)
                            }
                        },
                    })
                })
            },
        }
    })
</script>
