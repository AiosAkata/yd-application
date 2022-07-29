package com.koelsa.sw.service;

import com.koelsa.sw.command.ReserveRequest;
import com.koelsa.sw.command.SimpleSearchRequest;
import com.koelsa.sw.jpa.Reserve;
import com.koelsa.sw.jpa.ReserveFile;
import com.koelsa.sw.repository.ReserveFileRepository;
import com.koelsa.sw.repository.ReserveRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class ReserveService {
    @Autowired
    private ReserveRepository reserveRepository;
    @Autowired
    private ReserveFileRepository reserveFileRepository;
    @Autowired
    private S3Service s3Service;

    public ReserveService() {
    }

    public Reserve reserveSetup(Reserve reserve, ReserveRequest request) {
        reserve.setName(request.getName());
        reserve.setGender(request.getGender());
        reserve.setPhone(request.getPhone());
        reserve.setBirth(request.getBirth());
        reserve.setDupInfo(request.getSDupInfo());
        reserve.setEmail(request.getEmail());
        reserve.setFile1(request.getFile1());
        reserve.setFilename1(request.getFile1name());
        reserve.setFile2(request.getFile2());
        reserve.setFilename2(request.getFile2name());
        return reserve;
    }

    @Transactional
    public Page<Reserve> getPages(int page, int showNum, SimpleSearchRequest request) {
        if (page < 0) {
            page = 0;
        }

        PageRequest pageRequest = PageRequest.of(page, showNum, Sort.Direction.DESC, new String[]{"id"});
        String categoryStr = request.getCategory();
        Page<Reserve> pages = this.reserveRepository.findAll(pageRequest);
        String searchKey = "%" + request.getValue() + "%";
        byte var9 = -1;
        switch(categoryStr.hashCode()) {
            case 96673:
                if (categoryStr.equals("all")) {
                    var9 = 0;
                }
            default:
                switch(var9) {
                    case 0:
                        pages = this.reserveRepository.search(pageRequest, searchKey);
                    default:
                        return pages;
                }
        }
    }

    public boolean isDup(String sDupInfo) {
        List<Reserve> applications = this.reserveRepository.findAllByDupInfo(sDupInfo);
        return applications.size() > 0;
    }

    public Reserve getAppByDupInfo(String sDupInfo) {
        return this.reserveRepository.findByDupInfo(sDupInfo);
    }

    public List<Reserve> getAll() {
        return this.reserveRepository.findAll();
    }

    @Modifying
    @Transactional
    public void deleteFileById(int id) {
        this.reserveFileRepository.deleteById(id);
    }

    @Modifying
    @Transactional
    public Reserve save(Reserve fes) {
        return (Reserve)this.reserveRepository.save(fes);
    }

    public Reserve getOne(int id) {
        return (Reserve)this.reserveRepository.getOne(id);
    }

    public ReserveFile getFile(int id) {
        return (ReserveFile)this.reserveFileRepository.getOne(id);
    }

    @Modifying
    @Transactional
    public void deleteById(int id) {
        this.reserveRepository.deleteById(id);
    }

    public String upload(MultipartFile file, String name) throws Exception {
        return file.isEmpty() ? null : this.s3Service.uploadFileWorker(file, "reserve/" + name);
    }
}
