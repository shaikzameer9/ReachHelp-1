<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="subCategoriesPage.aspx.cs" Inherits="ReachHelpWF.main.subCategoriesPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        ul#unitList {
            padding: 0;
        }

            ul#unitList li {
                background: #f3f3f3;
                border-radius: 3px;
                position: relative;
                padding: 7px;
                margin-bottom: 5px;
                list-style: none;
            }

            ul#unitList p {
                margin: 0;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Sub-Categories</h3>
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
                <div class="col-md-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2><small>List of all the sub-categories.</small></h2>
                            <div style="display: inline-block; margin-left: 50px;">
                                <button class="btn btn-sm btn-round btn-primary" id="addNewSubCategory" type="button">New</button>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="newSubCategoryCont" style="display: none;">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="row">
                                            <div class="col-md-3 col-xs-6">
                                                <label for="category">Category <span id="catErr" style="display: none"></span></label>
                                                <select id="category" class="form-control">
                                                    <option value="">Choose..</option>
                                                </select>
                                            </div>

                                            <div class="col-md-3 col-xs-6">
                                                <label for="newSubCategory">Sub-Category <span id="subCatErr" style="display: none"></span></label>
                                                <input type="text" id="newSubCategory" class="form-control" />
                                            </div>
                                            <div class="col-md-2 col-xs-6">
                                                <label for="newSubCategoryStatus">Status <span id="statusErr" style="display: none"></span></label>
                                                <label style="display: block;">
                                                    <input type="checkbox" class="js-switch" id="newSubCategoryStatus" />
                                                    <span id="newSubCategoryStatusVal">Inactive</span>
                                                </label>
                                            </div>

                                            <div class="col-md-2 col-xs-6">
                                                <label for="newSubCategoryMeasurable">Measurable</label>
                                                <label style="display: block;">
                                                    <input type="checkbox" class="js-switch" id="newSubCategoryMeasurable" />
                                                    <span id="newSubCategoryMeasVal">No</span>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="row" id="unitsCont" style="display: none;">
                                            <div class="col-md-5 col-xs-12">
                                                <label for="newSubCategoryUnit">Unit List</label>
                                                <ul id="unitList">
                                                    <li class="li-unit">
                                                        <span>
                                                            <select class="newSubCategoryUnit" class="form-control" style="width: 60%; display: inline-block;">
                                                                <option value="">Choose..</option>
                                                            </select>
                                                            <span class="unit-new" style="display: inline-block; font-size: large; margin: 0 5px;"><i class="fa fa-plus"></i></span>
                                                            <span disabled class="unit-remove" style="display: inline-block; font-size: large; margin: 0 5px;"><i class="fa fa-minus"></i></span>
                                                            <span class="unit-save" style="display: inline-block; font-size: large; margin: 0 5px;"><i class="fa fa-check"></i></span>
                                                            <span class="unit-delete" style="display: inline-block; font-size: large; margin: 0 5px;"><i class="fa fa-trash"></i></span>
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>

                                        </div>


                                        <button type="button" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;" id="submitNewSubCategory">Create</button>
                                        <button type="button" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;" id="modifySubCategory">Modify</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-12 table" style="overflow-x:auto">
                                    <table class="table table-striped" id="subCategoryTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th>Sub-Category</th>
                                                <th>Category</th>
                                                <th>Measurable</th>
                                                <th>Units</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="6" style="text-align: center;">
                                                    <h3>-- No Data --</h3>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <ul class="pagination pagination-split pull-right" id="subCategoriesPagination">
                                        </ul>

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
        var scp_TotalSubCategories = 0;
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));

            ajaxfunctioncallwithdata("POST", "./index.aspx/ListCategoryForAdmin", {startValue:'0', noOfRows:'0'}, true).then(function (resp) {
                var categoryList = resp.d;
                //console.log(categoryList);
                $('#category').empty();
                $('<option>').attr({ value: '' }).appendTo('#category');
                for (var cat in categoryList) {
                    //console.log(categoryList[cat]);
                    $('<option>').attr({ value: categoryList[cat].categoryId }).text(categoryList[cat].categoryName).appendTo('#category');
                }
            });

            //getAllSubCategories();
            getAllSubCategories(1);

            ajaxfunctioncallwithoutdata("POST", "./index.aspx/GetAllUnits", true).then(function (resp) {
                //console.log(resp.d);
                var unitList = resp.d;
                $('.newSubCategoryUnit').empty();
                $('<option>').attr({ value: '' }).appendTo('.newSubCategoryUnit');
                for (var unit in unitList) {
                    $('<option>').attr({ value: unitList[unit].unitId }).text(unitList[unit].unitName).appendTo('.newSubCategoryUnit');
                }

            });

        })()

        $("#addNewSubCategory").on('click', function () {
            $("#newSubCategoryCont").slideToggle();
        });

        $('#newSubCategoryStatus').on('click', function (e) {
            if ($(this).is(':checked')) {
                $('#newSubCategoryStatusVal').text("Active");
            }
            else {
                $('#newSubCategoryStatusVal').text("Inactive");
            }
        });

        $('#submitNewSubCategory').on('click', function () {
            var catId = $('#category').val(),
                subCatName = $('#newSubCategory').val(),
                subCatStatus = ($('#newSubCategoryStatus').is(':checked') ? "Active" : "Inactive");

            var isMeasurable = ($('#newSubCategoryMeasurable').is(':checked') ? "Yes" : "No");
            var subCatUnits = [];

            $('#unitList').find('li').each(function () {
                var selUnit = $(this).find('select option:selected').val();
                subCatUnits.push(selUnit);
            });

            if (catId == "") {
                $('#catErr').text('Please select a category!').css({ color: 'red' }).show();
                return false;
            }
            if (subCatName == "") {
                $('#subCatErr').text('Please enter a Sub-Category!').css({ color: 'red' }).show();
                return false;
            }

            $('#catErr,#subCatErr').hide();

            var newSubCatDetails = {
                categoryId: catId,
                subCategoryName: subCatName,
                subCategoryStatus: subCatStatus,
                measurable: isMeasurable,
                units: subCatUnits.join(',')
            };

            //console.log(newSubCatDetails);

            ajaxfunctioncallwithdata('POST', './index.aspx/AddSubCategory', { categoryDetails: newSubCatDetails }, true)
            .then(function (resp) {
                //console.log(resp.d);

                if (resp.d) {                    
                    swal("Success!", 'Sub Category Added Successfully.', 'success');

                    //getAllSubCategories();
                    getAllSubCategories(1);

                    //for (var i = 0; i < subCatUnits.length; i++) {
                    //    var curUnit = subCatUnits[i];
                    //    ajaxfunctioncallwithdata("POST", "./index.aspx/TestMethod", { unit: curUnit }).then(function (resp) {
                    //        return function () {
                    //            console.log("RESP: ", resp);
                    //        }
                    //    }(curUnit));
                    //}
                }
                else {
                    swal("Oops!", 'Error Adding Sub Category!', 'danger');
                }

            });
        });

        $('#modifySubCategory').on('click', function () {
            var selectedSubCat = $('.subCatRad:checked').parents('tr');
            var subCatId = selectedSubCat.data('subcat'),
                subCatName = $('#newSubCategory').val(),
                subCatStatus = ($('#newSubCategoryStatus').is(':checked') ? "Active" : "Inactive"),
                catId = $('#category').val(),
                catName = $('#category').find('option:selected').text();

            var isMeasurable = ($('#newSubCategoryMeasurable').is(':checked') ? "Yes" : "No");
            var subCatUnits = [];

            $('#unitList').find('li').each(function () {
                var selUnit = $(this).find('select option:selected').val();
                subCatUnits.push(selUnit);
            });

            if (catId == "") {
                $('#catErr').text('Please select a category!').css({ color: 'red' }).show();
                return false;
            }
            if (subCatName == "") {
                $('#subCatErr').text('Please enter a Sub-Category!').css({ color: 'red' }).show();
                return false;
            }

            $('#catErr,#subCatErr').hide();

            var updateSubCatDetails = {
                categoryId: catId,
                subCategoryId: subCatId,
                subCategoryName: subCatName,
                subCategoryStatus: subCatStatus,
                measurable: isMeasurable,
                units: subCatUnits.join(',')
            };

            //console.log(updateSubCatDetails);

            ajaxfunctioncallwithdata('POST', './index.aspx/AddSubCategory', { categoryDetails: updateSubCatDetails }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    selectedSubCat.attr({ 'data-cat': updateSubCatDetails.categoryId, 'data-subcat': updateSubCatDetails.subCategoryId });
                    selectedSubCat.find('td:eq(2)').text(updateSubCatDetails.subCategoryName);
                    selectedSubCat.find('td:eq(3)').text(catName);
                    selectedSubCat.find('td:eq(6)').text(updateSubCatDetails.subCategoryStatus);

                    $('#category').val('');
                    $('#newSubCategory').val('');
                    changeSwitchery($('#newSubCategoryStatus'), false);
                    $('#newSubCategoryStatusVal').text('Inactive');
                    $('#newSubCategoryCont').slideUp();

                    //getAllSubCategories();
                    getAllSubCategories(1);
                }
            });
        });

        $('#newSubCategoryMeasurable').on('click', function (e) {
            if ($(this).is(':checked')) {
                $('#newSubCategoryMeasVal').text("Yes");
                $('#unitsCont').slideDown();
            }
            else {
                $('#newSubCategoryMeasVal').text("No");
                $('#unitsCont').slideUp();
            }
        });

        $('.unit-new').on('click', function () {
            var unitListItem = $(this).parents('li');
            var clonedItem = unitListItem.clone(true);
            clonedItem.find('.unit-remove').removeAttr('disabled');
            clonedItem.appendTo('#unitList')
        });

        $('.unit-remove').on('click', function () {
            var unitListItem = $(this).parents('li');
            unitListItem.remove();
        });

        $('.unit-save').on('click', function () {
            var unitListItem = $(this).parents('li');
            var selUnit = unitListItem.find('select').val();
        });


        function getAllSubCategories(pagenum) {
            var noofRowsPerPage = 5;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                startValue: startValue,
                noOfRows: noofRowsPerPage
            }
            ajaxfunctioncallwithdata('POST', './index.aspx/ListSubCategoryForAdmin', objs, true).then(function (resp) {
                var subCategories = resp.d;
                //console.log(subCategories, subCategories.length);
                var subCategoryTableBody = $('#subCategoryTable').find('tbody');
                subCategoryTableBody.empty();
                if (subCategories.length > 0) {

                    subCategories.map(function (elem, index, arr) {
                        scp_TotalSubCategories = elem.count;

                        var tr = $('<tr>').attr({ 'data-subcat': elem.subCategoryId, 'data-cat': elem.categoryId }).appendTo(subCategoryTableBody);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'radSubCat' }).addClass('flat subCatRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(index) + 1).appendTo(tr);
                        var td2 = $('<td>').text(elem.subCategoryName).appendTo(tr);
                        var td3 = $('<td>').text(elem.categoryName).appendTo(tr);
                        var td4 = $('<td>').text(elem.measurable).appendTo(tr);
                        var td5 = $('<td>').text(elem.units).appendTo(tr);
                        var td6 = $('<td>').text(elem.subCategoryStatus).appendTo(tr);
                        var td7 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var catId = thisTr.attr('data-cat'),
                                subCatId = thisTr.attr('data-subcat'),
                                subCatName = thisTr.find('td:eq(2)').text(),
                                subCatStatus = (thisTr.find('td:eq(6)').text() == "Active" ? true : false),
                                subCatIsMeasurable = (thisTr.find('td:eq(4)').text() == "Yes" ? true : false),
                                subCatUnits = thisTr.find('td:eq(5)').text().split(',');

                            $('#newSubCategoryCont').slideDown();
                            $('#category').val(catId);
                            $('#newSubCategory').val(subCatName);
                            if (subCatStatus) {
                                changeSwitchery($('#newSubCategoryStatus'), true);
                                $('#newSubCategoryStatusVal').text('Active');
                            }
                            else {
                                changeSwitchery($('#newSubCategoryStatus'), false);
                                $('#newSubCategoryStatusVal').text('Inactive');
                            }

                            if (subCatIsMeasurable) {
                                changeSwitchery($('#newSubCategoryMeasurable'), true);
                                $('#newSubCategoryMeasVal').text('Yes');
                                $('#unitsCont').slideDown();
                            }
                            else {
                                changeSwitchery($('#newSubCategoryMeasurable'), false);
                                $('#newSubCategoryMeasVal').text('No');
                                $('#unitsCont').slideUp();
                            }

                            $('.newSubCategoryUnit:not(:first)').parents('li').remove();

                            for (var unit in subCatUnits) {
                                $('.newSubCategoryUnit:eq(' + unit + ')').find('option').each(function () {
                                    if ($(this).text() == subCatUnits[unit]) {
                                        $(this).attr({ selected: true });
                                        if (unit < subCatUnits.length - 1)
                                            $(this).parents('li').find('span.unit-new').trigger('click');
                                    }
                                });
                            }

                        }).appendTo(td7);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-subcat'));
                        }).appendTo(td7);

                    });                    

                    $('input.subCatRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    });
                }
                else {
                }




                var totalNoofPages = Math.ceil(scp_TotalSubCategories / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#categoriesPagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getAllSubCategories(1)">FIRST</a></li>').appendTo("#categoriesPagination");
                    $('<li><a href="#" onclick="getAllSubCategories(' + (page - 1) + ')"><<</a></li>').appendTo("#categoriesPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getAllSubCategories(' + i + ')">' + i + '</a></li>').appendTo("#categoriesPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getAllSubCategories(' + (page + 1) + ')">>></a></li>').appendTo("#categoriesPagination");
                    $('<li><a href="#" onclick="getAllSubCategories(' + totalNoofPages + ')">LAST</a></li>').appendTo("#categoriesPagination");
                }


            });
        }


        /*function getAllSubCategories() {
            ajaxfunctioncallwithoutdata("POST", "./index.aspx/ListSubCategoryForAdmin", true).then(function (resp) {
                var subCategoryDetails = resp.d;
                //console.log(subCategoryDetails, subCategoryDetails.length);
                var subCategoryTableBody = $('#subCategoryTable').find('tbody');

                if (subCategoryDetails.length > 0) {
                    subCategoryTableBody.empty();
                    for (var subCat in subCategoryDetails) {
                        //console.log(subCategoryDetails[subCat]);
                        var tr = $('<tr>').attr({ 'data-subcat': subCategoryDetails[subCat].subCategoryId, 'data-cat': subCategoryDetails[subCat].categoryId }).appendTo(subCategoryTableBody);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'radSubCat' }).addClass('flat subCatRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(subCat) + 1).appendTo(tr);
                        var td2 = $('<td>').text(subCategoryDetails[subCat].subCategoryName).appendTo(tr);
                        var td3 = $('<td>').text(subCategoryDetails[subCat].categoryName).appendTo(tr);
                        var td4 = $('<td>').text(subCategoryDetails[subCat].measurable).appendTo(tr);
                        var td5 = $('<td>').text(subCategoryDetails[subCat].units).appendTo(tr);
                        var td6 = $('<td>').text(subCategoryDetails[subCat].subCategoryStatus).appendTo(tr);
                        var td7 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var catId = thisTr.attr('data-cat'),
                                subCatId = thisTr.attr('data-subcat'),
                                subCatName = thisTr.find('td:eq(2)').text(),
                                subCatStatus = (thisTr.find('td:eq(6)').text() == "Active" ? true : false),
                                subCatIsMeasurable = (thisTr.find('td:eq(4)').text() == "Yes" ? true : false),
                                subCatUnits = thisTr.find('td:eq(5)').text().split(',');

                            $('#newSubCategoryCont').slideDown();
                            $('#category').val(catId);
                            $('#newSubCategory').val(subCatName);
                            if (subCatStatus) {
                                changeSwitchery($('#newSubCategoryStatus'), true);
                                $('#newSubCategoryStatusVal').text('Active');
                            }
                            else {
                                changeSwitchery($('#newSubCategoryStatus'), false);
                                $('#newSubCategoryStatusVal').text('Inactive');
                            }

                            if (subCatIsMeasurable) {
                                changeSwitchery($('#newSubCategoryMeasurable'), true);
                                $('#newSubCategoryMeasVal').text('Yes');
                                $('#unitsCont').slideDown();
                            }
                            else {
                                changeSwitchery($('#newSubCategoryMeasurable'), false);
                                $('#newSubCategoryMeasVal').text('No');
                                $('#unitsCont').slideUp();
                            }

                            $('.newSubCategoryUnit:not(:first)').parents('li').remove();

                            for (var unit in subCatUnits) {
                                $('.newSubCategoryUnit:eq(' + unit + ')').find('option').each(function () {
                                    if ($(this).text() == subCatUnits[unit]) {
                                        $(this).attr({ selected: true });
                                        if (unit < subCatUnits.length - 1)
                                            $(this).parents('li').find('span.unit-new').trigger('click');
                                    }
                                });
                            }

                        }).appendTo(td7);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-subcat'));
                        }).appendTo(td7);
                    }

                    $('#subCategoryTable').DataTable({
                        //destroy: true,
                        //responsive: true,
                        pageLength: 5,
                        bLengthChange: false,
                        bFilter: true,
                    });

                    $('input.flat').iCheck({
                        checkboxClass: 'icheckbox_flat-green',
                        radioClass: 'iradio_flat-green'
                    });
                }

            });
        }*/


    </script>
</asp:Content>
