<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="smsConfiguration.aspx.cs" Inherits="ReachHelpWF.main.smsConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>SMS Configuration</h3>
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
                            <h2><small>Configure SMS Gateway.</small></h2>
                            <div style="display: inline-block; margin-left: 50px;">
                                <button type="button" class="btn btn-sm btn-round btn-primary" id="addNewSmsConfig">New</button>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="smsConfigCont" style="display: none;">
                                <div class="row">
                                    <div class="col-xs-12">

                                        <div class="row">
                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="providerName">Provider Name*</label>
                                                <input type="text" id="providerName" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="baseUrl">Base Url</label>
                                                <input type="text" id="baseUrl" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="username">Username*</label>
                                                <input type="text" id="username" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="senderId">Sender Id*</label>
                                                <input type="text" id="senderId" class="form-control" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="password">Password*</label>
                                                <input type="text" id="password" class="form-control" />
                                            </div>
                                        </div>


                                        <div class="row" style="padding: 0 10px">
                                            <button type="button" class="btn btn-md btn-primary" id="createSMSConfig">Create</button>
                                            <button type="button" class="btn btn-md btn-primary" id="modifySMSConfig">Update</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-6" id="smsConfigList">                                    
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
            getConfigList();
        })()

        $("#addNewSmsConfig").on('click', function () {
            $("#smsConfigCont").slideToggle();
        });


        $('#createSMSConfig').on('click', function () {
            var smsConfigObj = {
                provider: $('#providerName').val(),
                baseUrl: $('#baseUrl').val(),
                userName: $('#username').val(),
                senderId: $('#senderId').val(),
                password: $('#password').val(),
                status: 'Active',
            };

            if (smsConfigObj.provider == "") { swal('Alert!', 'Please enter a provider.', 'warning'); return false; }
            if (smsConfigObj.baseUrl == "") { swal('Alert!', 'Please enter a baseUrl.', 'warning'); return false; }
            if (smsConfigObj.userName == "") { swal('Alert!', 'Please enter a userName.', 'warning'); return false; }
            if (smsConfigObj.senderId == "") { swal('Alert!', 'Please enter a senderId.', 'warning'); return false; }
            if (smsConfigObj.password == "") { swal('Alert!', 'Please enter a password.', 'warning'); return false; }

            //console.log("SMS CONFIG : ", smsConfigObj);
            //return false;

            ajaxfunctioncallwithdata('POST', './smsConfiguration.aspx/AddSMSMaster', { smsDetails: smsConfigObj }, true)
            .then(function (resp) {
                if (resp.d) {
                    swal('Success!', 'SMS Configuration successful', 'success');
                    $('#providerName,#baseUrl,#userName,#senderId,#password').val('');
                }
                else {
                    swal('Oops!', 'Something went wrong', 'danger');
                }
            });

        });


        function getConfigList() {
            var smsConfigList = $('#smsConfigList');
            smsConfigList.empty();
            ajaxfunctioncallwithoutdata('POST', './smsConfiguration.aspx/ListSMSOperators', true).then(function (resp) {
                var smsConfigs = resp.d;
                /*
                <div class="x_content">
                    <h4>Star Ratings<small> Hover and click on a star</small></h4>
                    <div>
                      <div class="starrr stars"></div>
                      You gave a rating of <span class="stars-count">0</span> star(s)
                    </div>

                    <p>Also you can give a default rating by adding attribute data-rating</p>
                    <div class="starrr stars-existing" data-rating='4'></div>
                    You gave a rating of <span class="stars-count-existing">4</span> star(s)
                  </div>
                */

                smsConfigs.forEach(function (elem, index, arr) {

                    var xContent = $('<div>').appendTo(smsConfigList);
                    var h4 = $('<h4>').text(elem.provider+" ").appendTo(xContent);
                    $('<small>').appendTo(h4);
                    $('<span>').addClass('time').text(elem.status).appendTo(xContent);
                    var div = $('<div>').appendTo(xContent);
                    $('<p>').text('Sender Id: ' + elem.senderId).appendTo(div);
                    $('<p>').text('Username: ' + elem.userName).appendTo(div);
                    $('<p>').text('Password: ' + elem.password).appendTo(div);
                    $('<p>').text('Base URL: ' + elem.baseUrl).appendTo(div);                    
                });

            });
        }



    </script>
</asp:Content>
