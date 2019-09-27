<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="adminDetailed.aspx.cs" Inherits="ReachHelpWF.main.adminDetailed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="page-title">
            <div class="title_left">
                <h3 class="trn">Detailed Info</h3>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="row">
            <div class="col-md-3 form-group">
                <label>Date Period</label>
                <select class="form-control" id="dataperiod">
                    <option value="">Select One</option>
                    <option value="Daily">Daily</option>
                    <option value="Weekly">Weekly</option>
                    <option value="Monthly">Monthly</option>
                </select>
            </div>
            <div class="col-md-3 form-group">
                <label>Select Date Range</label>
                <input type="text" id="daterange" class="form-control" />
                <small style="color: red; display: none" id="showdaily"><i>if Date period is daily, can select max 90 days</i></small>
            </div>
            <div class="col-md-3 form-group">
                <button type="button" id="searchdata" class="btn btn-success" style="margin-top: 24px">Search</button>
            </div>
        </div>
        <div class="row" style="display: flex; flex-wrap: wrap;">
            <div class="col-md-6" id="DetailedTotalLatency" style="margin:40px 0"> </div>
            <div class="col-md-6" id="DetailedAverageLatency" style="margin:40px 0"> </div>
            <div class="col-md-6" id="DetailedRatings" style="margin:40px 0"> </div>
            <div class="col-md-6" id="DetailedAmount" style="margin:40px 0"> </div>
            <div class="col-md-6" id="DetailedUserRegistrationDetails" style="margin:40px 0"> </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptIncludesPlaceHolder" runat="server">
    <script>
        $("#dataperiod").change(function () {
            var period = $(this).val();

            if (period == "Daily") {
                $("#showdaily").show();
                $("#daterange").daterangepicker({
                    "dateLimit": {
                        "days": 90
                    },
                    locale: {
                        format: 'YYYY/MM/DD'
                    }
                });
            } else {
                $("#showdaily").hide();
                $("#daterange").daterangepicker({
                    locale: {
                        format: 'YYYY/MM/DD'
                    }
                });
            }
        });



        $("#searchdata").click(function () {
            var dataperiod = $("#dataperiod").val();
            var daterange = $("#daterange").val();

            if (dataperiod == "") {
                swal("Required", "Select date period", "error");
                return false;
            } else if (daterange == "") {
                swal("Required", "Select date range", "error");
                return false;
            }

            var dataObj = {
                startDate: (daterange.split("-")[0]).replace(/ /, ""),
                endDate: (daterange.split("-")[1]).replace(/ /, ""),
                type: dataperiod
            }


            ajaxfunctioncallwithdata('POST', './adminDetailed.aspx/DetailedTotalLatency', dataObj, true).then(function (data) {
                console.log(data.d);
                var reportsdata = data.d;
                $("#DetailedTotalLatency").empty();
                $("<h3>").html("Detailed Total Latency").appendTo("#DetailedTotalLatency");
                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'DetailedTotalLatency_Table' }).css({ 'width': '100%' }).appendTo('#DetailedTotalLatency');
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#DetailedTotalLatency_Table thead');

                $('<th>').html('#').appendTo('#DetailedTotalLatency_Table thead tr');
                $('<th>').html(dataperiod).appendTo('#DetailedTotalLatency_Table thead tr');
                $('<th>').html('Total Latency').appendTo('#DetailedTotalLatency_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        $('<tr>').attr({ id: 'DetailedTotalLatency_Table' + data }).appendTo('#DetailedTotalLatency_Table tbody');
                        $('<td>').html(Number(data) + 1).appendTo('#DetailedTotalLatency_Table' + data);
                        $('<td>').html(reportsdata[data].number).appendTo('#DetailedTotalLatency_Table' + data);
                        $('<td>').html(reportsdata[data].days + "d " + reportsdata[data].hours + "h " + reportsdata[data].minutes + "m ").appendTo('#DetailedTotalLatency_Table' + data);
                    }
                }
                $('#DetailedTotalLatency_Table').DataTable();
            });

            ajaxfunctioncallwithdata('POST', './adminDetailed.aspx/DetailedAverageLatency', dataObj, true).then(function (data) {
                console.log(data.d);
                var reportsdata = data.d;
                $("#DetailedAverageLatency").empty();
                $("<h3>").html("Detailed Average Latency").appendTo("#DetailedAverageLatency");
                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'DetailedAverageLatency_Table' }).css({ 'width': '100%' }).appendTo('#DetailedAverageLatency');
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#DetailedAverageLatency_Table thead');

                $('<th>').html('#').appendTo('#DetailedAverageLatency_Table thead tr');
                $('<th>').html(dataperiod).appendTo('#DetailedAverageLatency_Table thead tr');
                $('<th>').html('Avg Latency').appendTo('#DetailedAverageLatency_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        $('<tr>').attr({ id: 'DetailedAverageLatency_Table' + data }).appendTo('#DetailedAverageLatency_Table tbody');
                        $('<td>').html(Number(data) + 1).appendTo('#DetailedAverageLatency_Table' + data);
                        $('<td>').html(reportsdata[data].number).appendTo('#DetailedAverageLatency_Table' + data);
                        $('<td>').html(reportsdata[data].days + "d " + reportsdata[data].hours + "h " + reportsdata[data].minutes + "m ").appendTo('#DetailedAverageLatency_Table' + data);
                    }
                }
                $('#DetailedAverageLatency_Table').DataTable();
            });

            ajaxfunctioncallwithdata('POST', './adminDetailed.aspx/DetailedRatings', dataObj, true).then(function (data) {
                console.log(data);
                var reportsdata = data.d;
                $("#DetailedRatings").empty();
                $("<h3>").html("Detailed Ratings").appendTo("#DetailedRatings");
                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'DetailedRatings_Table' }).css({ 'width': '100%' }).appendTo('#DetailedRatings');
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#DetailedRatings_Table thead');
                $('<th>').html('#').appendTo('#DetailedRatings_Table thead tr');
                $('<th>').html(dataperiod).appendTo('#DetailedRatings_Table thead tr');
                $('<th>').html('Avg. Rating').appendTo('#DetailedRatings_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        $('<tr>').attr({ id: 'DetailedRatings_Table' + data }).appendTo('#DetailedRatings_Table tbody');
                        $('<td>').html(Number(data) + 1).appendTo('#DetailedRatings_Table' + data);
                        $('<td>').html(reportsdata[data].number).appendTo('#DetailedRatings_Table' + data);
                        $('<td>').html(reportsdata[data].ratingCount).appendTo('#DetailedRatings_Table' + data);
                    }
                }
                $('#DetailedRatings_Table').DataTable();
            });

            ajaxfunctioncallwithdata('POST', './adminDetailed.aspx/DetailedAmount', dataObj, true).then(function (data) {
                console.log(data);
                var reportsdata = data.d;
                $("#DetailedAmount").empty();
                $("<h3>").html("Detailed Amount").appendTo("#DetailedAmount");
                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'DetailedAmount_Table' }).css({ 'width': '100%' }).appendTo('#DetailedAmount');
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#DetailedAmount_Table thead');
                $('<th>').html('#').appendTo('#DetailedAmount_Table thead tr');
                $('<th>').html(dataperiod).appendTo('#DetailedAmount_Table thead tr');
                $('<th>').html('Amount').appendTo('#DetailedAmount_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        $('<tr>').attr({ id: 'DetailedAmount_Table' + data }).appendTo('#DetailedAmount_Table tbody');
                        $('<td>').html(Number(data) + 1).appendTo('#DetailedAmount_Table' + data);
                        $('<td>').html(reportsdata[data].number).appendTo('#DetailedAmount_Table' + data);
                        $('<td>').html(reportsdata[data].amount).appendTo('#DetailedAmount_Table' + data);
                    }
                }
                $('#DetailedAmount_Table').DataTable();
            });

            ajaxfunctioncallwithdata('POST', './adminDetailed.aspx/DetailedUserRegistrationDetails', dataObj, true).then(function (data) {
                console.log(data);
                var reportsdata = data.d;
                $("#DetailedUserRegistrationDetails").empty();
                $("<h3>").html("Detailed User Registration").appendTo("#DetailedUserRegistrationDetails");
                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'DetailedUserRegistrationDetails_Table' }).css({ 'width': '100%' }).appendTo('#DetailedUserRegistrationDetails');
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#DetailedUserRegistrationDetails_Table thead');
                $('<th>').html('#').appendTo('#DetailedUserRegistrationDetails_Table thead tr');
                $('<th>').html(dataperiod).appendTo('#DetailedUserRegistrationDetails_Table thead tr');
                $('<th>').html('User Count').appendTo('#DetailedUserRegistrationDetails_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        $('<tr>').attr({ id: 'DetailedUserRegistrationDetails_Table' + data }).appendTo('#DetailedUserRegistrationDetails_Table tbody');
                        $('<td>').html(Number(data) + 1).appendTo('#DetailedUserRegistrationDetails_Table' + data);
                        $('<td>').html(reportsdata[data].number).appendTo('#DetailedUserRegistrationDetails_Table' + data);
                        $('<td>').html(reportsdata[data].userCount).appendTo('#DetailedUserRegistrationDetails_Table' + data);
                    }
                }
                $('#DetailedUserRegistrationDetails_Table').DataTable();
            });
        });

    </script>
</asp:Content>
