package com.koelsa.sw.util.excel;

import java.util.ArrayList;

public class ExcelData extends ArrayList<ExcelRow> {
    private String title = "";

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public String toString() {
        return "ExcelData{" +
                "title='" + title + '\'' +
                '}' + '\n' + super.toString();
    }
}
