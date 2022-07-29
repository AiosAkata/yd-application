package com.koelsa.sw.util.upload;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class UploadProcess {

    public static HashMap upload(MultipartFile multipartFile, String type, HttpSession httpSession, HttpServletRequest httpServletRequest) {

        HashMap<String, Object> fileInfo = new HashMap<>(); //CallBack할 때 파일 정보를 담을 Map

        // 업로드 파일이 존재하면
        if(multipartFile != null && !(multipartFile.getOriginalFilename().equals(""))) {

            //파일크기 제한 (50MB)
            long filesize = multipartFile.getSize(); //파일크기
            long limitFileSize = 50*1024*1024; //50MB
            if(limitFileSize < filesize){ //제한보다 파일크기가 클 경우
                fileInfo.put("result", -1);
                return fileInfo;
            }

            // 저장경로
            // String defaultPath = httpSession.getServletContext().getRealPath("/"); //서버기본경로 (프로젝트 폴더 아님)\
            String defaultPath = System.getProperty("catalina.base") + "/webapps/upload";
            String path = defaultPath + File.separator + "boardcontroller" + File.separator + "files" + File.separator + "";

            // 저장경로 처리
            File file = new File(path);
            if(!file.exists()) { //디렉토리 존재하지 않을경우 디렉토리 생성
                file.mkdirs();
            }

            double randomVal = Math.random();
            int randomIndex = (int)(randomVal * 100000000) + 1;

            // 파일 저장명 처리 (20150702091941-파일명)
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String today= formatter.format(new Date());
            String originalName = multipartFile.getOriginalFilename(); //파일이름

            int b = originalName.lastIndexOf(".");
            String typeStr = originalName.substring(b, originalName.length());

            String modifyName = today + "-" + randomIndex + typeStr;

            // Multipart 처리
            try{
                //서버에 파일 저장 (쓰기)
                multipartFile.transferTo(new File(path + modifyName));
            }
            catch (Exception e){
                e.printStackTrace();
//                System.out.println("/ 파일업로드 실패 - singleUploadFileAjax");
            }

            // mime
            String fileMime = multipartFile.getContentType();

            // CallBack - Map에 담기
//            String attachurl = httpSession.getServletContext().getContextPath() + "/upload/board/files/" + modifyName; //separator와는 다름!
            String attachurl = httpServletRequest.getContextPath() + "/upload/boardcontroller/files/" + modifyName; //separator와는 다름!

            fileInfo.put("attachurl", attachurl); //상대파일경로(사이즈변환이나 변형된 파일)
            fileInfo.put("filemime", fileMime); //mime
            fileInfo.put("filename", originalName); //파일명
            fileInfo.put("filesize", filesize); //파일사이즈

            fileInfo.put("result", 1); //-1을 제외한 아무거나 싣어도 됨
        }

        return fileInfo;
    }

    public static HashMap uploadWithoutLimit(MultipartFile multipartFile, HttpSession httpSession, String savePath, HttpServletRequest httpServletRequest) {

        HashMap<String, Object> fileInfo = new HashMap<>(); //CallBack할 때 파일 정보를 담을 Map

        // 업로드 파일이 존재하면
        if(multipartFile != null && !(multipartFile.getOriginalFilename().equals(""))) {
            long filesize = multipartFile.getSize(); //파일크기

            // 저장경로
            String defaultPath = httpSession.getServletContext().getRealPath("/"); //서버기본경로 (프로젝트 폴더 아님)
            String path = defaultPath + savePath;

//            System.out.println("savePath: " + savePath);

            // 저장경로 처리
            File file = new File(path);
            if(!file.exists()) { //디렉토리 존재하지 않을경우 디렉토리 생성
                file.mkdirs();
            }

            // 파일 저장명 처리 (20150702091941-파일명)
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String today= formatter.format(new Date());
            String originalName = multipartFile.getOriginalFilename(); //파일이름
            String modifyName = today + "-" + originalName;

            // Multipart 처리
            try{
                //서버에 파일 저장 (쓰기)
                multipartFile.transferTo(new File(path + modifyName));
            }
            catch (Exception e){
                e.printStackTrace();
            }

            // mime
            String fileMime = multipartFile.getContentType();

            // CallBack - Map에 담기
//            String attachurl = httpSession.getServletContext().getContextPath() + savePath + modifyName; //separator와는 다름!
            String attachurl = httpServletRequest.getContextPath()+ savePath + modifyName; //separator와는 다름!
            fileInfo.put("attachurl", attachurl); //상대파일경로(사이즈변환이나 변형된 파일)
            fileInfo.put("filemime", fileMime); //mime
            fileInfo.put("filename", modifyName); //파일명
            fileInfo.put("filesize", filesize); //파일사이즈

            fileInfo.put("result", 1); //-1을 제외한 아무거나 싣어도 됨
        }

        return fileInfo;
    }
}
