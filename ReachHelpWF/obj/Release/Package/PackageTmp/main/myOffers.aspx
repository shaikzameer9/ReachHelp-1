<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="myOffers.aspx.cs" Inherits="ReachHelpWF.main.myOffers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">My Offers</h3>
                </div>
                <a href="offerHelp" class="btn btn-sm btn-round btn-primary trn" style="margin: 5px 0 0 0;">I Offer</a>

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
                            <h2><small>List of all your previous offers.</small></h2>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-md-6 col-xs-12" style="overflow-x: auto">

                                    <div id="myOffersDiv">
                                        <ul class="list-unstyled req_resp_list">
                                        </ul>

                                        <ul class="pagination pagination-split pull-right" id="myOffersPagination">
                                        </ul>
                                    </div>

                                    

                                    <%--<table class="table table-striped" id="myOffersTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th class="trn">Offer Info</th>
                                                <th class="trn">Category</th>
                                                <th class="trn">Delivery Mode</th>
                                                <th class="trn">Posted Date</th>
                                                <th class="trn">Status</th>
                                                <th class="trn">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="8" style="text-align: center;">
                                                    <h3 class="trn">-- No Offers Made Recently --</h3>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>--%>
                                </div>

                                <div class="col-md-6 col-xs-12" style="overflow-x: auto">
                                    <div id="reqsForOfferDiv">
                                        <ul class="list-unstyled req_resp_list">
                                        </ul>

                                        <ul class="pagination pagination-split pull-right" id="reqsForOfferPagination">
                                        </ul>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--<div class="row" id="requestsTableCont" style="display: none">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 class="trn">Requests for Offer <small id="offerInfo">Selected Offer Info</small></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-xs-12 table" style="overflow-x: auto">
                                    <table class="table table-striped" id="requestsTable">
                                        <thead>
                                            <tr>
                                                <th>#</th>--%>
            <%--<th class="trn">Requested Quantity</th> COMMENTED--%>
            <%--<th class="trn">Request Info</th>
                                                <th class="trn">Requested By</th>--%>
            <%--<th class="trn">Expected Date</th> COMMENTED--%>
            <%--<th class="trn">Delivery Address</th>
                                                <th class="trn">Status</th>--%>
            <%--<th class="trn">Actions</th> COMMENTED--%>
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
                </div>
            </div>--%>
        </div>
    </div>

    <div class="modal fade bs-example-modal-sm" id="offerRespondModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel2">Offer Response</h4>
                </div>
                <div class="modal-body">
                    <span style="color: crimson;"><b>Note:</b> <i>Warning</i></span>
                    <div class="row">
                        <div class="col-md-12 col-xs-12 form-group">
                            <label for="modalQty">Quantity:</label>
                            <input type="number" id="modalQty" name="modalQty" value="0" min="0" class="form-control" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-xs-12 form-group">
                            <label for="modalUnit">Unit:</label>
                            <select id="modalUnit" class="form-control select2">
                                <option value="">Choose..</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="modalReqRespond">Respond to Request</button>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptIncludesPlaceHolder" runat="server">
    <script>
        var mo_totalOffers = 0, mo_totalRequests = 0;
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));

            //getMyOffersList();
            getMyOffers(1);
        })()

        function getMyOffersList() {
            ajaxfunctioncallwithdata("POST", "./myOffers.aspx/GetMyOffers", { userId: 'GET FROM SESSION' }, true)
            .then(function (resp) {
                //console.log(resp.d);
                var myOffersList = resp.d;
                var myOffersTbody = $('#myOffersTable').find('tbody');

                if ($.fn.dataTable.isDataTable('#myOffersTable')) {
                    $('#myOffersTable').DataTable().clear().destroy();
                }
                myOffersTbody.empty();

                if (myOffersList.length > 0) {

                    myOffersList.forEach(function (elem, index, arr) {
                        var tr = $('<tr>').attr({ 'data-offerid': elem.offerId, 'data-subcat': elem.offerSubCategoryId }).appendTo(myOffersTbody);
                        var td0 = $('<td>').appendTo(tr);
                        var myOfferRad = $('<input>').attr({ type: 'radio', name: 'radMyOffer' })/*.on('ifClicked', function () {
                            populateReqListForOffer($(this).parents('tr').data('offerid'), $(this).parents('tr').find('td:eq(2)').text(), $(this).parents('tr').data('subcat'));
                            $(this).find('td:eq(0) input').iCheck('check');
                        })*/.addClass('flat myOfferRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(index) + 1).appendTo(tr);
                        var td2 = $('<td>').attr({ 'data-offerqty': elem.offerQuantity }).text(elem.offerSubCategoryName + " ").appendTo(tr);
                        //var offerInfoText = elem.offerQuantity + " " + elem.offerUnit;
                        //$('<label>').addClass('label label-info').text(offerInfoText).appendTo(td2);

                        var td3 = $('<td>').text(elem.offerCategoryName).appendTo(tr);
                        var td5 = $('<td>').text(elem.offerDeliveryMode).appendTo(tr);
                        var td4 = $('<td>').text(elem.offerPostedDate).appendTo(tr);
                        var td6 = $('<td>').text(elem.offerStatus).appendTo(tr);
                        var td7 = $('<td>').appendTo(tr);
                        //console.log(elem.offerStatus);
                        if (elem.offerStatus == 'Pending') {
                            var delSpan = $('<span>').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).on('click', cancelOffer).appendTo(td7);
                            $('<i>').addClass('fa fa-trash-o').appendTo(delSpan);
                        }
                    });

                    $('#myOffersTable').DataTable({
                        //destroy: true,
                        //responsive: true,
                        pageLength: 5,
                        bLengthChange: false,
                        bFilter: true,
                    });

                    $('#myOffersTable').on('draw.dt', function () {
                        $('input.myOfferRad').iCheck({
                            //checkboxClass: 'icheckbox_flat-green',
                            radioClass: 'iradio_flat-green'
                        }).on('ifClicked', function () {
                            populateReqListForOffer($(this).parents('tr').data('offerid'), $(this).parents('tr').find('td:eq(2)').text(), $(this).parents('tr').data('subcat'));
                            $(this).find('td:eq(0) input').iCheck('check');
                        });
                    });

                    $('input.myOfferRad').iCheck({
                        //checkboxClass: 'icheckbox_flat-green',
                        radioClass: 'iradio_flat-green'
                    }).on('ifClicked', function () {
                        populateReqListForOffer($(this).parents('tr').data('offerid'), $(this).parents('tr').find('td:eq(2)').text(), $(this).parents('tr').data('subcat'));
                        $(this).find('td:eq(0) input').iCheck('check');
                    });
                }

            });
        }

        function populateReqListForOffer(offerId, offerInfo, offerSubCat) {
            $('#requestsTableCont').slideDown();

            $('#offerInfo').text(offerInfo);

            ajaxfunctioncallwithdata("POST", "./myOffers.aspx/RequestListForOffer", { offerId: offerId }, true)
            .then(function (resp) {
                console.log(resp.d);
                var requestList = resp.d;
                var requestTableBody = $('#requestsTable').find('tbody');

                if ($.fn.dataTable.isDataTable('#requestsTable')) {
                    $('#requestsTable').DataTable().clear().destroy();
                }
                requestTableBody.empty();

                if (requestList.length > 0) {

                    requestList.forEach(function (elem, index, arr) {
                        var tr = $('<tr>').attr({ 'data-subcat': offerSubCat, 'data-reqid': elem.requestId }).appendTo(requestTableBody);
                        var td0 = $('<td>').text(parseInt(index) + 1).appendTo(tr);
                        var td1 = $('<td>').text(offerInfo).attr({ 'data-qty': elem.requestQuantity, 'data-unit': elem.requestUnit }).appendTo(tr);
                        //var reqInfoText = elem.requestQuantity + " " + elem.requestUnit;
                        //$('<span>').addClass('label label-xs label-info').text(reqInfoText).appendTo(td1);                        

                        var td2 = $('<td>').text(elem.requestedByName).appendTo(tr);
                        var td3 = $('<td>').text(elem.requestExpectedDate).appendTo(tr);
                        var td4 = $('<td>').text(elem.requestDeliveryAddress).appendTo(tr);
                        var td5 = $('<td>').text(elem.requestStatus).appendTo(tr);
                        /*var td6 = $('<td>').appendTo(tr);
                        if (elem.requestStatus == "Requested") {
                            $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-primary respond').text('Respond').on('click', function () {
                                var reqQty = $(this).parents('td').siblings('td:eq(1)').data('qty'),
                                    offerQty = $('.myOfferRad:checked').parents('tr').find('td:eq(2)').attr('data-offerqty'),
                                    unit = $(this).parents('td').siblings('td:eq(1)').data('unit');

                                if (reqQty == -1) {
                                    var reqRejObj = {
                                        requestId: $(this).parents('tr').attr('data-reqid'),
                                        offerId: $('.myOfferRad:checked').parents('tr').attr('data-offerid'),
                                        requestQuantity: reqQty,
                                        requestUnit: "",
                                        requestStatus: 'Respond'
                                    };
                                    RespondRejectRequest(reqRejObj);
                                }
                                else {
                                    $('#offerRespondModal').modal('show');
                                    $("#modalQty").val(reqQty).attr({ 'data-reqqty': reqQty, 'data-offerqty': offerQty, 'data-qty': unit }).val();
                                    $('#offerRespondModal').attr({ 'data-reqid': $(this).parents('tr').attr('data-reqid') })
                                }
                            }).appendTo(td6);
                            $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-danger reject').text('Reject').on('click', function () {
                                var reqRejObj = {
                                    requestId: $(this).parents('tr').attr('data-reqid'),
                                    offerId: $('.myOfferRad:checked').parents('tr').attr('data-offerid'),
                                    requestQuantity: $(this).parents('td').siblings('td:eq(1)').data('qty'),
                                    requestUnit: $(this).parents('td').siblings('td:eq(1)').data('unit'),
                                    requestStatus: 'Reject'
                                };
                                RespondRejectRequest(reqRejObj);
                            }).appendTo(td6);
                        }*/
                    });

                    $('#requestsTable').DataTable({
                        //destroy: true,
                        //responsive: true,
                        pageLength: 5,
                        bLengthChange: false,
                        bFilter: true
                    });

                }
                else {
                    requestTableBody.empty();
                    var tr = $('<tr>').appendTo(requestTableBody);
                    $('<td>').attr({ colspan: '7' }).css({ 'text-align': 'center' }).html('<h3> -- No Requests Made for this Offer -- </h3>').appendTo(tr);
                }
                $("html, body").animate({ scrollTop: $('#requestsTable').offset().top }, 600);
            });

        }


        $('#offerRespondModal').on('shown.bs.modal', function () {
            $("#modalQty").focus();
            var subCat = $('.myOfferRad:checked').parents('li').attr('data-subcat');
            ajaxfunctioncallwithdata("POST", "./index.aspx/GetUnits", { subCategoryId: subCat }, true)
                    .then(function (resp) {
                        //console.log(resp.d);
                        var unitList = resp.d;
                        $('#modalUnit').empty();
                        $('<option>').attr({ value: '' }).text('Choose..').appendTo('#modalUnit');
                        for (var unt in unitList) {
                            $('<option>').attr({ value: unitList[unt].unitId }).text(unitList[unt].unitName).appendTo('#modalUnit');
                        }
                    });
        });


        $('#modalReqRespond').on('click', function () {
            var reqResObj = {
                requestId: $('#offerRespondModal').attr('data-reqid'),
                offerId: $('.myOfferRad:checked').parents('li').attr('data-offerid'),
                requestQuantity: $('#modalQty').val(),
                requestUnit: $('#modalUnit').val(),
                requestStatus: 'Respond'
            };
            console.log("RESPONSE: ", reqResObj);
            RespondRejectRequest(reqResObj);
        });


        function RespondRejectRequest(reqRespObj) {            
            console.log("RespondRejectRequest : ", reqRespObj," Unit: ", reqRespObj.requestUnit);
            if (isNaN(reqRespObj.requestUnit)) {
                var unitName = reqRespObj.requestUnit;
                ajaxfunctioncallwithdata("POST", "./index.aspx/GetUnits", { subCategoryId: $('.myOfferRad:checked').parents('li').attr('data-subcat') }, false)
                        .then(function (resp) {
                            //console.log(resp.d);
                            var unitList = resp.d;
                            reqRespObj.requestUnit = unitList.filter(function (elem) {
                                return elem.unitName == unitName;
                            })[0].unitId;
                        });
            }
            //console.log("RESP REJ OFFER REQ : ", reqRespObj);

            ajaxfunctioncallwithdata("POST", "./myOffers.aspx/RespondToRequest", { requestResponse: reqRespObj }, false)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    swal("Success!", reqRespObj.requestStatus + 'Successful', 'success');
                    //populateReqListForOffer($('#myOfferRad:checked').parents('tr').data('offerid'), $('#myOfferRad:checked').parents('tr').find('td:eq(2)').text(), $('#myOfferRad:checked').parents('tr').data('subcat'));
                    getRequests(1);
                }
                else {
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        }

        function cancelOffer(ev) {
            //var offerId = $(ev.target).parents('tr').attr('data-offerid');
            var offerId = $(ev.target).parents('li').attr('data-offerid');
            ajaxfunctioncallwithdata("POST", "./myOffers.aspx/CancelOffer", { offerId: offerId }, true)
            .then(function (resp) {                
                if (resp.d) {
                    swal("Success!", 'Offer Cancelled', 'success');
                    //getMyOffersList();
                    getMyOffers(1);
                }
                else {
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        }

        function getMyOffers(pagenum) {

            var noofRowsPerPage = 10;
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
            ajaxfunctioncallwithdata('POST', './myOffers.aspx/GetMyOffers', objs, true).then(function (resp) {
                var myOffers = resp.d;
                //console.log(myOffers, myOffers.length);
                var myOffersDiv = $('#myOffersDiv').find('ul.req_resp_list');
                myOffersDiv.empty();
                
                if (myOffers.length > 0) {
                    myOffers.map(function (elem, index, arr) {
                        mo_totalOffers = elem.count;
                        var myOfferLi = $('<li>').attr({ 'data-offerid': elem.offerId, 'data-subcat': elem.offerSubCategoryId, 'data-offerqty': elem.offerQuantity }).appendTo('#myOffersDiv ul.req_resp_list');
                        var myOfferAnchor = $('<a>').appendTo(myOfferLi);
                        var myOfferRadSpan = $('<span>').addClass('image').appendTo(myOfferAnchor);
                        $('<input>').attr({ type: 'radio', name: 'radMyOffer' }).addClass('flat myOfferRad').appendTo(myOfferRadSpan);
                        var myOfferContentSpan = $('<span>').appendTo(myOfferAnchor);
                        $('<span>').addClass('info').text(elem.offerSubCategoryName).appendTo(myOfferAnchor);
                        $('<span>').addClass('time').text(elem.offerCategoryName).appendTo(myOfferAnchor);
                        $('<span>').addClass('status').text(elem.offerStatus).appendTo(myOfferAnchor);
                        if (elem.offerStatus == "Pending") {
                            var delSpan = $('<span>').addClass('action').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).on('click', cancelOffer).appendTo(myOfferAnchor);
                            $('<i>').addClass('fa fa-trash-o').appendTo(delSpan);
                        }
                        $('<span>').addClass('message').text(elem.offerPostedDate).css({ margin: '2px 30px' }).appendTo(myOfferAnchor);

                    });

                    $('input.myOfferRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    }).on('ifChecked', function () {
                        //var reqInfo = { reqId: $(this).parents('li').attr('data-reqid'), reqName: $(this).parents('li').find('span.info').text(), reqQty: $(this).parents('li').attr('data-qtyInfo') };                                          
                        getRequests(1);
                    });
                }
                else {
                    $('<li>').text('-- No Offers Made -- ').css({ display: 'block', 'text-align': 'center' }).appendTo(myOffersDiv);
                }



                var totalNoofPages = Math.ceil(mo_totalOffers / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#myOffersPagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getMyOffers(1)">FIRST</a></li>').appendTo("#myOffersPagination");
                    $('<li><a href="#" onclick="getMyOffers(' + (page - 1) + ')"><<</a></li>').appendTo("#myOffersPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getMyOffers(' + i + ')">' + i + '</a></li>').appendTo("#myOffersPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getMyOffers(' + (page + 1) + ')">>></a></li>').appendTo("#myOffersPagination");
                    $('<li><a href="#" onclick="getMyOffers(' + totalNoofPages + ')">LAST</a></li>').appendTo("#myOffersPagination");
                }

            });

            
        }

        function getRequests(pagenum) {

            var selOffer = $('#myOffersDiv ul.req_resp_list li input.myOfferRad:checked')[0];            

            var offerInfo = {
                offerId: $(selOffer).parents('li').attr('data-offerid'),
                offerName: $(selOffer).parents('li').attr('data-subcat'),
                offerQty: $(selOffer).parents('li').attr('data-offerqty')
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
                offerId: offerInfo.offerId,
                startValue: startValue,
                noOfRows: noofRowsPerPage
            }

            console.log("RequestListForOffer: ", objs);

            ajaxfunctioncallwithdata('POST', './myOffers.aspx/RequestListForOffer', objs, true).then(function (resp) {
                var requests = resp.d;
                console.log(requests, requests.length);
                var requestsDiv = $('#reqsForOfferDiv').find('ul.req_resp_list');
                requestsDiv.empty();                
                if (requests.length > 0) {
                    requests.map(function (elem, index, arr) {
                        mo_totalRequests = elem.count;
                        console.log("REQ: ",elem)
                        var myRespLi = $('<li>').attr({ 'data-reqid': elem.requestId, 'data-unit': elem.requestUnit, 'data-reqqty': elem.requestQuantity, 'data-reqby': elem.requestedById }).appendTo(requestsDiv);
                        var myRespAnchor = $('<a>').css({ width: '100%' }).appendTo(myRespLi);
                        var reqRadSpan = $('<span>').addClass('image').appendTo(myRespAnchor);
                        $('<input>').attr({ type: 'radio', name: 'radOfferReq' }).addClass('flat reqRad').appendTo(reqRadSpan);
                        var myRespContentSpan = $('<span>').appendTo(myRespAnchor);
                        $('<span>').addClass('info').text($(selOffer).parents('li').find('span.info').text()).appendTo(myRespAnchor);
                        $('<span><strong>From: </strong> ' + elem.requestedByName + '</span>').addClass('time').appendTo(myRespAnchor);
                        $('<span>').addClass('status').text(elem.requestStatus).appendTo(myRespAnchor);
                        var otherInfo = $('<span>').addClass('message').appendTo(myRespAnchor);
                        //$('<span><strong>By</strong>: ' + elem.offeredByName + '</span><br/>').appendTo(otherInfo);
                        $('<span><strong>Address: </strong> ' + elem.requestDeliveryAddress + '</span>').appendTo(otherInfo);
                        //$('<span><strong>Email</strong>: ' + (elem.emailId == "" ? "NA" : elem.emailId) + '</span><br/>').css({ right: '295px', position: 'absolute' }).appendTo(otherInfo);
                        //$('<span><strong>Delivery Mode</strong>: ' + elem.offerDeliveryMode + '</span>').appendTo(otherInfo);
                        //$('<span><strong>Address</strong>: ' + (elem.offerDeliveryAddress == null ? "NA" : elem.offerDeliveryAddress) + '</span>').css({ right: '295px', position: 'absolute' }).appendTo(otherInfo);
                        var actionButtons = $('<div>').attr({}).appendTo(myRespAnchor);
                        if (elem.requestStatus == "Requested") {
                            $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-primary respond pull-right').text('Respond').on('click', function () {
                                var reqQty = $(this).parents('li').attr('data-reqqty'),
                                    offerQty = $('.myOfferRad:checked').parents('li').attr('data-offerqty'),
                                    unit = $(this).parents('li').siblings('td:eq(1)').data('unit');

                                if (reqQty == -1) {
                                    var reqRejObj = {
                                        requestId: $(this).parents('li').attr('data-reqid'),
                                        offerId: $('.myOfferRad:checked').parents('li').attr('data-offerid'),
                                        requestQuantity: reqQty,
                                        requestUnit: "",
                                        requestStatus: 'Respond'
                                    };
                                    RespondRejectRequest(reqRejObj);
                                }
                                else {
                                    $('#offerRespondModal').modal('show');

                                    $("#modalQty").val(reqQty).attr({ 'data-reqqty': reqQty, 'data-offerqty': offerQty, 'data-qty': unit }).val();
                                    //alert($(this).parents('li').attr('data-reqid'));
                                    $('#offerRespondModal').attr({ 'data-reqid': $(this).parents('li').attr('data-reqid') })

                                    
                                    
                                }
                            }).appendTo(actionButtons);
                            $('<button>').attr({ type: 'button' }).addClass('btn btn-xs btn-danger reject pull-right').text('Reject').on('click', function () {
                                var reqRejObj = {
                                    requestId: $(this).parents('tr').attr('data-reqid'),
                                    offerId: $('.myOfferRad:checked').parents('tr').attr('data-offerid'),
                                    requestQuantity: $(this).parents('td').siblings('td:eq(1)').data('qty'),
                                    requestUnit: $(this).parents('td').siblings('td:eq(1)').data('unit'),
                                    requestStatus: 'Reject'
                                };
                                RespondRejectRequest(reqRejObj);
                            }).appendTo(actionButtons);
                        }

                    });

                    $('input.reqRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    }).on('ifChecked', function () {
                        getChatMessages_myoffers();                        
                    });
                }
                else {
                    $('<li>').text('-- No Requests --').css({ display: 'block', 'text-align': 'center' }).appendTo(requestsDiv);
                }


                var totalNoofPages = Math.ceil(mo_totalRequests / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#reqsForOfferPagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getRequests(1)">FIRST</a></li>').appendTo("#reqsForOfferPagination");
                    $('<li><a href="#" onclick="getRequests(' + (page - 1) + ')"><<</a></li>').appendTo("#reqsForOfferPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getRequests(' + i + ')">' + i + '</a></li>').appendTo("#reqsForOfferPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getRequests(' + (page + 1) + ')">>></a></li>').appendTo("#reqsForOfferPagination");
                    $('<li><a href="#" onclick="getRequests(' + totalNoofPages + ')">LAST</a></li>').appendTo("#reqsForOfferPagination");
                }

            });

            
        }


        $('#sendMessage').on('click', function (e) {
            sendMessage_OfferPage($('#userMessage').val());
            //createChatMessage("Message from other user", "other");
        });

        $('#userMessage').on('keypress', function (e) {           
            var message = $(this).val();
            if (e.which == 13) {
                e.preventDefault();
                if (message != "") {
                    sendMessage_OfferPage(message);
                    //createChatMessage(message, "me");
                    //$(this).val("");
                }
            }
        });

        function sendMessage_OfferPage(message) {
            var selOffer = $('#myOffersDiv ul.req_resp_list li input.myOfferRad:checked')[0],
                selRequest = $('#reqsForOfferDiv ul.req_resp_list li input.reqRad:checked')[0];
            var offerId = $(selOffer).parents('li').attr('data-offerid'),
                requestedBy = $(selRequest).parents('li').attr('data-reqby');
            console.log("SEND MESSAGE: ", offerId, requestedBy);
            if (offerId == null)
            {
                swal("Warning!", "Please select an offer.", "warning");
                return false;
            }

            if (requestedBy == null) {
                swal("Warning!", "Please select a request.", "warning");
                return false;
            }

            $.appPost("index.aspx/sendMessage", { messageDetails: { offerId: offerId, requestorUserId: requestedBy, offererUserId: sessionStorage.getItem("userId"), message: message, sentBy: sessionStorage.getItem("userId") } }).then(function (resp) {
                console.log("SEND MESSAGE RESPONSE: ",resp);
                if (resp.d === "success") {
                    var dateTime = moment().format("MM/DD/YYYY, H:mm:ss");
                    createChatMessage(message, "me", dateTime);
                    $('#userMessage').val("");
                }
            })
        }

        $('#refreshChat').on('click', function () {
            getChatMessages_myoffers();
        })


        function getChatMessages_myoffers() {
            var selOffer = $('#myOffersDiv ul.req_resp_list li input.myOfferRad:checked')[0];
            selRequest = $('#reqsForOfferDiv ul.req_resp_list li input.reqRad:checked')[0];
            var offerId = $(selOffer).parents('li').attr('data-offerid'),
                requestedBy = $(selRequest).parents('li').attr('data-reqby');
            console.log("GET MESSAGE: ", offerId, requestedBy);
            $.appPost("index.aspx/getChatMessages", { offerId: offerId, requestorUserId: requestedBy, offererUserId: sessionStorage.getItem("userId") }).then(function (resp) {
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
