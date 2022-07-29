package com.koelsa.sw.command;

import lombok.Data;

@Data
public class ReserveRequest {
    private String sDupInfo;
    private String gender;
    private String birth;
    private String name;
    private String phone;
    private String email;
    private String file1;
    private String file1name;
    private String file2;
    private String file2name;
}
