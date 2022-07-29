package com.koelsa.sw.service;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;
import com.amazonaws.util.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.UUID;

/**
 * v1.2
 * Made By Aios(문희수)
 * Last Modified at 2022-04-20
 * 해당 서비스를 복사할 때에는 S3Config 파일을 같이 복사
 * changeLog : v1.1 (22-04-20) 파일 업로드시 앞에 timestamp를 붙이지 않고 파일 존재시 (1), (2) 같은 형식으로 이름 변경후 업로드
 * changeLog : v1.2 (22-05-02) 메서드 간소화, 파일명 암호화 업로드 추가
 */
@Service
public class S3Service {
    private AmazonS3 s3Client;

    @Value("${cloud.aws.credentials.accessKey}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secretKey}")
    private String secretKey;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    @Value("${cloud.aws.region.static}")
    private String region;

    private final CannedAccessControlList accessControl = CannedAccessControlList.Private;

    public S3Object downloadFile(String path) throws IOException{
        return s3Client.getObject(new GetObjectRequest(bucket, path));
    }

    @PostConstruct
    public void setS3Client(){
        AWSCredentials credentials = new BasicAWSCredentials(this.accessKey,this.secretKey);

        s3Client = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials)).withRegion(this.region).build();
    }

    public String upload(MultipartFile file, String folder) throws Exception {
        ObjectMetadata objectMetadata = new ObjectMetadata();
        byte[] bytes = IOUtils.toByteArray(file.getInputStream());
        objectMetadata.setContentLength(bytes.length);
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

        String uploadFileName = file.getOriginalFilename();
        if(uploadFileName.contains("\\")){
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
        }

        int b = uploadFileName.lastIndexOf(".");
        String typeStr = uploadFileName.substring(b);
        String originName = uploadFileName.substring(0,b);
        String fileName = uploadFileName;

        boolean isExistObject = true;
        int dup = 1;
        while (isExistObject){
            isExistObject = s3Client.doesObjectExist(bucket + folder, fileName);
            if(isExistObject){
                fileName = originName + "("+dup+")" + typeStr;
                dup++;
            }
        }

        s3Client.putObject(new PutObjectRequest(bucket + folder, fileName, byteArrayInputStream, objectMetadata).withCannedAcl(accessControl));

        return fileName;
    }

    public String uploadWithHashedFileName(MultipartFile file, String folder) throws Exception {
        ObjectMetadata objectMetadata = new ObjectMetadata();
        byte[] bytes = IOUtils.toByteArray(file.getInputStream());
        objectMetadata.setContentLength(bytes.length);
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

        String uploadFileName = file.getOriginalFilename();
        int b = uploadFileName.lastIndexOf(".");
        String typeStr = uploadFileName.substring(b);
        String fileName = UUID.randomUUID() + typeStr;

        s3Client.putObject(new PutObjectRequest(bucket + folder, fileName, byteArrayInputStream, objectMetadata).withCannedAcl(accessControl));

        return fileName;
    }

    public String uploadFileWorker(MultipartFile file, String path) throws Exception {
        if(!path.equals("")){
            path = "/" + path;
        }
        return path + "/" + upload(file,path);
    }

    public String uploadUUIDFileWorker(MultipartFile file, String path) throws Exception {
        if(!path.equals("")){
            path = "/" + path;
        }
        return path + "/" + uploadWithHashedFileName(file,path);
    }

    public boolean deleteFileWorker(String file) throws Exception {
        int b = file.lastIndexOf("/");
        String filename = file.substring(b+1);
        String path = file.substring(0,b);

        if("".equals(file) == false && file != null){
            boolean isExistObject = s3Client.doesObjectExist(bucket + path, filename);

            if(isExistObject == true){
                s3Client.deleteObject(bucket + path,filename);
                return true;
            }
        }
        return false;
    }
}
