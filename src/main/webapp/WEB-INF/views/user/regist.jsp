<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
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
                    <h1>用户注册</h1>
                </center>
                <div id="regist">
                    <div class="input-group input-group-md">
                        <span class="input-group-addon" id="sizing-addon1"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="text" name="name" id="name" class="form-control">
                        <br>
                    </div>
                    <div class="input-group input-group-md">
                        <span class="input-group-addon" id="sizing-addon2"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" name="password" id="password" class="form-control">
                        <br>
                    </div>
                    <button type="submit" id="confirmRegist" class="btn btn-success btn-block">注册</button>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>
<script>
    var vm = new Vue({
        el:  "#regist",
        data:{
            name:'',
            password:'',
        },
        mounted: function () {
            this.regist()
        },
        methods :{
            regist(){
                $('#confirmRegist').click(function () {
                    var that = this;
                    var name = $('#name').val().trim()
                    var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                    if (!regName.test(name) || name == "") {
                        alert("用户名字可以是2-5位中文或者6-16位英文和数字的组合")
                        return false;
                    }
                    var password = $('#password').val().trim();
                    var regName =   /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/
                    if (!regName.test(password) || password == "") {
                        alert("密码至少8个字符，至少1个大写字母，1个小写字母和1个数字,不能包含特殊字符(非数字字母)")
                        return false;
                    }
                    that.name = $('#name').val().trim();
                    that.password = $('#password').val().trim();
                    $.ajax({
                        url:"${APP_PATH }/user/Regist",
                        type:'post',
                        data:{
                            'username':that.name,
                            "password":that.password,
                        },
                        success :function (result) {
                            if(result.code==100){
                                alert("注册成功")
                                window.location.href="${APP_PATH }/user/jumpLogin";
                            }else{
                                alert("注册失败")
                                alert(result.extend.errorMsg)
                            }
                        },
                        error: function () {
                            alert("出错")
                        }
                    })
                })
            },
        }
    })
</script>