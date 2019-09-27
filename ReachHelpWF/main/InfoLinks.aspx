<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="InfoLinks.aspx.cs" Inherits="ReachHelpWF.main.InfoLinks" %>

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
                            <h2>Info Links <small>Information Links</small></h2>
                            <div style="display: inline-block; margin-left: 50px;">
                                <button class="btn btn-sm btn-round btn-primary" id="addnewlinks" type="button">New</button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="newinfoLinks" style="display: none;">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="col-md-3 col-xs-6">
                                            <label for="linktitle">Title  <span id="titleErr" style="display: none"></span></label>
                                            <input type="text" id="linktitle" class="form-control" required />
                                        </div>
                                        <div class="col-md-3 col-xs-6">
                                            <label for="newurl">Url  <span id="urlErr" style="display: none"></span></label>
                                            <input type="text" id="newurl" class="form-control" required />
                                        </div>
                                        <div class="col-md-3 col-xs-6">
                                            <label for="newinfolinkstatus">Status</label>
                                            <label style="display: block;">
                                                <input type="checkbox" class="js-switch" id="newinfolinkstatus" />
                                                <span id="newinfolinkstatusval">Inactive</span>
                                            </label>
                                        </div>
                                        <button type="button" id="submitNewlink" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;">Add</button>
                                        <button type="button" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;" id="modifylink">Modify</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-12 table" style="overflow-x: auto;">
                                    <table class="table table-striped" id="infolinksTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th>Title</th>
                                                <th>Url</th>
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
                                    <div class="col-md-12">
                                        <ul class="pagination pagination-split pull-right" id="infolnksPagination">
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
        //addnewlinks        

        (function () {
            translator.lang(sessionStorage.getItem('langCode'));
            getAllInfolinks(1);


            var tablePaginator = new TablePaginator({ rowsPerPage: 5, page: 1, url: './index.aspx/ListInfoLinksForAdmin' });

            tablePaginator.httpData = function (data) {
                console.log(data);
            }

        })()

        $("#addnewlinks").on('click', function () {
            $("#newinfoLinks").slideToggle();
        });

        $('#newinfolinkstatus').on('click', function (e) {
            if ($(this).is(':checked')) {
                $('#newinfolinkstatusval').text("Active");
            }
            else {
                $('#newinfolinkstatusval').text("Inactive");
            }
        });

        $('#submitNewlink').on('click', function () {
            var linktitle = $('#linktitle').val(),
                linkurl = $('#newurl').val(),
                linkStatus = ($('#newinfolinkstatus').is(':checked') ? "Active" : "Inactive");

            if (linktitle == "") {
                $('#titleErr').text('Please enter a Title!').css({ color: 'red' }).show();
                return false;
            } else if (linkurl == "") {
                $('#titleErr').hide();
                $('#urlErr').text('Please enter a URL!').css({ color: 'red' }).show();
                return false;
            }
            $('#titleErr,#urlErr').hide();

            var newlinkDetails = {
                infoLinkTitle: linktitle,
                infoLinkUrl: linkurl,
                infoLinkstatus: linkStatus
            };

            //console.log(newlinkDetails);

            ajaxfunctioncallwithdata('POST', './index.aspx/AddInfoLinks', { infoLinkDetails: newlinkDetails }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    getAllInfolinks();
                }
            });
        });

        $('#modifylink').on('click', function () {
            var selectedlinkid = $('.catRad:checked').parents('tr');

            var linktitle = $('#linktitle').val(),
                linkid = selectedlinkid.data('links'),
                linkurl = $('#newurl').val(),
                linkStatus = ($('#newinfolinkstatus').is(':checked') ? "Active" : "Inactive");
            if (linktitle == "") {
                $('#titleErr').text('Please enter a Title!').css({ color: 'red' }).show();
                return false;
            } else if (linkurl == "") {
                $('#titleErr').hide();
                $('#urlErr').text('Please enter a URL!').css({ color: 'red' }).show();
                return false;
            }

            $('#titleErr, #urlErr').hide();

            var editlinkDetails = {
                infoLinkTitle: linktitle,
                infoLinkId: linkid,
                infoLinkUrl: linkurl,
                infoLinkstatus: linkStatus
            };

            //console.log(editlinkDetails);

            ajaxfunctioncallwithdata('POST', './index.aspx/AddInfoLinks', { infoLinkDetails: editlinkDetails }, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    getAllInfolinks();

                    selectedlinkid.attr({ 'data-links': editlinkDetails.linkid });
                    selectedlinkid.find('td:eq(2)').text(editlinkDetails.linktitle);
                    selectedlinkid.find('td:eq(3)').text(editlinkDetails.linkurl);
                    selectedlinkid.find('td:eq(4)').text(editlinkDetails.linkStatus);

                    $('#linktitle').val('');
                    $('#newurl').val('');
                    changeSwitchery($('#newinfolinkstatus'), false);
                    $('#newinfolinkstatusval').text('Inactive');
                    $('#newinfoLinks').slideUp();

                }
            });
        });

        function getAllInfolinks(pagenum) {

            var noofRowsPerPage = 10;
            var page = 1;
            if (pagenum != null || pagenum != "") {
                page = pagenum;
            } else {
                page = 1;
            }
            var startValue = (page - 1) * noofRowsPerPage;

            var objs = {
                startValue: startValue,
                noOFRows: noofRowsPerPage
            }
            ajaxfunctioncallwithdata('POST', './index.aspx/ListInfoLinksForAdmin', objs, true).then(function (resp) {
                var infoLinksDetails = resp.d;
                //console.log(infoLinksDetails, infoLinksDetails.length);
                var infolinksTable = $('#infolinksTable').find('tbody');
                infolinksTable.empty();
                if (infoLinksDetails.length > 0) {

                    for (var links in infoLinksDetails) {
                        localStorage.setItem("totalrecords", infoLinksDetails[links].count);
                        //console.log(infoLinksDetails[links]);
                        var tr = $('<tr>').attr({ 'data-links': infoLinksDetails[links].infoLinkId }).appendTo(infolinksTable);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'infolinksRad' }).addClass('flat catRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(links) + 1).appendTo(tr);
                        var td3 = $('<td>').text(infoLinksDetails[links].infoLinkTitle).appendTo(tr);
                        var td3 = $('<td>').text(infoLinksDetails[links].infoLinkUrl).appendTo(tr);
                        var td4 = $('<td>').text(infoLinksDetails[links].infoLinkstatus).appendTo(tr);
                        var td5 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;cursor:pointer"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var linkId = thisTr.attr('data-links'),
                                linktitle = thisTr.find('td:eq(2)').text(),
                                linkurl = thisTr.find('td:eq(3)').text(),
                                linkStatus = (thisTr.find('td:eq(4)').text() == "Active" ? true : false);
                            $('#newinfoLinks').slideDown();
                            $('#linktitle').val(linktitle);
                            $('#newurl').val(linkurl);
                            if (linkStatus) {
                                changeSwitchery($('#newinfolinkstatus'), true);
                                $('#newinfolinkstatusval').text('Active');
                            }
                            else {
                                changeSwitchery($('#newinfolinkstatus'), false);
                                $('#newinfolinkstatusval').text('Inactive');
                            }
                        }).appendTo(td5);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-links'));
                        }).appendTo(td5);
                    }

                    $('input.flat').iCheck({
                        checkboxClass: 'icheckbox_flat-green',
                        radioClass: 'iradio_flat-green'
                    });
                }
            });

            var totalNoofPages = Math.ceil(localStorage.getItem("totalrecords") / noofRowsPerPage);
            var startLoop = page;
            var diff = totalNoofPages - page;

            if (diff <= 5) {
                startLoop = totalNoofPages - 5;
            }
            var endloop = startLoop + 4;
            $("#infolnksPagination").empty();
            if (page > 1) {
                $('<li><a href="#" onclick="getAllInfolinks(1)">FIRST</a></li>').appendTo("#infolnksPagination");
                $('<li><a href="#" onclick="getAllInfolinks(' + (page - 1) + ')"><<</a></li>').appendTo("#infolnksPagination");
            }
            for (i = startLoop; i <= endloop; i++) {
                if (i > 0) {
                    $('<li><a href="#" onclick="getAllInfolinks(' + i + ')">' + i + '</a></li>').appendTo("#infolnksPagination");
                }
            }
            if (page <= endloop) {
                $('<li><a href="#" onclick="getAllInfolinks(' + (page + 1) + ')">>></a></li>').appendTo("#infolnksPagination");
                $('<li><a href="#" onclick="getAllInfolinks(' + totalNoofPages + ')">LAST</a></li>').appendTo("#infolnksPagination");
            }
        }

    </script>
</asp:Content>
