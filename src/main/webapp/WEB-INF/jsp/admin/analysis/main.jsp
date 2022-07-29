<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<style>
    .chart{
        padding: 0 40px;
    }

    #chart-div{
        height: 250px;
        width: 100%;
    }

    #chart-div2{
        height: 400px;
        width: 100%;
    }
    table.first{
        margin-bottom: 30px !important;
    }
    table.normalBoardWr{
        border: 1px solid #aaaaaa !important;
    }
    table.normalBoardWr thead th{
        border-left: none !important;
    }
    table.normalBoardWr tbody td{
        text-align: center !important;
        border-left: 1px solid #efefef !important;
    }
    table.normalBoardWr tbody .tLine{
        border-top: 1px solid #666666 !important;
    }
    table.normalBoardWr tbody td:nth-child(2){
        border-left: none !important;
    }
</style>
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <div class="chart">
        현재 표시중인 날짜 : <input type="text" id="date" value="${dateStr}" readonly onchange="location.href=this.value">
        </select>
        <div id="chart-div"></div>
    </div>
    <table class="normalBoardWr first">
        <thead>
        <tr>
            <th>일간 예약현황</th>
            <c:forEach items="${week[0].data}" var="date" varStatus="status">
                <th>${date.time}</th>
            </c:forEach>
            <th>합계</th>
        </tr>
        </thead>
        <tbody>
            <tr>
                <th>${dateStr}</th>
                <c:set var="total" value="0"/>
                <c:forEach items="${day}" var="date">
                    <fmt:formatNumber value="${date.count}" var="cnt" pattern="#"/>
                    <c:set var="total" value="${total + cnt}"/>
                    <td>${date.count}</td>
                </c:forEach>
                <td><b>${total}</b></td>
            </tr>
        </tbody>
    </table>
    <div class="chart">
        <div id="chart-div2"></div>
    </div>
    <table class="normalBoardWr">
        <thead>
            <tr>
                <th>주간 예약현황</th>
                <c:forEach items="${week[0].data}" var="date" varStatus="status">
                    <th>${date.time}</th></c:forEach>
                <th>합계</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${week}" var="date" varStatus="status">
                <tr>
                    <th>${date.date}</th>
                    <c:set var="total" value="0"/>
                    <c:forEach items="${date.data}" var="day">
                        <fmt:formatNumber value="${day.count}" var="cnt" pattern="#"/>
                        <c:set var="total" value="${total + cnt}"/>
                        <td>${day.count}</td>
                    </c:forEach>
                    <td><b>${total}</b></td>
                </tr>
            </c:forEach>
            <tr>
                <th class="tLine">총합</th>
                <c:set var="total" value="0"/>
                <c:forEach items="${sumOfTime}" var="sum" varStatus="status">
                    <fmt:formatNumber value="${sum.count}" var="cnt" pattern="#"/>
                    <c:set var="total" value="${total + cnt}"/>
                    <td class="tLine"><b>${sum.count}</b></td>
                </c:forEach>
                <td class="tLine"><b>${total}</b></td>
            </tr>
        </tbody>
    </table>
</div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        yearSuffix: '년'
    });

    $("#date").datepicker({
        minDate: new Date('2021-12-04'),
        maxDate: new Date('2021-12-31')
    });

    google.charts.load('current', {packages: ['corechart', 'bar']});
    google.charts.setOnLoadCallback(drawChart);
    google.charts.setOnLoadCallback(chartSecond);

    function drawChart() {
        var data = google.visualization.arrayToDataTable([
            ['시간', '인원수', {role: 'style'}],
            <c:forEach items="${day}" var="date">['${date.time}', ${date.count}, 'color: #ff6200'],
            </c:forEach>
        ]);

        var options = {
            title: '${dateStr} 유등축제 예약인원 수',
            width: '100%',
            bar: {groupWidth: "95%"},
            legend: { position: "none" },
        };

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
            { calc: "stringify",
                sourceColumn: 1,
                type: "string",
                role: "annotation" },
            2]);


        var chart = new google.visualization.ColumnChart(document.getElementById('chart-div'));

        chart.draw(view, options);
    }

    function chartSecond() {
        var data = google.visualization.arrayToDataTable([
            ["시간", <c:forEach items="${week}" var="date" varStatus="status">"${date.date}"<c:if test="${status.index lt (week.size()-1)}">, </c:if></c:forEach>],
            <c:forEach items="${week[0].data}" var="date" varStatus="status">
            ["${date.time}", <c:forEach items="${week}" varStatus="num">${week[num.index].data[status.index].count}<c:if test="${num.index lt (week.size()-1)}">, </c:if></c:forEach>],
            </c:forEach>
        ]);

        var options = {
            chart: {
                title: '${start} ~ ${end} 유등축제 예약 그래프',
                // subtitle: 'Sales, Expenses, and Profit: 2014-2017',
            }
        };

        var chart = new google.charts.Bar(document.getElementById('chart-div2'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
    }


</script>