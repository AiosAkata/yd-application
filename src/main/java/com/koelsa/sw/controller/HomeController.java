package com.koelsa.sw.controller;

import NiceID.Check.CPClient;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.koelsa.sw.command.ReserveRequest;
import com.koelsa.sw.domain.entity.ResponseMessage;
import com.koelsa.sw.domain.entity.StatusCode;
import com.koelsa.sw.jpa.*;
import com.koelsa.sw.repository.*;
import com.koelsa.sw.service.*;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.CompositeLogoutHandler;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URI;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
public class HomeController {
    @Autowired
    private YDReserveService ydReserveService;
    @Autowired
    private ReserveService reserveService;

    public HomeController() {
    }

    @RequestMapping({"/test"})
    public String test(HttpSession session) {
        session.setAttribute("sDupInfo", "MC0GCCqGSIb3DQIJAyEAm0cCSrRa2zGJVEf3EnGHvnXwn24I+lLbPTCGHtI16po=");
        session.setAttribute("sName", "문희수");
        session.setAttribute("sMobileNo", "01044728521");
        session.setAttribute("sGender", "1");
        session.setAttribute("sBirthDate", "19961113");
        return "redirect:/reserve";
    }

    @RequestMapping({"/", ""})
    public String main(Model model, HttpSession session, HttpServletRequest request) {
        String sEncData = this.NiceModule(session, request, "/reserve");
        String sCheckData = this.NiceModule(session, request, "/check");
        model.addAttribute("sEncData", sEncData);
        model.addAttribute("sCheckData", sCheckData);
        return "main";
    }

    @RequestMapping({"/header"})
    public String header(Model m, HttpSession session) throws IOException, GeneralSecurityException {
        m.addAttribute("user", (SessionUser)session.getAttribute("user"));
        return "template/header";
    }

    @RequestMapping({"/loading"})
    public String loading() {
        return "loading";
    }

    @RequestMapping({"/head"})
    public String head() throws IOException, GeneralSecurityException {
        return "template/head";
    }

    @RequestMapping({"/sub"})
    public String sub() throws IOException, GeneralSecurityException {
        return "template/sub";
    }

    @RequestMapping({"/footer"})
    public String footer(Model m) throws IOException, GeneralSecurityException {
        return "template/footer";
    }

    @RequestMapping({"/check"})
    public String check(HttpSession session, Model model) {
        String sDupInfo = (String)session.getAttribute("sDupInfo");
        if (sDupInfo == null) {
            model.addAttribute("message", "세션이 만료되었거나 잘못된 요청입니다.");
            model.addAttribute("returnUrl", "/");
            return "redirect";
        } else {
            Reserve reserve = this.reserveService.getAppByDupInfo(sDupInfo);
            if (reserve == null) {
                model.addAttribute("message", "신청 정보가 없습니다. 신청 화면으로 이동합니다.");
                model.addAttribute("returnUrl", "/reserve");
                return "redirect";
            } else {
                model.addAttribute("app", reserve);
                return "check";
            }
        }
    }

    @RequestMapping({"/update"})
    public String update(HttpSession session, Model model) {
        String sDupInfo = (String)session.getAttribute("sDupInfo");
        if (sDupInfo == null) {
            model.addAttribute("message", "세션이 만료되었거나 잘못된 요청입니다.");
            model.addAttribute("returnUrl", "/");
            return "redirect";
        } else {
            Reserve reserve = this.reserveService.getAppByDupInfo(sDupInfo);
            if (reserve == null) {
                model.addAttribute("message", "신청 정보가 없습니다. 신청 화면으로 이동합니다.");
                model.addAttribute("returnUrl", "/reserve");
                return "redirect";
            } else if (!reserve.getStatus().equals("신청")) {
                model.addAttribute("message", "신청 상태를 수정할 수 있는 상태가 아닙니다..");
                model.addAttribute("returnUrl", "/");
                return "redirect";
            } else {
                model.addAttribute("app", reserve);
                return "update";
            }
        }
    }

