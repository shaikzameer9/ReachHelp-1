<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="requestHelp.aspx.cs" Inherits="ReachHelpWF.main.requestHelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">Post Need</h3>
                </div>

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
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2><small class="trn">Post your need</small></h2>
                            <a href="myRequests" class="btn btn-sm btn-round btn-primary pull-right trn" style="margin: 5px 0 0 0;">Needs</a>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="category" class="trn">Category</label>
                                    <select id="category" class="form-control select2">
                                        <option value="">Choose..</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="subCategory" class="trn">Sub-Category</label>
                                    <select id="subCategory" class="form-control select2">
                                        <option value="">Choose..</option>
                                    </select>
                                </div>
                                <div id="measurableCont">
                                    <div class="col-md-3 col-xs-6 form-group">
                                        <label for="qty" class="trn">Quantity</label>
                                        <input type="number" id="qty" name="qty" value="0" min="0" class="form-control" />
                                    </div>
                                    <div class="col-md-3 col-xs-6 form-group">
                                        <label for="unit" class="trn">Unit</label>
                                        <select id="unit" class="form-control select2">
                                            <option value="">Choose..</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="expectedDate"><span class="trn">Expected Date</span> (YYYY/MM/DD)</label>
                                    <div class="control-group">
                                        <div class="controls">
                                            <div class="col-md-11 xdisplay_inputx form-group has-feedback">
                                                <input type="text" class="form-control has-feedback-left" id="expectedDate" placeholder="First Name" aria-describedby="inputSuccess2Status" />
                                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                                <span id="inputSuccess2Status" class="sr-only">(success)</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="deliveryAddress" class="trn">Address</label>
                                    <i class="fa fa-clone pull-right copy-addr" style="position: relative; top: 5px; color: #03A9F4;" data-toggle="tooltip" data-placement="top" title="Copy Address/ Look on Map"></i>
                                    <textarea id="deliveryAddress" class="form-control" rows="3"></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <button type="button" id="btnCreateRequest" class="btn btn-md btn-primary pull-right trn">Submit Request</button>
                            </div>
                            <div class="row">
                                <div class="alert alert-info hidden" id="alertMsg" role="alert">
                                    <strong>Heads up! </strong> All the responses to your requests are displayed in the <a href="myRequests" class="alert-link">My Needs</a> page. Select a request to view corresponding responses.
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

            $('.select2').select2({ width: '100%' });

            $('#expectedDate').daterangepicker({
                singleDatePicker: true,
                singleClasses: "picker_1",
                locale: {
                    format: 'YYYY/MM/DD'
                },
                minDate: new Date()
            }, function (start, end, label) {
                //console.log(start.toISOString(), end.toISOString(), label);
            });

            ajaxfunctioncallwithdata("POST", "./index.aspx/ListCategoryForUser", { languageId: '1' }, true)
            .then(function (resp) {
                //console.log(resp.d);
                var categoryList = resp.d;
                $('#category').empty();
                $('<option>').attr({ value: '' }).text('Choose..').appendTo('#category');
                for (var cat in categoryList) {
                    $('<option>').attr({ value: categoryList[cat].categoryId }).text(categoryList[cat].categoryName).appendTo('#category');
                }
            });

            $('#category').on('change', function () {
                var selCategory = $(this).val();
                $('#subCategory,#unit').empty();
                ajaxfunctioncallwithdata("POST", "./index.aspx/ListSubCategoryForUser", { categoryId: selCategory, languageId: '1' }, true)
                    .then(function (resp) {
                        //console.log(resp.d);
                        var categoryList = resp.d;
                        $('<option>').attr({ value: '' }).text('Choose..').appendTo('#subCategory');
                        for (var cat in categoryList) {
                            $('<option>').attr({ value: categoryList[cat].subCategoryId, 'data-measurable': categoryList[cat].measurable }).text(categoryList[cat].subCategoryName).appendTo('#subCategory');
                        }
                    });
            });

            $('#subCategory').on('change', function () {
                if ($(this).find('option:selected').attr('data-measurable') == "No") {
                    $('#measurableCont').hide();
                }
                else {
                    $('#measurableCont').show();
                    getUnitBySubCategory($(this).val());
                }

            });


        })()

        function getUnitBySubCategory(subCat) {
            ajaxfunctioncallwithdata("POST", "./index.aspx/GetUnits", { subCategoryId: subCat }, true)
                    .then(function (resp) {
                        //console.log(resp.d);
                        var unitList = resp.d;
                        $('#unit').empty();
                        $('<option>').attr({ value: '' }).text('Choose..').appendTo('#unit');
                        for (var unt in unitList) {
                            $('<option>').attr({ value: unitList[unt].unitId }).text(unitList[unt].unitName).appendTo('#unit');
                        }
                    });
        }

        $('#btnCreateRequest').on('click', function () {
            var requestObj = {
                requestCategoryId: $('#category').val(),
                requestSubCategoryId: $('#subCategory').val(),
                requestedById: sessionStorage.getItem('userId'),  // First set user id during login
                requestQuantity: ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes" ? $('#qty').val() : '-1'),//'1'
                requestUnit: ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes" ? $('#unit').val() : ''), //''
                requestExpectedDate: $('#expectedDate').val(),//moment().format("YYYY/MM/DD"),
                requestDeliveryAddress: $('#deliveryAddress').val()
            };

            if (requestObj.requestCategoryId == "") { alert("Please select a category!"); return false; }
            if (requestObj.requestSubCategoryId == "") { alert("Please select a sub-category!"); return false; }
            if ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes") {
                if (requestObj.requestQuantity == "") { alert("Please enter the quantity!"); return false; }
                if (requestObj.requestUnit == "") { alert("Please select a unit!"); return false; }
            }
            if (requestObj.requestExpectedDate == "") { alert("Please select an expected date!"); return false; }
            if (requestObj.requestDeliveryAddress == "") { alert("Please enter the delivery address!"); return false; }


            ajaxfunctioncallwithdata("POST", "./index.aspx/MakeRequest", { myRequest: requestObj }, true)
                .then(function (resp) {
                    //console.log(resp.d);                    
                    if (resp.d) {
                        swal("Success!", 'Request sent succesfully.', 'success');
                        $('#category').val('').trigger('change');
                        $('#subCategory,#unit').empty();
                        $('#subCategory').empty();
                        $('#qty').val('0');
                        $('#expectedDate,#deliveryAddress').val('');
                        $('#deliveryAddress').val('');


                        $('#alertMsg').removeClass('hidden');

                    }
                    else {
                        swal("Oops!", 'Something went wrong.', 'danger');
                    }
                });
        });

    </script>
</asp:Content>
