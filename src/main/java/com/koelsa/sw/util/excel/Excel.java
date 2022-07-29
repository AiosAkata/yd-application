package com.koelsa.sw.util.excel;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class Excel {
    private static final Logger logger = Logger.getLogger(Excel.class);
    public static final int EXCEL_TYPE_STUDENTS = 0;
    public static final int EXCEL_TYPE_MILEAGE = 1;

    public static ExcelData excelReader(MultipartFile file, String root_path, int fileType) {
        String filename = file.getOriginalFilename();
        File tmpExcel = new File(root_path + "/WEB-INF/temp/", filename);
        ExcelData excelDatas = null;

        try {
            if (tmpExcel.delete()) {
//                System.out.println(tmpExcel.getName() + " is deleted!");
            } else {
//                System.out.println("Delete operation is failed.");
            }
            file.transferTo(tmpExcel);
            excelDatas = Excel.excelReader(tmpExcel, fileType);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }


        return excelDatas;
    }

    public static ExcelData excelReader(File file, int fileType) throws Exception {
        ExcelData excelData = new ExcelData();

        FileInputStream inputDocument = new FileInputStream(file);
        Workbook workbook = null;

        if (file.getName().toLowerCase().endsWith("xlsx")) { // 엑셀 파일의 확장자(버전)에 따라서 생성해야 할 Workbook 객체가 다르다.
            workbook = new XSSFWorkbook(inputDocument);
        }else{
            workbook = new HSSFWorkbook(inputDocument);
        }

        ExcelRow excelRow;
        Sheet sheet = fileType == EXCEL_TYPE_MILEAGE ? workbook.getSheetAt(1) : workbook.getSheetAt(0);

        int rowCnt = sheet.getPhysicalNumberOfRows();
        Integer r = 0;
        List<String> subjects = new ArrayList<String>();

        subjects.add("title");

//      Getting title
        excelRow = new ExcelRow();
        r = extractNextRow(sheet, r, excelRow);
        excelData.setTitle(excelRow.get("0"));

//      Getting subject
        excelRow = new ExcelRow();
        r = extractNextRow(sheet, r, excelRow);
        subjects = excelRow.getValues();

        for (; r < rowCnt; r++) {
            excelData.add(extractRow(sheet, r, subjects));
        }

        return excelData;
    }

    public static ExcelData excelReader(InputStream stream, String filename, int fileType) throws Exception {
        ExcelData excelData = new ExcelData();

        FileInputStream inputDocument = (FileInputStream) stream;
        Workbook workbook = null;

        if (filename.toLowerCase().endsWith("xlsx")) { // 엑셀 파일의 확장자(버전)에 따라서 생성해야 할 Workbook 객체가 다르다.
            workbook = new XSSFWorkbook(inputDocument);
        }else{
            workbook = new HSSFWorkbook(inputDocument);
        }

        ExcelRow excelRow;
        Sheet sheet = fileType == EXCEL_TYPE_MILEAGE ? workbook.getSheetAt(1) : workbook.getSheetAt(0);

        int rowCnt = sheet.getPhysicalNumberOfRows();
        Integer r = 0;
        List<String> subjects = new ArrayList<String>();

        subjects.add("title");

//      Getting title
        excelRow = new ExcelRow();
        r = extractNextRow(sheet, r, excelRow);
        excelData.setTitle(excelRow.get("0"));

//      Getting subject
        excelRow = new ExcelRow();
        r = extractNextRow(sheet, r, excelRow);
        subjects = excelRow.getValues();

        for (; r < rowCnt; r++) {
            excelData.add(extractRow(sheet, r, subjects));
        }

        return excelData;
    }

    private static Integer extractNextRow(Sheet sheet, Integer r, ExcelRow result) {
        ExcelRow excelRow;

        while (true) {
            excelRow = extractRow(sheet, r, null);
            r++;
            if (excelRow != null) {
                result.set(excelRow);
                return r;
            }
        }
    }

    private static ExcelRow extractRow(Sheet sheet, int r, List<String> subjects) {
        ExcelRow excelRow = new ExcelRow();
        Row row = sheet.getRow(r);

        if (row == null) return null;

        int cellCnt = row.getPhysicalNumberOfCells();
        int subjectNum = 0;

        // 빈 열
        if (cellCnt == 0) return null;

        for (int c = 0; c < cellCnt; c++) {
            Cell cell = row.getCell(c);
            String cellValue = "";

            // 엑셀 타입별로 분리
            // 숫자, 문자 이외의 수식, 데이터, null이 아닌 공백, 에러 등 많은 종류가 있다
            // 공백은 null 값
            if (cell == null) {
                cellCnt++;
                continue;
            }

            int cellType = cell.getCellType();
            switch (cellType) {
                case Cell.CELL_TYPE_NUMERIC: // type 숫자
                    cellValue = String.valueOf((int)cell.getNumericCellValue());
                    break;
                case Cell.CELL_TYPE_STRING: // type 문자
                    cellValue = cell.getStringCellValue();
                    break;
            }

            if (subjects == null) {
                excelRow.put(subjectNum + "", cellValue.trim().replace("\n", ""));
            } else {
                if (subjectNum >= subjects.size()) return excelRow;
                excelRow.put(subjects.get(subjectNum), cellValue);
            }
            subjectNum++;
        }

//        logger.info(excelRow);

        return excelRow;
    }
}
