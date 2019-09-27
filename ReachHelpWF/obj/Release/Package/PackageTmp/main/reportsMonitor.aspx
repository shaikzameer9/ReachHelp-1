<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="reportsMonitor.aspx.cs" Inherits="ReachHelpWF.main.reportsMonitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <h3>Reports</h3>
                <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                    <label for="selectReport">Select Report*</label>
                    <select id="selectReport" class="form-control select2">
                        <option value="">Select Report</option>
                        <option value="A">Offers Report</option>
                        <option value="B">Offers Report By Category</option>
                        <option value="C">Offers Report By SubCategory</option>
                        <option value="D">Request Report</option>
                        <option value="E">Request Report By Category</option>
                        <option value="F">Request Report By SubCategory</option>
                    </select>
                </div>
                <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                    <label for="selectRegion">Select Region*</label>
                    <select id="selectRegion" class="form-control select2">
                        <option value="">Select Region...</option>
                    </select>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_content">
                            <div class="row">
                                <div class="col-xs-12">

                                    <div class="col-md-12" id="Filters">
                                        <div class="col-md-3 form-group" id="hidefromdate" style="display: none">
                                            <label for="fromdate">Select from Date*</label>
                                            <input type="text" id="fromdate" class="form-control" placeholder="Select From Date" />
                                        </div>
                                        <div class="col-md-3 form-group" id="hidetodate" style="display: none">
                                            <label for="todate">Select to Date*</label>
                                            <input type="text" id="todate" class="form-control" placeholder="Select to Date" />
                                        </div>
                                        <div class="col-md-3 form-group" id="hidecategory" style="display: none">
                                            <label for="selectcat">Select Category*</label>
                                            <select id="selectcat" class="form-control select2">
                                                <option value="">Select Category</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3 form-group" id="hidesubcategory" style="display: none">
                                            <label for="selectsubcat">Select Subcategory*</label>
                                            <select id="selectsubcat" class="form-control select2">
                                                <option value="">Select Subcategory</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3 form-group" id="hidefilterbtn" style="display: none">
                                            <button type="button" class="btn btn-success" id="filterreportsbtn" style="margin-top: 24px;">Filter</button>
                                        </div>
                                    </div>
                                    <div class="col-md-12 table" id="reportstable" style="overflow-x: auto">
                                        <h3 style="text-align: center;">-- Select report above to view data--</h3>
                                    </div>
                                    <div class="col-md-12">
                                        <ul class="pagination pagination-split pull-right" id="reportPagination">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptIncludesPlaceHolder" runat="server">
    <script>
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));
        })()

        $('.select2').select2({ width: '100%' });


        $("#selectRegion").select2({
            width: '100%',
            placeholder: "Select a Region...",
            minimumInputLength: 2,
            ajax: {
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "./reportsMonitor.aspx/SearchRegion",
                dataType: 'json',
                data: function (term, page) {
                    return "{'searchVal':\"" + term.term + "\"}";
                },
                processResults: function (data, params) {
                    params.page = params.page || 1;

                    return {
                        results: data.d,
                        pagination: {
                            more: (params.page * 30) < data.total_count
                        }
                    };
                },
                cache: true
            },
            allowClear: true
        });

        $('#fromdate,#todate').daterangepicker({
            singleDatePicker: true,
            singleClasses: "picker_1",
            locale: {
                format: 'YYYY/MM/DD'
            }
        });

        ajaxfunctioncallwithdata("POST", "./index.aspx/ListCategoryForUser", { languageId: '1' }, true)
            .then(function (resp) {
                var categoryList = resp.d;
                $('#selectcat').empty();
                $('<option>').attr({ value: '' }).text('Select Category').appendTo('#selectcat');
                for (var cat in categoryList) {
                    $('<option>').attr({ value: categoryList[cat].categoryId }).text(categoryList[cat].categoryName).appendTo('#selectcat');
                }
            });

        $('#selectcat').on('change', function () {
            var selCategory = $(this).val();
            $('#selectsubcat').empty();
            ajaxfunctioncallwithdata("POST", "./index.aspx/ListSubCategoryForUser", { categoryId: selCategory, languageId: '1' }, true)
                .then(function (resp) {
                    var categoryList = resp.d;
                    $('<option>').attr({ value: '' }).text('Select SubCategory').appendTo('#selectsubcat');
                    for (var cat in categoryList) {
                        $('<option>').attr({ value: categoryList[cat].subCategoryId }).text(categoryList[cat].subCategoryName).appendTo('#selectsubcat');
                    }
                });
        });

        $("#selectReport").change(function () {
            var val = $(this).val();
            switch (val) {
                case "A":
                case "D": $("#hidefromdate").show();
                    $("#hidetodate").show();
                    $("#hidecategory").hide();
                    $("#hidesubcategory").hide();
                    $("#hidefilterbtn").show();
                    break;
                case "B":
                case "E": $("#hidefromdate").show();
                    $("#hidetodate").show();
                    $("#hidecategory").show();
                    $("#hidesubcategory").hide();
                    $("#hidefilterbtn").show();
                    break;
                case "C":
                case "F": $("#hidefromdate").show();
                    $("#hidetodate").show();
                    $("#hidecategory").show();
                    $("#hidesubcategory").show();
                    $("#hidefilterbtn").show();
                    break;
            }
        });

        $("#filterreportsbtn").click(function () {
            var val = $("#selectReport").val();
            switch (val) {
                case "A": offersReport(1); break;
                case "B": offersReportbycat(1); break;
                case "C": offersReportbysubcat(1); break;
                case "D": requestReport(1); break;
                case "E": requestReportbycat(1); break;
                case "F": requestReportbysubcat(1); break;
            }
        });

        function offersReport(pagenum) {
            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                fromDate: $("#fromdate").val(),
                toDate: $("#todate").val(),
                startValue: startValue,
                noOFRows: noofRowsPerPage,
                cityId: $('#selectRegion').val()
            }

            if (objs.cityId == "") {
                swal("Warning!", "Please select a Region.", "warning");
                return false;
            }

            ajaxfunctioncallwithdata('POST', './reportsMonitor.aspx/OffersReport', objs, false).then(function (resp) {
                var reportsdata = resp.d;
                //console.log(reportsdata, reportsdata.length);
                $('#reportstable').empty();

                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'Report_Table' }).css({ 'width': '100%' }).appendTo("#reportstable");
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#Report_Table thead');

                $('<th>').html('#').appendTo('#Report_Table thead tr');
                $('<th>').html('Sub Category').appendTo('#Report_Table thead tr');
                $('<th>').html('Category').appendTo('#Report_Table thead tr');
                //$('<th>').html('Qty').appendTo('#Report_Table thead tr');
                $('<th>').html('From').appendTo('#Report_Table thead tr');
                $('<th>').html('Date Time').appendTo('#Report_Table thead tr');
                $('<th>').html('Status').appendTo('#Report_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        localStorage.setItem("totalrecords", reportsdata[data].count);
                        $('<tr>').attr({ id: 'Report_Table' + data }).appendTo('#Report_Table tbody');
                        $('<td>').html(parseInt(data) + 1).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerSubCategoryName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerCategoryName).appendTo('#Report_Table' + data);
                        //if (reportsdata[data].offerQuantity < 0) {
                        //    $('<td>').html("NA").appendTo('#Report_Table' + data);
                        //} else {
                        //    $('<td>').html(reportsdata[data].offerQuantity + " " + reportsdata[data].offerUnit).appendTo('#Report_Table' + data);
                        //}
                        $('<td>').html(reportsdata[data].offeredByName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerPostedDate).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerStatus).appendTo('#Report_Table' + data);
                    }
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#reportPagination").empty();
            if (totalNoofPages > 1) {
                if (page > 1) {
                    $('<li><a href="#" onclick="offersReport(1)">FIRST</a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="offersReport(' + (page - 1) + ')"><<</a></li>').appendTo("#reportPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="offersReport(' + i + ')">' + i + '</a></li>').appendTo("#reportPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="offersReport(' + (page + 1) + ')">>></a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="offersReport(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reportPagination");
                }
            }
        }

        function offersReportbycat(pagenum) {
            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                fromDate: $("#fromdate").val(),
                toDate: $("#todate").val(),
                categoryId: $("#selectcat").val(),
                startValue: startValue,
                noOFRows: noofRowsPerPage,
                cityId: $('#selectRegion').val()
            }

            if (objs.cityId == "") {
                swal("Warning!", "Please select a Region.", "warning");
                return false;
            }

            ajaxfunctioncallwithdata('POST', './reportsMonitor.aspx/OffersReportByCategory', objs, false).then(function (resp) {
                var reportsdata = resp.d;
                //console.log(reportsdata, reportsdata.length);
                $('#reportstable').empty();

                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'Report_Table' }).css({ 'width': '100%' }).appendTo("#reportstable");
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#Report_Table thead');

                $('<th>').html('#').appendTo('#Report_Table thead tr');
                $('<th>').html('Sub Category').appendTo('#Report_Table thead tr');
                $('<th>').html('Category').appendTo('#Report_Table thead tr');
                //$('<th>').html('Qty').appendTo('#Report_Table thead tr');
                $('<th>').html('From').appendTo('#Report_Table thead tr');
                $('<th>').html('Date Time').appendTo('#Report_Table thead tr');
                $('<th>').html('Status').appendTo('#Report_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        localStorage.setItem("totalrecords", reportsdata[data].count);
                        $('<tr>').attr({ id: 'Report_Table' + data }).appendTo('#Report_Table tbody');
                        $('<td>').html(parseInt(data) + 1).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerSubCategoryName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerCategoryName).appendTo('#Report_Table' + data);
                        //if (reportsdata[data].offerQuantity < 0) {
                        //    $('<td>').html("NA").appendTo('#Report_Table' + data);
                        //} else {
                        //    $('<td>').html(reportsdata[data].offerQuantity + " " + reportsdata[data].offerUnit).appendTo('#Report_Table' + data);
                        //}
                        $('<td>').html(reportsdata[data].offeredByName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerPostedDate).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerStatus).appendTo('#Report_Table' + data);
                    }
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#reportPagination").empty();
            if (totalNoofPages > 1) {
                if (page > 1) {
                    $('<li><a href="#" onclick="offersReportbycat(1)">FIRST</a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="offersReportbycat(' + (page - 1) + ')"><<</a></li>').appendTo("#reportPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="offersReportbycat(' + i + ')">' + i + '</a></li>').appendTo("#reportPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="offersReportbycat(' + (page + 1) + ')">>></a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="offersReportbycat(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reportPagination");
                }
            }
        }

        function offersReportbysubcat(pagenum) {
            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                fromDate: $("#fromdate").val(),
                toDate: $("#todate").val(),
                subCategoryId: $("#selectsubcat").val(),
                startValue: startValue,
                noOFRows: noofRowsPerPage,
                cityId: $('#selectRegion').val()
            }


            if (objs.cityId == "") {
                swal("Warning!", "Please select a Region.", "warning");
                return false;
            }

            ajaxfunctioncallwithdata('POST', './reportsMonitor.aspx/OffersReportBySubCategory', objs, false).then(function (resp) {
                var reportsdata = resp.d;
                //console.log(reportsdata, reportsdata.length);
                $('#reportstable').empty();

                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'Report_Table' }).css({ 'width': '100%' }).appendTo("#reportstable");
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#Report_Table thead');

                $('<th>').html('#').appendTo('#Report_Table thead tr');
                $('<th>').html('Sub Category').appendTo('#Report_Table thead tr');
                $('<th>').html('Category').appendTo('#Report_Table thead tr');
                //$('<th>').html('Qty').appendTo('#Report_Table thead tr');
                $('<th>').html('From').appendTo('#Report_Table thead tr');
                $('<th>').html('Date Time').appendTo('#Report_Table thead tr');
                $('<th>').html('Status').appendTo('#Report_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        localStorage.setItem("totalrecords", reportsdata[data].count);
                        $('<tr>').attr({ id: 'Report_Table' + data }).appendTo('#Report_Table tbody');
                        $('<td>').html(parseInt(data) + 1).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerSubCategoryName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerCategoryName).appendTo('#Report_Table' + data);
                        //if (reportsdata[data].offerQuantity < 0) {
                        //    $('<td>').html("NA").appendTo('#Report_Table' + data);
                        //} else {
                        //    $('<td>').html(reportsdata[data].offerQuantity + " " + reportsdata[data].offerUnit).appendTo('#Report_Table' + data);
                        //}
                        $('<td>').html(reportsdata[data].offeredByName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerPostedDate).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].offerStatus).appendTo('#Report_Table' + data);
                    }
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#reportPagination").empty();
            if (totalNoofPages > 1) {
                if (page > 1) {
                    $('<li><a href="#" onclick="offersReportbysubcat(1)">FIRST</a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="offersReportbysubcat(' + (page - 1) + ')"><<</a></li>').appendTo("#reportPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="offersReportbysubcat(' + i + ')">' + i + '</a></li>').appendTo("#reportPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="offersReportbysubcat(' + (page + 1) + ')">>></a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="offersReportbysubcat(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reportPagination");
                }
            }
        }

        function requestReport(pagenum) {
            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                fromDate: $("#fromdate").val(),
                toDate: $("#todate").val(),
                startValue: startValue,
                noOFRows: noofRowsPerPage,
                cityId: $('#selectRegion').val()
            }

            if (objs.cityId == "") {
                swal("Warning!", "Please select a Region.", "warning");
                return false;
            }

            ajaxfunctioncallwithdata('POST', './reportsMonitor.aspx/RequestReport', objs, false).then(function (resp) {
                var reportsdata = resp.d;
                //console.log(reportsdata, reportsdata.length);
                $('#reportstable').empty();

                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'Report_Table' }).css({ 'width': '100%' }).appendTo("#reportstable");
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#Report_Table thead');

                $('<th>').html('#').appendTo('#Report_Table thead tr');
                $('<th>').html('Sub Category').appendTo('#Report_Table thead tr');
                $('<th>').html('Category').appendTo('#Report_Table thead tr');
                //$('<th>').html('Qty').appendTo('#Report_Table thead tr');
                $('<th>').html('From').appendTo('#Report_Table thead tr');
                $('<th>').html('Date Time').appendTo('#Report_Table thead tr');
                $('<th>').html('Status').appendTo('#Report_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        localStorage.setItem("totalrecords", reportsdata[data].count);
                        $('<tr>').attr({ id: 'Report_Table' + data }).appendTo('#Report_Table tbody');
                        $('<td>').html(parseInt(data) + 1).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestSubCategoryName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestCategoryName).appendTo('#Report_Table' + data);
                        //if (reportsdata[data].requestQuantity < 0) {
                        //    $('<td>').html("NA").appendTo('#Report_Table' + data);
                        //} else {
                        //    $('<td>').html(reportsdata[data].requestQuantity + " " + reportsdata[data].requestUnit).appendTo('#Report_Table' + data);
                        //}
                        $('<td>').html(reportsdata[data].requestedByName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestPostedDate).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestStatus).appendTo('#Report_Table' + data);
                    }
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#reportPagination").empty();
            if (totalNoofPages > 1) {
                if (page > 1) {
                    $('<li><a href="#" onclick="requestReport(1)">FIRST</a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="requestReport(' + (page - 1) + ')"><<</a></li>').appendTo("#reportPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="requestReport(' + i + ')">' + i + '</a></li>').appendTo("#reportPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="requestReport(' + (page + 1) + ')">>></a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="requestReport(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reportPagination");
                }
            }
        }

        function requestReportbycat(pagenum) {
            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                fromDate: $("#fromdate").val(),
                toDate: $("#todate").val(),
                categoryId: $("#selectcat").val(),
                startValue: startValue,
                noOFRows: noofRowsPerPage,
                cityId: $('#selectRegion').val()
            }

            if (objs.cityId == "") {
                swal("Warning!", "Please select a Region.", "warning");
                return false;
            }

            ajaxfunctioncallwithdata('POST', './reportsMonitor.aspx/RequestReportByCategory', objs, false).then(function (resp) {
                var reportsdata = resp.d;
                //console.log(reportsdata, reportsdata.length);
                $('#reportstable').empty();

                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'Report_Table' }).css({ 'width': '100%' }).appendTo("#reportstable");
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#Report_Table thead');

                $('<th>').html('#').appendTo('#Report_Table thead tr');
                $('<th>').html('Sub Category').appendTo('#Report_Table thead tr');
                $('<th>').html('Category').appendTo('#Report_Table thead tr');
                //$('<th>').html('Qty').appendTo('#Report_Table thead tr');
                $('<th>').html('From').appendTo('#Report_Table thead tr');
                $('<th>').html('Date Time').appendTo('#Report_Table thead tr');
                $('<th>').html('Status').appendTo('#Report_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        localStorage.setItem("totalrecords", reportsdata[data].count);
                        $('<tr>').attr({ id: 'Report_Table' + data }).appendTo('#Report_Table tbody');
                        $('<td>').html(parseInt(data) + 1).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestSubCategoryName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestCategoryName).appendTo('#Report_Table' + data);
                        //if (reportsdata[data].requestQuantity < 0) {
                        //    $('<td>').html("NA").appendTo('#Report_Table' + data);
                        //} else {
                        //    $('<td>').html(reportsdata[data].requestQuantity + " " + reportsdata[data].requestUnit).appendTo('#Report_Table' + data);
                        //}
                        $('<td>').html(reportsdata[data].requestedByName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestPostedDate).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestStatus).appendTo('#Report_Table' + data);
                    }
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#reportPagination").empty();
            if (totalNoofPages > 1) {
                if (page > 1) {
                    $('<li><a href="#" onclick="requestReportbycat(1)">FIRST</a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="requestReportbycat(' + (page - 1) + ')"><<</a></li>').appendTo("#reportPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="requestReportbycat(' + i + ')">' + i + '</a></li>').appendTo("#reportPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="requestReportbycat(' + (page + 1) + ')">>></a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="requestReportbycat(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reportPagination");
                }
            }
        }

        function requestReportbysubcat(pagenum) {
            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                fromDate: $("#fromdate").val(),
                toDate: $("#todate").val(),
                subCategoryId: $("#selectsubcat").val(),
                startValue: startValue,
                noOFRows: noofRowsPerPage,
                cityId: $('#selectRegion').val()
            }

            if (objs.cityId == "") {
                swal("Warning!", "Please select a Region.", "warning");
                return false;
            }

            ajaxfunctioncallwithdata('POST', './reportsMonitor.aspx/RequestReportBySubCategory', objs, false).then(function (resp) {
                var reportsdata = resp.d;
                //console.log(reportsdata, reportsdata.length);
                $('#reportstable').empty();

                var platformTB = $('<table>').addClass('table table-striped').attr({ id: 'Report_Table' }).css({ 'width': '100%' }).appendTo("#reportstable");
                $('<thead>').appendTo(platformTB);
                $('<tr>').appendTo('#Report_Table thead');

                $('<th>').html('#').appendTo('#Report_Table thead tr');
                $('<th>').html('Sub Category').appendTo('#Report_Table thead tr');
                $('<th>').html('Category').appendTo('#Report_Table thead tr');
                //$('<th>').html('Qty').appendTo('#Report_Table thead tr');
                $('<th>').html('From').appendTo('#Report_Table thead tr');
                $('<th>').html('Date Time').appendTo('#Report_Table thead tr');
                $('<th>').html('Status').appendTo('#Report_Table thead tr');

                $('<tbody>').appendTo(platformTB);
                if (reportsdata.length > 0) {
                    for (var data in reportsdata) {
                        localStorage.setItem("totalrecords", reportsdata[data].count);
                        $('<tr>').attr({ id: 'Report_Table' + data }).appendTo('#Report_Table tbody');
                        $('<td>').html(parseInt(data) + 1).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestSubCategoryName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestCategoryName).appendTo('#Report_Table' + data);
                        //if (reportsdata[data].requestQuantity < 0) {
                        //    $('<td>').html("NA").appendTo('#Report_Table' + data);
                        //} else {
                        //    $('<td>').html(reportsdata[data].requestQuantity + " " + reportsdata[data].requestUnit).appendTo('#Report_Table' + data);
                        //}
                        $('<td>').html(reportsdata[data].requestedByName).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestPostedDate).appendTo('#Report_Table' + data);
                        $('<td>').html(reportsdata[data].requestStatus).appendTo('#Report_Table' + data);
                    }
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#reportPagination").empty();
            if (totalNoofPages > 1) {
                if (page > 1) {
                    $('<li><a href="#" onclick="requestReportbysubcat(1)">FIRST</a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="requestReportbysubcat(' + (page - 1) + ')"><<</a></li>').appendTo("#reportPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="requestReportbysubcat(' + i + ')">' + i + '</a></li>').appendTo("#reportPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="requestReportbysubcat(' + (page + 1) + ')">>></a></li>').appendTo("#reportPagination");
                    $('<li><a href="#" onclick="requestReportbysubcat(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reportPagination");
                }
            }
        }


        

    </script>

</asp:Content>