    @RequestMapping({"/reserve"})
    public String reserve(Model model, HttpSession session) {
        String sName = (String)session.getAttribute("sName");
        String sDupInfo = (String)session.getAttribute("sDupInfo");
        String sMobileNo = (String)session.getAttribute("sMobileNo");
        String sGender = (String)session.getAttribute("sGender");
        if (sDupInfo == null) {
            model.addAttribute("message", "세션이 만료되었거나 잘못된 요청입니다.");
            model.addAttribute("returnUrl", "/");
            return "redirect";
        } else if (this.reserveService.isDup(sDupInfo)) {
            model.addAttribute("message", "이미 신청이 완료된 사용자입니다. 예약 확인화면으로 넘어갑니다.");
            model.addAttribute("returnUrl", "/check");
            return "redirect";
        } else {
            try {
                String sBirthDate = (String)session.getAttribute("sBirthDate");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                Date birth = dateFormat.parse(sBirthDate);
                String processDate = (new SimpleDateFormat("yyyy-MM-dd")).format(birth);
                model.addAttribute("sBirthDate", processDate);
            } catch (Exception var11) {
                var11.printStackTrace();
            }

            model.addAttribute("sName", sName);
            model.addAttribute("sDupInfo", sDupInfo);
            model.addAttribute("sMobileNo", sMobileNo);
            model.addAttribute("sGender", sGender);
            return "reserve";
        }
    }

