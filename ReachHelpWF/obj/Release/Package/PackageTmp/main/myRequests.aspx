<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="myRequests.aspx.cs" Inherits="ReachHelpWF.main.myRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">My Needs</h3>
                </div>
                <a href="requestHelp" class="btn btn-sm btn-round btn-primary trn" style="margin: 5px 0 0 0;">Post Need</a>

                <%--<div class="title_right">                    
                    <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">Go!</button>
                            </span>
                        </div>
                    </div>
                </div>--%>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12" style="width:100%">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2><small>List of all your previous requests.</small></h2>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-md-6 col-xs-12" style="overflow-x: auto">
                                    <div id="myRequestsDiv">
                                        <ul class="list-unstyled req_resp_list">
                                        </ul>

                                        <ul class="pagination pagination-split pull-right" id="myRequestsPagination">
                                        </ul>
                                    </div>

                                    <%--<table class="table table-striped" id="myRequestsTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th class="trn">Request Info</th>--%>
                                    <%--<th class="trn">Expected Date</th> COMMENTED--%>
                                    <%--<th class="trn">Posted Date</th>
                                                <th class="trn">Status</th>
                                                <th class="trn">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="7" style="text-align: center;">
                                                    <h3 class="trn">-- No Data --</h3>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>--%>
                                </div>

                                <div class="col-md-6 col-xs-12" style="overflow-x: auto">
                                    <div id="myRequestResponseDiv">
                                        <ul class="list-unstyled req_resp_list">
                                        </ul>

                                        <ul class="pagination pagination-split pull-right" id="responsePagination">
                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--<div class="row" id="offersTableCont" style="display: none">
                    <div class="col-md-12">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2 class="trn">Available Offer for<small id="requestInfo">Selected Request Info</small></h2>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="row">
                                    <div class="col-xs-12 table" style="overflow-x: auto">
                                        <table class="table table-striped" id="offersTable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th class="trn">Offer Info</th>
                                                    <th class="trn">Offered By</th>
                                                    <th class="trn">Delivery Mode</th>
                                                    <th class="trn">Delivery Address</th>
                                                    <th class="trn">Status</th>--%>
                                                    <%--<th class="trn">Credits</th>
                                                <th class="trn">Actions</th> COMMENTED--%>
                                                <%--</tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td colspan="7" style="text-align: center;">
                                                        <h3 class="trn">-- No Data --</h3>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                </div>


            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptIncludesPlaceHolder" runat="server">
    <script>
        var mr_totalRequests = 0, mr_totalResponses = 0;
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));

            //myRequests();
            getMyRequest(1);
        })()

        //function myRequests() {
        //    ajaxfunctioncallwithdata("POST", "./myRequests.aspx/MyRequests", { userId: 'GET FROM SESSION' }, true)
        //    .then(function (resp) {
        //        //console.log(resp.d);
        //        var myRequestList = resp.d;
        //        var myReqTableBody = $('#myRequestsTable').find('tbody');

        //        if ($.fn.dataTable.isDataTable('#myRequestsTable')) {
        //            $('#myRequestsTable').DataTable().clear().destroy();
        //        }
        //        myReqTableBody.empty();

        //        if (myRequestList.length > 0) {

        //            myRequestList.forEach(function (elem, index, arr) {
        //                var tr = $('<tr>').attr({ 'data-reqid': elem.requestId })/*.bind('click', function () {
        //                    var reqInfo = { reqId: $(this).attr('data-reqid'), reqName: $(this).find('td:eq(2)').text(), reqQty: $(this).attr('data-qtyInfo') };
        //                    $(this).find('td:eq(0) input').iCheck('check');
        //                    displayRequestOfferInfo(reqInfo);
        //                })*/.appendTo(myReqTableBody);
        //                var td0 = $('<td>').appendTo(tr);
        //                var myReqRad = $('<input>').attr({ type: 'radio', name: 'radMyReq' })/*.on('ifClicked', function () {
        //                    var reqInfo = { reqId: $(this).parents('tr').attr('data-reqid'), reqName: $(this).parents('tr').find('td:eq(2)').text(), reqQty: $(this).parents('tr').attr('data-qtyInfo') };
        //                    //$(this).parents('tr').find('td:eq(0) input').iCheck('check');
        //                    alert(reqInfo.reqId+" : "+reqInfo.reqName);
        //                    displayRequestOfferInfo(reqInfo);
        //                })*/.addClass('flat myReqRad').appendTo(td0);
        //                var td1 = $('<td>').text(parseInt(index) + 1).appendTo(tr);
        //                var reqText = elem.requestSubCategoryName + "  ";
        //                var td2 = $('<td>').html(reqText).appendTo(tr);
        //                if (elem.requestQuantity > 0 || elem.requestQuantity != "-1") {
        //                    var qtyInfo = elem.requestQuantity + " " + elem.requestUnit;
        //                    tr.attr({ 'data-reqInfo': elem.requestSubCategoryName, 'data-qtyInfo': elem.requestQuantity + " " + elem.requestUnit });
        //                    //var qtyLbl = $('<label>').addClass('label label-xs label-info').css({ margin: '0 0 0 5px' }).text(qtyInfo).appendTo(td2);
        //                }
        //                //var td3 = $('<td>').text(elem.requestExpectedDate).appendTo(tr);
        //                var td4 = $('<td>').text(elem.requestPostedDate).appendTo(tr);
        //                var td5 = $('<td>').text(elem.requestStatus).appendTo(tr);
        //                //var refStatusCont = $('<span>').addClass('pull-right').css({ 'font-size': 'large', color: 'orange', margin: '0 5px' }).appendTo(td5)
        //                //$('<i>').addClass('fa fa-refresh').appendTo(refStatusCont);
        //                var td6 = $('<td>').appendTo(tr);
        //                if (elem.requestStatus == "Pending") {
        //                    var delSpan = $('<span>').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).on('click', cancelRequest).appendTo(td6);
        //                    $('<i>').addClass('fa fa-trash').appendTo(delSpan);
        //                }
        //            });

        //            $('#myRequestsTable').DataTable({
        //                //destroy: true,
        //                //responsive: true,
        //                pageLength: 5,
        //                bLengthChange: false,
        //                bFilter: true,
        //            });

        //            $('#myRequestsTable').on('draw.dt', function () {
        //                $('input.myReqRad').iCheck({
        //                    radioClass: 'iradio_flat-green'
        //                }).on('ifChecked', function () {
        //                    var reqInfo = { reqId: $(this).parents('tr').attr('data-reqid'), reqName: $(this).parents('tr').find('td:eq(2)').text(), reqQty: $(this).parents('tr').attr('data-qtyInfo') };
        //                    //$(this).parents('tr').find('td:eq(0) input').iCheck('check');                         
        //                    displayRequestOfferInfo(reqInfo);
        //                });
        //            });

        //            //$('#myRequestsTable').on('draw.dt', function () {
        //            //    $('input.flat').iCheck({
        //            //        checkboxClass: 'icheckbox_flat-green',
        //            //        radioClass: 'iradio_flat-green'
        //            //    });
        //            //});

        //        }
        //        $('input.myReqRad').iCheck({
        //            //checkboxClass: 'icheckbox_flat-green',
        //            radioClass: 'iradio_flat-green'
        //        }).on('ifChecked', function () {
        //            var reqInfo = { reqId: $(this).parents('tr').attr('data-reqid'), reqName: $(this).parents('tr').find('td:eq(2)').text(), reqQty: $(this).parents('tr').attr('data-qtyInfo') };
        //            //$(this).parents('tr').find('td:eq(0) input').iCheck('check');                         
        //            displayRequestOfferInfo(reqInfo);
        //        });
        //    });
        //}


        //function displayRequestOfferInfo(reqInfo) {
        //    $('#requestInfo').text(reqInfo.reqName);
        //    $('#offersTableCont').slideDown();

        //    //AvailableOffersList(string requestId)
        //    ajaxfunctioncallwithdata("POST", "./myRequests.aspx/AvailableOffersList", { requestId: reqInfo.reqId }, true)
        //    .then(function (resp) {
        //        console.log(resp.d);
        //        var reqOffersTableBody = $('#offersTable').find('tbody');
        //        var reqOffersList = resp.d;

        //        if ($.fn.dataTable.isDataTable('#offersTable')) {
        //            $('#offersTable').DataTable().clear().destroy();
        //        }
        //        reqOffersTableBody.empty();

        //        if (reqOffersList.length > 0) {

        //            reqOffersList.forEach(function (elem, index, arr) {
        //                var tr = $('<tr>').attr({ 'data-offerid': elem.offerId }).appendTo(reqOffersTableBody);
        //                var td0 = $('<td>').text(parseInt(index) + 1).appendTo(tr);
        //                //var td1 = $('<td>').text(elem.offerQuantity + " " + elem.offerUnit).appendTo(tr);
        //                var td1 = $('<td>').text(reqInfo.reqName).appendTo(tr);

        //                var offerdByPhNoEMail = elem.offeredByName + "(Tel: " + elem.phoneNumber + ", Email: " + (elem.emailId == "" ? "NA" : elem.emailId) + ")";
        //                var td2 = $('<td>').html(offerdByPhNoEMail).appendTo(tr);
        //                var td3 = $('<td>').text(elem.offerDeliveryMode).appendTo(tr);
        //                var td4 = $('<td>').text((elem.offerDeliveryAddress == null ? "NA" : elem.offerDeliveryAddress)).appendTo(tr);
        //                var td5 = $('<td>').text(elem.offerStatus).appendTo(tr);
        //                //var refStatusCont = $('<span>').addClass('pull-right').css({ 'font-size': 'large', color: 'orange', margin: '0 5px' }).appendTo(td5)
        //                //$('<i>').addClass('fa fa-refresh').appendTo(refStatusCont);
        //                //var td7 = $("<span style='font-size: 12pt;'>" + elem.credits + "</span><i class='fa fa-thumbs-up' style='color: orange;'></i>").appendTo(tr);
        //                /*var td6 = $('<td>').appendTo(tr);
        //                var reqOfferStatus = elem.offerStatus;
        //                var actionSpan = $('<span>').appendTo(td6);
        //                if (reqOfferStatus == "Pending") {
        //                    $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-primary').text("Request").on('click', sendRequestForOffer).appendTo(actionSpan);
        //                }
        //                else if (reqOfferStatus == "Respond") {
        //                    $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-danger').text("Reject").bind('click', confirmRejectOffer).appendTo(actionSpan);
        //                    if (elem.offerQuantity != "") {
        //                        $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-success').text("Confirm").bind('click', confirmRejectOffer).appendTo(actionSpan);
        //                    }
        //                    else {
        //                        $('<label>').addClass('label label-xs label-warning').text('Waiting for Response...').appendTo(td1);
        //                    }
        //                }*/
        //            });

        //            $('#offersTable').DataTable({
        //                //destroy: true,
        //                //responsive: true,
        //                pageLength: 5,
        //                bLengthChange: false,
        //                bFilter: true,
        //            });

        //            //$('#offersTable').on('draw.dt', function () {
        //            //    $('input.flat').iCheck({
        //            //        checkboxClass: 'icheckbox_flat-green',
        //            //        radioClass: 'iradio_flat-green'
        //            //    });
        //            //});

        //        }
        //        else {
        //            reqOffersTableBody.empty();
        //            var tr = $('<tr>').appendTo(reqOffersTableBody);
        //            $('<td>').attr({ colspan: '7' }).css({ 'text-align': 'center' }).html('<h3> -- No Offers match your Requirement-- </h3>').appendTo(tr);
        //        }

        //        $("html, body").animate({ scrollTop: $('#offersTable').offset().top }, 600);
        //    });

        //}


        function sendRequestForOffer(ev) {
            /*var reqId = $('.myReqRad:checked').parents('tr').data('reqid'),
                offerId = $(ev.target).parents('tr').data('offerid');*/

            var reqId = $('.myReqRad:checked').parents('li').data('reqid'),
                offerId = $(ev.target).parents('li').data('offerid');

            var offerResponseObj = {
                offerId: offerId,
                requestId: reqId
            };

            ajaxfunctioncallwithdata("POST", "./myRequests.aspx/RequestOffer", { offerResponse: offerResponseObj }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    swal("Success!", 'Request sent', 'success');
                    //displayRequestOfferInfo({ reqId: reqId });
                    getResponses(1);
                    $('.myReqRad:checked').removeAttr('checked');
                    $('#offersTable').find('tbody').empty();
                    $('#offersTableCont').slideUp();
                }
                else {
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        }

        function confirmRejectOffer(obj) {
            console.log("ACCEPT REJECT STATUS : ", $(obj.target).parents('li'));
            var confirmRejectObj = {
                offerId: $(obj.target).parents('li').attr('data-offerid'),
                requestId: $('.myReqRad:checked').parents('li').attr('data-reqid'),
                offerStatus: ($(obj.target).text())
            };

            ajaxfunctioncallwithdata("POST", "./myRequests.aspx/ConfirmOffer", { offerResponse: confirmRejectObj }, true)
            .then(function (resp) {
                console.log("Confirm/Reject",resp.d);
                if (resp.d) {
                    swal("Success!", 'Offer Confirmed', 'success');
                    //displayRequestOfferInfo({ reqId: confirmRejectObj.requestId });
                    getResponses(1);
                }
                else {
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        }

        function cancelRequest(ev) {
            //var requestId = $(ev.target).parents('tr').attr('data-reqid');
            var requestId = $(ev.target).parents('li').attr('data-reqid');
            ajaxfunctioncallwithdata("POST", "./myRequests.aspx/CancelRequest", { requestId: requestId }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    swal("Success!", 'Offer Cancelled', 'success');
                    //myRequests();
                    getMyRequest(1);
                }
                else {
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        }

        function starclick(val,rid) {
            var objs = {
                requestId: rid,
                rating: val
            }
            console.log(objs);
            ajaxfunctioncallwithdata('POST', './myRequests.aspx/RateOffer', objs, true).then(function (data) {
                console.log(data);
                if (data.d) {
                    swal("Rating Updated Successfully!");
                } else {
                    swal("Error Updating!");
                }
            });
        }

        function getMyRequest(pagenum) {

            var noofRowsPerPage = 5;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                userId: sessionStorage.getItem('userId'),
                startValue: startValue,
                noOfRows: noofRowsPerPage
            }
            ajaxfunctioncallwithdata('POST', './myRequests.aspx/MyRequests', objs, true).then(function (resp) {
                var myRequests = resp.d;
                console.log(myRequests);
                var myRequestDiv = $('#myRequestsDiv').find('ul.req_resp_list');
                myRequestDiv.empty();                
                if (myRequests.length > 0) {

                    myRequests.map(function (elem, index, arr) {                        
                        mr_totalRequests = elem.count;
                        var myReqLi = $('<li>').attr({ 'data-reqid': elem.requestId }).appendTo('#myRequestsDiv ul.req_resp_list');
                        if (elem.requestQuantity > 0 || elem.requestQuantity != "-1") {
                            myReqLi.attr({ 'data-reqInfo': elem.requestSubCategoryName, 'data-qtyInfo': elem.requestQuantity + " " + elem.requestUnit });
                        }
                        var myReqAnchor = $('<a>').appendTo(myReqLi);
                        var myReqRadSpan = $('<span>').addClass('image').appendTo(myReqAnchor);
                        $('<input>').attr({ type: 'radio', name: 'radMyReq' }).addClass('flat myReqRad').appendTo(myReqRadSpan);
                        var myReqContentSpan = $('<span>').appendTo(myReqAnchor);
                        $('<span>').addClass('info').text(elem.requestSubCategoryName).appendTo(myReqAnchor);
                        $('<span>').addClass('time').text(elem.requestPostedDate).appendTo(myReqAnchor);
                        $('<span>').addClass('status').text(elem.requestStatus).appendTo(myReqAnchor);
                        if (elem.requestStatus == "Pending") {
                            var myReqActionDiv = $('<span>').addClass('action').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).on('click', cancelRequest).appendTo(myReqAnchor);
                            $('<i>').addClass('fa fa-trash').appendTo(myReqActionDiv);
                        }
                        if (elem.requestStatus == "Accepted") {
                            var myReqAction1 = $('<div>').appendTo(myReqAnchor);
                            $("<input>").attr({ "type": "hidden", "id": "rate-" + elem.requestId, "data-rid": elem.requestId }).appendTo(myReqAction1);

                            $("#rate-" + elem.requestId).webwidget_rating_simple({
                                rating_star_length: '5',
                                rating_initial_value: elem.rating,
                                rating_function_name: 'starclick',//this is function name for click
                                directory: 'vendors/rating'
                            });
                        }

                    });

                   

                    $('input.myReqRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    }).on('ifChecked', function () {
                        //var reqInfo = { reqId: $(this).parents('li').attr('data-reqid'), reqName: $(this).parents('li').find('span.info').text(), reqQty: $(this).parents('li').attr('data-qtyInfo') };                                          
                        getResponses(1);
                    });
                }
                else {                    
                    $('<li>').text('-- No Requests Made -- ').css({ display:'block','text-align': 'center' }).appendTo(myRequestDiv);
                }




                var totalNoofPages = Math.ceil(mr_totalRequests / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#myRequestsPagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getMyRequest(1)">FIRST</a></li>').appendTo("#myRequestsPagination");
                    $('<li><a href="#" onclick="getMyRequest(' + (page - 1) + ')"><<</a></li>').appendTo("#myRequestsPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getMyRequest(' + i + ')">' + i + '</a></li>').appendTo("#myRequestsPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getMyRequest(' + (page + 1) + ')">>></a></li>').appendTo("#myRequestsPagination");
                    $('<li><a href="#" onclick="getMyRequest(' + totalNoofPages + ')">LAST</a></li>').appendTo("#myRequestsPagination");
                }


            });
            
            
        }


        function getResponses(pagenum) {

            var selReq = $('#myRequestsDiv ul.req_resp_list li input.myReqRad:checked')[0];
            var requestInfo = {
                reqId: $(selReq).parents('li').attr('data-reqid'),
                reqName: $(selReq).parents('li').attr('data-reqinfo'),
                reqQty: $(selReq).parents('li').attr('data-qtyinfo')
            }

            var noofRowsPerPage = 5;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                requestId: requestInfo.reqId,
                startValue: startValue,
                noOfRows: noofRowsPerPage
            }

            console.log(objs);

            ajaxfunctioncallwithdata('POST', './myRequests.aspx/AvailableOffersList', objs, true).then(function (resp) {
                var responses = resp.d;
                console.log(responses, responses.length);
                var responseDiv = $('#myRequestResponseDiv').find('ul.req_resp_list');
                responseDiv.empty();                
                if (responses.length > 0) {
                    responses.map(function (elem, index, arr) {                        
                        mr_totalResponses = elem.count;                        
                        var myRespLi = $('<li>').attr({ 'data-offerid': elem.offerId, 'data-offeredby': elem.offeredById }).appendTo('#myRequestResponseDiv ul.req_resp_list');
                        var myRespAnchor = $('<a>').appendTo(myRespLi);
                        var respRadSpan = $('<span>').addClass('image').appendTo(myRespAnchor);
                        $('<input>').attr({ type: 'radio', name: 'radResp' }).addClass('flat respRad').appendTo(respRadSpan);
                        var myRespContentSpan = $('<span>').appendTo(myRespAnchor);
                        $('<span>').addClass('info').text(requestInfo.reqName).appendTo(myRespAnchor);
                        $('<span>').addClass('time').text(elem.offeredByName).appendTo(myRespAnchor);
                        $('<span>').addClass('status').text(elem.requestStatus).appendTo(myRespAnchor);
                        var otherInfo = $('<span>').addClass('message').appendTo(myRespAnchor);
                        //$('<span><strong>By</strong>: ' + elem.offeredByName + '</span><br/>').appendTo(otherInfo);
                        $('<span><strong>Tel</strong>: ' + elem.phoneNumber + '</span>').appendTo(otherInfo);
                        $('<span><strong>Email</strong>: ' + (elem.emailId == "" ? "NA" : elem.emailId) + '</span><br/>').css({ 'margin-left': '15px', position: 'relative' }).appendTo(otherInfo);
                        $('<span><strong>Delivery Mode</strong>: ' + elem.offerDeliveryMode + '</span>').appendTo(otherInfo);
                        $('<span><strong>Address</strong>: ' + (elem.offerDeliveryAddress == null ? "NA" : elem.offerDeliveryAddress) + '</span>').css({ right: '295px', position: 'absolute' }).appendTo(otherInfo);

                        var reqOfferStatus = elem.offerStatus;
                        var actionSpan = $('<span>').css({position: 'relative','margin-top': '50px', 'margin-left': '150px'}).appendTo(myRespLi);
                        if (reqOfferStatus == "Pending") {
                            console.info("MAKE REQUEST BUTTON");
                            $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-primary').text("Request").on('click', sendRequestForOffer).appendTo(actionSpan);
                        }
                        else if (reqOfferStatus == "Respond") {
                            $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-danger').text("Reject").bind('click', confirmRejectOffer).appendTo(actionSpan);
                            if (elem.offerQuantity != "") {
                                $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-success').text("Confirm").bind('click', confirmRejectOffer).appendTo(actionSpan);
                            }
                            else {
                                $('<label>').addClass('label label-xs label-warning').text('Waiting for Response...').appendTo(myRespLi);
                            }
                        }

                    });

                    $('input.respRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    }).on('ifChecked', function () {
                        getChatMessages_myrequests();                        
                    });
                }
                else {                    
                    $('<li>').text('-- No Offers Available --').css({ display: 'block', 'text-align': 'center' }).appendTo(responseDiv);
                }



                var totalNoofPages = Math.ceil(mr_totalResponses / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#responsePagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getResponses(1)">FIRST</a></li>').appendTo("#responsePagination");
                    $('<li><a href="#" onclick="getResponses(' + (page - 1) + ')"><<</a></li>').appendTo("#responsePagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getResponses(' + i + ')">' + i + '</a></li>').appendTo("#responsePagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getResponses(' + (page + 1) + ')">>></a></li>').appendTo("#responsePagination");
                    $('<li><a href="#" onclick="getResponses(' + totalNoofPages + ')">LAST</a></li>').appendTo("#responsePagination");
                }


            });

            
        }


        $('#sendMessage').on('click', function (e) {
            sendMessage_RequestPage($('#userMessage').val());
            //createChatMessage("Message from other user", "other");
        });

        $('#userMessage').on('keypress', function (e) {
            
            var message = $(this).val();
            if (e.which == 13) {
                e.preventDefault();
                if (message != "") {
                    sendMessage_RequestPage(message);
                    //createChatMessage(message, "me");
                    //$(this).val("");
                }
            }
        });


        function sendMessage_RequestPage(message) {
            var selOffer = $('#myRequestResponseDiv ul.req_resp_list li input.respRad:checked')[0];
            //selRequest = $('#myRequestsDiv ul.req_resp_list li input.myReqRad:checked')[0];
            var offerId = $(selOffer).parents('li').attr('data-offerid'),
                offeredBy = $(selOffer).parents('li').attr('data-offeredby');
            console.log("SEND MESSAGE: ", offerId, offeredBy);

            if (offerId == null) {
                swal("Warning!", "Please select an offer.", "warning");
                return false;
            }


            $.appPost("index.aspx/sendMessage", { messageDetails: { offerId: offerId, requestorUserId: sessionStorage.getItem("userId"), offererUserId: offeredBy, message: message, sentBy: sessionStorage.getItem("userId") } }).then(function (resp) {
                console.log("SEND MESSAGE RESPONSE: ", resp);
                if (resp.d === "success") {
                    var dateTime = moment().format("MM/DD/YYYY, H:mm:ss");
                    createChatMessage(message, "me", dateTime);
                    $('#userMessage').val("");
                }
            })
        }

        $('#refreshChat').on('click', function () {
            getChatMessages_myrequests();
        })


        function getChatMessages_myrequests() {
            var selOffer = $('#myRequestResponseDiv ul.req_resp_list li input.respRad:checked')[0];
                //selRequest = $('#myRequestsDiv ul.req_resp_list li input.myReqRad:checked')[0];
            var offerId = $(selOffer).parents('li').attr('data-offerid'),
                offeredBy = $(selOffer).parents('li').attr('data-offeredby');
            console.log("GET MESSAGE: ", offerId, offeredBy);
            $.appPost("index.aspx/getChatMessages", { offerId: offerId, requestorUserId: sessionStorage.getItem("userId"), offererUserId: offeredBy }).then(function (resp) {
                console.log("GET MESSAGES: ", resp.d);
                var messages = resp.d;
                $('.chatContainer .chat-content').empty();
                messages.forEach(function (msg) {
                    var className = msg.sentBy == sessionStorage.getItem("userId") ? "me" : "other";
                    createChatMessage(msg.message, className, msg.dateTime);
                })
            });
        }


    </script>
</asp:Content>
