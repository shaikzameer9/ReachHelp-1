<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="categoriesPage.aspx.cs" Inherits="ReachHelpWF.main.categoriesPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Categories</h3>
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
                            <h2><small>List of all the categories.</small></h2>
                            <div style="display: inline-block; margin-left: 50px;">
                                <button class="btn btn-sm btn-round btn-primary" id="addNewCategory" type="button">New</button>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="newCategoryCont" style="display: none;">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="col-md-3 col-xs-6">
                                            <label for="newCategory">Category  <span id="catErr" style="display: none"></span></label>
                                            <input type="text" id="newCategory" class="form-control" required />
                                        </div>
                                        <div class="col-md-3 col-xs-6">
                                            <label for="newCategoryStatus">Status</label>
                                            <label style="display: block;">
                                                <input type="checkbox" class="js-switch" id="newCategoryStatus" />
                                                <span id="newCategoryStatusVal">Inactive</span>
                                            </label>
                                        </div>
                                        <button type="button" id="submitNewCategory" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;">Add</button>
                                        <button type="button" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;" id="modifyCategory">Modify</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-12 table" style="overflow-x:auto">
                                    <table class="table table-striped" id="categoryTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th>Category</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="5">
                                                    <h3 style="text-align: center;">-- No Data --</h3>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <ul class="pagination pagination-split pull-right" id="categoriesPagination">
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
        var cp_TotalCategories = 0;
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));
            //getAllCategories();
            getAllCategories(1);
        })()

        $("#addNewCategory").on('click', function () {
            $("#newCategoryCont").slideToggle();
        });

        $('#newCategoryStatus').on('click', function (e) {
            if ($(this).is(':checked')) {
                $('#newCategoryStatusVal').text("Active");
            }
            else {
                $('#newCategoryStatusVal').text("Inactive");
            }
        });

        $('#submitNewCategory').on('click', function () {
            var catName = $('#newCategory').val(),
                catStatus = ($('#newCategoryStatus').is(':checked') ? "Active" : "Inactive");           
            if (catName == "") {
                $('#catErr').text('Please enter a Category!').css({ color: 'red' }).show();
                return false;
            }

            $('#catErr,#subCatErr').hide();

            var newCatDetails = {
                categoryName: catName,
                categoryStatus: catStatus
            };

            //console.log(newCatDetails);

            ajaxfunctioncallwithdata('POST', './index.aspx/AddCategory', { categoryDetails: newCatDetails }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    //getAllCategories();
                    getAllCategories(1);
                }
            });
        });

        $('#modifyCategory').on('click', function () {
            var selectedCat = $('.catRad:checked').parents('tr');
            var catId = selectedCat.data('cat'),
                catName = $('#newCategory').val(),
                catStatus = ($('#newCategoryStatus').is(':checked') ? "Active" : "Inactive");           
            if (catName == "") {
                $('#catErr').text('Please enter a Sub-Category!').css({ color: 'red' }).show();
                return false;
            }

            $('#catErr').hide();

            var updateCatDetails = {
                categoryId: catId,                
                categoryName: catName,
                categoryStatus: catStatus
            };

            //console.log(updateCatDetails);

            ajaxfunctioncallwithdata('POST', './index.aspx/AddCategory', { categoryDetails: updateCatDetails }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    swal("Success!", 'Category modified successfully', 'success');
                    //getAllCategories();

                    getAllCategories(1);

                    selectedCat.attr({ 'data-cat': updateCatDetails.categoryId });
                    selectedCat.find('td:eq(2)').text(updateCatDetails.categoryName);
                    selectedCat.find('td:eq(3)').text(updateCatDetails.categoryStatus);

                    $('#newCategory').val('');
                    changeSwitchery($('#newCategoryStatus'), false);
                    $('#newCategoryStatusVal').text('Inactive');
                    $('#newCategoryCont').slideUp();

                }
                else {
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        });

        function getAllCategories(pagenum) {
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
            ajaxfunctioncallwithdata('POST', './index.aspx/ListCategoryForAdmin', objs, true).then(function (resp) {
                var categories = resp.d;
                //console.log(categories, categories.length);
                var categoryTableBody = $('#categoryTable').find('tbody');
                categoryTableBody.empty();
                if (categories.length > 0) {

                    categories.map(function (elem, index, arr) {
                        cp_TotalCategories = elem.count;
                        
                        //console.log(index);
                        var tr = $('<tr>').attr({ 'data-cat': elem.categoryId }).appendTo(categoryTableBody);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'radCat' }).addClass('flat catRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(index) + 1).appendTo(tr);
                        var td3 = $('<td>').text(elem.categoryName).appendTo(tr);
                        var td4 = $('<td>').text(elem.categoryStatus).appendTo(tr);
                        var td5 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;cursor:pointer"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var catId = thisTr.attr('data-cat'),
                                catName = thisTr.find('td:eq(2)').text(),
                                catStatus = (thisTr.find('td:eq(3)').text() == "Active" ? true : false);
                            $('#newCategoryCont').slideDown();
                            $('#newCategory').val(catName);
                            if (catStatus) {
                                changeSwitchery($('#newCategoryStatus'), true);
                                $('#newCategoryStatusVal').text('Active');
                            }
                            else {
                                changeSwitchery($('#newCategoryStatus'), false);
                                $('#newCategoryStatusVal').text('Inactive');
                            }
                        }).appendTo(td5);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-subcat'));
                        }).appendTo(td5);

                    });

                    $('input.catRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    });
                }
                else {                    
                }




                var totalNoofPages = Math.ceil(cp_TotalCategories / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#categoriesPagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getAllCategories(1)">FIRST</a></li>').appendTo("#categoriesPagination");
                    $('<li><a href="#" onclick="getAllCategories(' + (page - 1) + ')"><<</a></li>').appendTo("#categoriesPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getAllCategories(' + i + ')">' + i + '</a></li>').appendTo("#categoriesPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getAllCategories(' + (page + 1) + ')">>></a></li>').appendTo("#categoriesPagination");
                    $('<li><a href="#" onclick="getAllCategories(' + totalNoofPages + ')">LAST</a></li>').appendTo("#categoriesPagination");
                }


            });
        }

        /*function getAllCategories() {
            ajaxfunctioncallwithoutdata("POST", "./index.aspx/ListCategoryForAdmin", true).then(function (resp) {
                var categoryDetails = resp.d;
                //console.log(categoryDetails, categoryDetails.length);
                var subCategoryTableBody = $('#categoryTable').find('tbody');

                if (categoryDetails.length > 0) {
                    subCategoryTableBody.empty();
                    for (var cat in categoryDetails) {
                        //console.log(categoryDetails[cat]);
                        var tr = $('<tr>').attr({ 'data-cat': categoryDetails[cat].categoryId }).appendTo(subCategoryTableBody);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'radCat' }).addClass('flat catRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(cat) + 1).appendTo(tr);
                        var td3 = $('<td>').text(categoryDetails[cat].categoryName).appendTo(tr);
                        var td4 = $('<td>').text(categoryDetails[cat].categoryStatus).appendTo(tr);
                        var td5 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;cursor:pointer"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var catId = thisTr.attr('data-cat'),
                                catName = thisTr.find('td:eq(2)').text(),
                                catStatus = (thisTr.find('td:eq(3)').text() == "Active" ? true : false);
                            $('#newCategoryCont').slideDown();
                            $('#newCategory').val(catName);
                            if (catStatus) {
                                changeSwitchery($('#newCategoryStatus'), true);
                                $('#newCategoryStatusVal').text('Active');
                            }
                            else {
                                changeSwitchery($('#newCategoryStatus'), false);
                                $('#newCategoryStatusVal').text('Inactive');
                            }
                        }).appendTo(td5);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-subcat'));
                        }).appendTo(td5);
                    }

                    $('#categoryTable').DataTable({
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