    @RequestMapping({"/reservation"})
    public String reservation(ReserveRequest request, HttpSession session, Model model) {
        try {
            Reserve reserve = new Reserve();
            String dupInfo = request.getSDupInfo();
            if (dupInfo == null || dupInfo.equals("")) {
                model.addAttribute("message", "잘못된 요청입니다.");
                model.addAttribute("returnUrl", "/");
                return "redirect";
            }

            reserve = this.reserveService.reserveSetup(reserve, request);
            reserve.setStatus("신청");
            this.reserveService.save(reserve);
        } catch (Exception var6) {
            var6.printStackTrace();
            model.addAttribute("message", "참가 신청 중 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
            model.addAttribute("returnUrl", "/");
            return "redirect";
        }

        model.addAttribute("message", "진주남강유등축제 등(燈)공모대전 참가 신청이 정상적으로 완료되었습니다.");
        model.addAttribute("returnUrl", "/");
        return "redirect";
    }

    @RequestMapping({"/modify"})
    public String modify(ReserveRequest request, HttpSession session, Model model) {
        try {
            String dupInfo = request.getSDupInfo();
            if (dupInfo == null || dupInfo.equals("")) {
                model.addAttribute("message", "잘못된 요청입니다.");
                model.addAttribute("returnUrl", "/");
                return "redirect";
            }

            Reserve reserve = this.reserveService.getAppByDupInfo(dupInfo);
            if (reserve == null) {
                model.addAttribute("message", "신청 정보가 없습니다. 신청 화면으로 이동합니다.");
                model.addAttribute("returnUrl", "/reserve");
                return "redirect";
            }

            if (!reserve.getStatus().equals("신청")) {
                model.addAttribute("message", "신청 상태를 수정할 수 있는 상태가 아닙니다.");
                model.addAttribute("returnUrl", "/");
                return "redirect";
            }

            reserve = this.reserveService.reserveSetup(reserve, request);
            this.reserveService.save(reserve);
        } catch (Exception var6) {
            var6.printStackTrace();
            model.addAttribute("message", "참가 신청서 수정 중 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
            model.addAttribute("returnUrl", "/");
            return "redirect";
        }

        model.addAttribute("message", "진주남강유등축제 등(燈)공모대전 참가 신청서 수정이 정상적으로 완료되었습니다.");
        model.addAttribute("returnUrl", "/");
        return "redirect";
    }

    @RequestMapping({"/login"})
    public String login(Model m) {
        return "login";
    }

    @RequestMapping({"/sns"})
    public String sns(Model m) {
        return "sns";
    }

    @RequestMapping({"/loginSuccess", "/hello"})
    public String loginSuccess(HttpSession session, Model model) {
        SessionUser sessionUser = (SessionUser)session.getAttribute("user");
        return sessionUser.getRole().equals(Role.ADMIN) ? "redirect:/cms" : "redirect:/";
    }

    @RequestMapping({"/loginFailure"})
    public String loginFailure(Model model) {
        model.addAttribute("message", "로그인 실패");
        return "login";
    }

    @RequestMapping({"/doLogout"})
    private String doLogout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        LogoutHandler handlers = new CompositeLogoutHandler(new LogoutHandler[]{new SecurityContextLogoutHandler()});
        handlers.logout(request, response, auth);
        return "redirect:/";
    }

    @PostMapping({"/file/upload"})
    @ResponseBody
    public ResponseEntity<Object> fileUpload(@RequestParam(name = "file") MultipartFile file, @RequestParam(name = "name") String name) {
        org.json.simple.JSONObject jsonObject = new org.json.simple.JSONObject();

        try {
            String path = this.reserveService.upload(file, name);
            if (path != null) {
                String uploadFileName = file.getOriginalFilename();
                if (uploadFileName.contains("\\")) {
                    uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
                }

                jsonObject.put("path", path);
                jsonObject.put("file", uploadFileName);
                jsonObject.put("message", "정상적으로 파일이 업로드 되었습니다.");
                jsonObject.put("status", "ok");
            } else {
                jsonObject.put("message", "파일을 선택해 주세요.");
                jsonObject.put("status", "error");
            }
        } catch (Exception var6) {
            var6.printStackTrace();
            jsonObject.put("message", "파일 업로드 도중 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
            jsonObject.put("status", "error");
            return new ResponseEntity(jsonObject, HttpStatus.OK);
        }

        return new ResponseEntity(jsonObject, HttpStatus.OK);
    }

    private String NiceModule(HttpSession session, HttpServletRequest request, String returnUrl) {
        CPClient niceCheck = new CPClient();
        String sSiteCode = "G6383";
        String sSitePassword = "VN2VOY5TTKBU";
        String sRequestNumber = "REQ0000000001";
        sRequestNumber = niceCheck.getRequestNO(sSiteCode);
        session.setAttribute("REQ_SEQ", sRequestNumber);
        String sAuthType = "";
        String popgubun = "N";
        String customize = "";
        String sGender = "";
        boolean isSecure = request.isSecure();
        String HOST = request.getHeader("HOST");
        String PROTOCOL = isSecure ? "https" : "http";
        String CONTEXT = request.getContextPath();
        String sReturnUrl = PROTOCOL + "://" + HOST + CONTEXT + "/auth/checkplus/success?targetURL=" + PROTOCOL + "://" + HOST + CONTEXT + returnUrl;
        String sErrorUrl = PROTOCOL + "://" + HOST + CONTEXT + "/auth/checkplus/fail";
        String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber + "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode + "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType + "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl + "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl + "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun + "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize + "6:GENDER" + sGender.getBytes().length + ":" + sGender;
        String sMessage = "";
        String sEncData = "";
        int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
        if (iReturn == 0) {
            sEncData = niceCheck.getCipherData();
        } else if (iReturn == -1) {
            sMessage = "암호화 시스템 에러입니다.";
        } else if (iReturn == -2) {
            sMessage = "암호화 처리오류입니다.";
        } else if (iReturn == -3) {
            sMessage = "암호화 데이터 오류입니다.";
        } else if (iReturn == -9) {
            sMessage = "입력 데이터 오류입니다.";
        } else {
            (new StringBuilder()).append("알수 없는 에러 입니다. iReturn : ").append(iReturn).toString();
        }

        return sEncData;
    }

    void SMSModule(JSONArray phoneArr, String text) {
        try {
            String msgStr = text;

            try {
                CloseableHttpClient httpclient = HttpClients.createDefault();
                CloseableHttpResponse response = null;
                HttpPost httpGet = null;
                HttpEntity entity = null;
                net.minidev.json.JSONObject json = new net.minidev.json.JSONObject();
                new JSONParser();
                String responseStr = "";
                URI uri = new URI("https://api-sens.ncloud.com/v1/sms/services/ncp:sms:kr:254621117950:yudeung/messages");
                httpGet = new HttpPost(uri.toString());
                httpGet.addHeader("Content-Type", "application/json");
                httpGet.addHeader("X-NCP-auth-key", "ySs3DjKFXSqNEb8kP23c");
                httpGet.addHeader("X-NCP-service-secret", "76643b9bfc4b4a8c9036532088eaed3c");
                json.put("type", "LMS");
                json.put("contentType", "COMM");
                json.put("countryCode", "82");
                json.put("from", "0557619111");
                json.put("to", phoneArr);
                json.put("content", msgStr);
                httpGet.setEntity(new StringEntity(json.toString(), "UTF-8"));
                response = httpclient.execute(httpGet);
                entity = response.getEntity();
                responseStr = EntityUtils.toString(entity, "UTF-8");
                EntityUtils.consume(entity);
            } catch (Exception var12) {
                var12.printStackTrace();
            }
        } catch (Exception var13) {
            System.out.println("SMS ERROR");
        }

    }
}