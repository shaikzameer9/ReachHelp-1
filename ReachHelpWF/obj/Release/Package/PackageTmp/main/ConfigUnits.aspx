<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="ConfigUnits.aspx.cs" Inherits="ReachHelpWF.main.ConfigUnits" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">All Units</h3>
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
                            <h2><small>List of Units</small></h2>
                            <div style="display: inline-block; margin-left: 50px;">
                                <button type="button" class="btn btn-sm btn-round btn-primary trn" id="addNewUnit">New</button>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="newUnitCont" style="display: none;">
                                <div class="row">
                                    <div class="col-xs-12">

                                        <div class="row">
                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="unitName" class="trn">Unit Name*</label>
                                                <input type="text" id="unitName" class="form-control" />
                                            </div>                                            
                                        </div>

                                        <div class="row" style="padding: 0 10px;">
                                            <button type="button" class="btn btn-md btn-primary trn" id="createUnit">Create</button>
                                            <button type="button" class="btn btn-md btn-primary trn" id="modifyUnit">Update</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-12 table" style="overflow-x:auto">
                                    <table class="table table-striped" id="unitsTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th class="trn">Unit Name</th>
                                                <th class="trn">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="4" class="trn">-- No Data --</td>
                                            </tr>
                                        </tbody>
                                    </table>
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

            getAllUnits();

        })()

        $("#addNewUnit").on('click', function () {
            $("#newUnitCont").slideToggle();

            $('#unitName').val('');
        });

        $('#createUnit').on('click', function () {
            var unitDetails = {
                unitName: $('#unitName').val()
            };

            if (unitDetails.unitName == "") {
                swal("Please enter a Unit Name!");
                return false;
            }

            ajaxfunctioncallwithdata("POST", "./ConfigUnits.aspx/AddUpdateUnit", { unitConfig: unitDetails }, true).then(function (resp) {
                //console.log(resp.d);
                if(resp.d){
                    swal("Success!", 'Unit added successfully.', 'success');
                    $('#unitName').val('');

                    $('#newUnitCont').slideUp();
                    getAllUnits();
                }
                else{
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });

        });

        $('#modifyUnit').on('click', function () {
            var unitDetails = {
                unitId: $('#unitName').attr('data-id'),
                unitName: $('#unitName').val()
            };

            if (unitDetails.unitName == "") {
                swal("Please enter a Unit Name!");
                return false;
            }
           
            ajaxfunctioncallwithdata("POST", "./ConfigUnits.aspx/AddUpdateUnit", { unitConfig: unitDetails }, true).then(function (resp) {
                //console.log(resp.d);
                if(resp.d){
                    swal("Success!", 'Unit updated successfully.', 'success');
                    $('#unitName').val('');
                    $('#unitName').removeAttr('data-id');
                    
                    $('#newUnitCont').slideUp();
                    getAllUnits();
                }
                else{
                    swal("Oops!", 'Something went wrong.', 'danger');
                }

            });
        });



        function getAllUnits() {
            ajaxfunctioncallwithoutdata("POST", "./ConfigUnits.aspx/GetAllUnits", true).then(function (resp) {
                //console.log(resp.d);
                var unitList = resp.d;
                var usrTableBody = $('#unitsTable').find('tbody');
                usrTableBody.empty();
                for (var unt in unitList) {
                    var tr = $('<tr>').attr({ 'data-id': unitList[unt].unitId, 'data-info': btoa(JSON.stringify(unitList[unt])) }).appendTo(usrTableBody);
                    var td0 = $('<td>').attr({}).appendTo(tr);// radio button
                    var usrRad = $('<input>').attr({ type: 'radio', name: 'radUnit' }).addClass('flat unitRad').appendTo(td0);

                    var td1 = $('<td>').attr({}).text(parseInt(unt) + 1).appendTo(tr);// Sl.no                    
                    var td2 = $('<td>').attr({}).text(unitList[unt].unitName).appendTo(tr);// Sl.no                    
                    var td3 = $('<td>').attr({}).appendTo(tr);// Action

                    var editSpan = $('<span>').css({ 'font-size': 'large', color: 'orange', margin: '0 5px' }).bind('click', function () {
                        var thisTr = $(this).parents('tr');                      
                        thisTr.find('td:eq(0) input').iCheck('check');

                        var untId = thisTr.attr('data-id');
                        $('#newUnitCont').slideDown();                        
                        $('#unitName').attr({ 'data-id': untId }).val(thisTr.find('td:eq(2)').text());
                    }).appendTo(td3);
                    $('<i>').addClass('fa fa-pencil').appendTo(editSpan);
                    var delSpan = $('<span>').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).appendTo(td3);
                    $('<i>').addClass('fa fa-trash-o').appendTo(delSpan);

                }

                $('#unitsTable').on('draw.dt', function () {
                    $('input.flat').iCheck({
                        checkboxClass: 'icheckbox_flat-green',
                        radioClass: 'iradio_flat-green'
                    });
                });

                $('input.flat').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });

            });
        }

        

    </script>
</asp:Content>
