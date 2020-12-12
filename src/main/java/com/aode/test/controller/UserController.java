package com.aode.test.controller;


import com.aode.test.pojo.User;
import com.aode.test.service.UserService;
import com.aode.test.utils.Md5Utils;
import com.aode.test.utils.Msg;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import cz.mallat.uasparser.OnlineUpdater;
import cz.mallat.uasparser.UASparser;
import cz.mallat.uasparser.UserAgentInfo;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaohua
 * @since 2020-12-11
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;
    @ResponseBody
    @RequestMapping(value = "Login",method = RequestMethod.POST)
    public Msg Login(@RequestParam(value = "username",required = false) String  username, @RequestParam(value = "password",required = false) String  password, HttpSession httpSession){
        User user = new User();
        try {
            password = Md5Utils.getMD5_32bits(password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        user.setPassword(password);
        user.setName(username);
        User user1 = userService.selectOne(new EntityWrapper<User>().
                eq("name", username)
                .eq("password",password));
       if(user1!=null){
           httpSession.setAttribute("user", user1);
           return Msg.success();
       }else{
           return Msg.fail().add("errorMsg", "用户名密码不正确");
       }
    }
    @ResponseBody
    @RequestMapping(value = "Regist",method = RequestMethod.POST)
    public Msg regist(@RequestParam(value = "username",required = false) String  username, @RequestParam(value = "password",required = false) String  password){
        User user = new User();
        user.setName(username);
        try {
            password = Md5Utils.getMD5_32bits(password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        user.setPassword(password);
        boolean flag  = userService.insert(user);
        if(flag){
            return Msg.success();
        }else{
            return Msg.fail().add("errorMsg", "注册失败");
        }
    }


    @RequestMapping(value = "jumpLogin",method = RequestMethod.GET)
    public String jumpLogin(HttpServletRequest request,HttpSession httpSession){
        UASparser uasParser = null;
        String header = request.getHeader("user-agent");
        String ip = request.getRemoteAddr();
        int port = request.getRemotePort();
        UserAgentInfo userAgentInfo = null;
        try {
            uasParser = new UASparser(OnlineUpdater.getVendoredInputStream());
            userAgentInfo = uasParser.parse(header);
        } catch (IOException e) {
            e.printStackTrace();
        }
        httpSession.setAttribute("userAgentInfo",userAgentInfo);
        httpSession.setAttribute("ip", ip);
        httpSession.setAttribute("port", port);
        httpSession.setAttribute("header", header);
        System.out.println("操作系统名称："+userAgentInfo.getOsFamily());//
        System.out.println("操作系统："+userAgentInfo.getOsName());//
        System.out.println("浏览器名称："+userAgentInfo.getUaFamily());//
        System.out.println("浏览器版本："+userAgentInfo.getBrowserVersionInfo());//
        System.out.println("设备类型："+userAgentInfo.getDeviceType());
        System.out.println("浏览器:"+userAgentInfo.getUaName());
        System.out.println("类型："+userAgentInfo.getType());
        return "user/login";
    }
    @RequestMapping(value = "jumpRegist",method = RequestMethod.GET)
    public String jumpRegist(){
        return "user/regist";
    }
}

