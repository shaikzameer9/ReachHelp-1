<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="allUsers.aspx.cs" Inherits="ReachHelpWF.main.allUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">All Users</h3>
                </div>
            </div>

            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2><small>List of all the users.</small></h2>
                            <div style="display: inline-block; margin-left: 50px;">
                                <button type="button" class="btn btn-sm btn-round btn-primary trn" id="addNewUser">New</button>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="newUserCont" style="display: none;">
                                <div class="row">
                                    <div class="col-xs-12">

                                        <div class="row">
                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="userName" class="trn">First Name<sup style="color:red">*</sup></label>
                                                <input type="text" id="userName" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="middleName" class="trn">Middle Name</label>
                                                <input type="text" id="middleName" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="lastName" class="trn">Last Name<sup style="color:red">*</sup></label>
                                                <input type="text" id="lastName" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="entityName" class="trn">Entity Name</label>
                                                <input type="text" id="entityName" class="form-control" />
                                            </div>
                                            
                                        </div>

                                        <div class="row">
                                            
                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="phoneNo" class="trn">Phone Number<sup style="color:red">*</sup></label>
                                                <input type="tel" id="phoneNo" class="form-control" placeholder="1234567890" pattern="(\+[0-9]{2}-)?[0-9]{10}" />
                                                <%--<input type="hidden" id="countryCode" />--%>
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="usrRole" class="trn">Role<sup style="color:red">*</sup></label>
                                                <select id="usrRole" class="form-control select2">
                                                    <option value="">Choose..</option>
                                                </select>
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="desgination" class="trn">Designation</label>
                                                <input type="text" id="desgination" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="country" class="trn">Country<sup style="color:red">*</sup></label>
                                                <select id="country" class="form-control select2">
                                                    <option value="">Choose..</option>
                                                </select>
                                            </div>
                                            
                                        </div>

                                        <div class="row">

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="state" class="trn">State<sup style="color:red">*</sup></label>
                                                <select id="state" class="form-control select2">
                                                    <option value="">Choose..</option>
                                                </select>
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="city" class="trn">City<sup style="color:red">*</sup></label>
                                                <input type="text" id="city" class="form-control" />
                                                <%--<select id="city" class="form-control select2">
                                                    <option value="">Choose..</option>
                                                </select>--%>
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="pincode" class="trn">Zipcode<sup style="color:red">*</sup></label>
                                                <input type="number" id="pincode" min="0" class="form-control" />
                                            </div>

                                            <div class="col-md-3 col-xs-6 form-group">
                                                <label for="email" class="trn">Email</label>
                                                <input type="text" id="email" class="form-control" />
                                            </div>                                            
                                        </div>
                                        <div class="row">
                                            <%--<div class="col-md-12 col-xs-12 form-group">
                                                <label for="address" class="trn">Address<sup style="color:red">*</sup></label>
                                                <textarea id="address" class="form-control"></textarea>
                                            </div>--%>
                                            <div class="col-md-6 col-xs-12 form-group">
                                                <label for="streetAddress1" class="trn">Street Address 1<sup style="color:red">*</sup></label>
                                                <textarea id="streetAddress1" class="form-control"></textarea>
                                            </div>
                                            <div class="col-md-6 col-xs-12 form-group">
                                                <label for="streetAddress2" class="trn">Street Address 2</label>
                                                <textarea id="streetAddress2" class="form-control"></textarea>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <h5>Your Location:</h5>
                                                <div id='map' style='height: 250px;'></div>
                                                <h6>Note:</h6>
                                                <ul>
                                                    <li><small>Drag the marker to your desired location.</small></li>
                                                    <li><small>Use Ctrl + mouse wheel to zoom into the map area.</small></li>
                                                </ul>
                                                                                        
                                            </div>
                                        </div>

                                        <div class="row">
                                            <button type="button" class="btn btn-md btn-primary trn" id="createUser">Create</button>
                                            <button type="button" class="btn btn-md btn-primary trn" id="modifyUser">Update</button>
                                        </div>



                                        <%--<div class="col-md-3">
                                            <label for="latitude">Latitude</label>
                                            <input type="text" id="latitude" class="form-control" />
                                        </div>

                                        <div class="col-md-3">
                                            <label for="longitude">Longitude</label>
                                            <input type="text" id="longitude" class="form-control" />
                                        </div>--%>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-xs-12 table" style="overflow-x:auto">
                                    <table class="table table-striped" id="userTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>#</th>
                                                <th class="trn">Name</th>
                                                <th class="trn">Entity</th>
                                                <th class="trn">Region</th>
                                                <th class="trn">Status</th>
                                                <th class="trn">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="7" class="trn">-- No Data --</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <ul class="pagination pagination-split pull-right" id="userListPagination">
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
    <script src="../lib/intl-codes/js/country_codes.js"></script>

    <script>
        var au_TotalUsers = 0;

        (function () {

            translator.lang(sessionStorage.getItem('langCode'));

            $('.select2').select2({ width: '100%' });

            getCountryList();


            

            $('#phoneNo').intlTelInput({                
                //initialCountry: "in",
                separateDialCode: true,
                nationalMode: false,
                formatOnDisplay: false,
            });

            ajaxfunctioncallwithoutdata("POST", "./index.aspx/ListRoles", true).then(function (resp) {
                //console.log(resp.d);
                var roleList = resp.d;
                $('#usrRole').empty();
                $('<option>').attr({ value: '' }).text("Choose...").appendTo('#usrRole');
                for (var role in roleList) {
                    $('<option>').attr({ value: roleList[role].roleId }).text(roleList[role].roleName).appendTo('#usrRole');
                }
            });

            getAllMonitors(1);

        })()

        var map, marker, myGeoLocation = {lat:0.0, long:0.0}, bounds;
        function initMap() {
            var myLatLng = { lat: 38.23894, lng: -100.98725 };
            map = new google.maps.Map(document.getElementById('map'), {
                center: myLatLng,
                zoom: 4
            });

            bounds  = new google.maps.LatLngBounds();

            marker = new google.maps.Marker({
                position: myLatLng,
                map: map,
                draggable: true,
                title: 'Me'
            });


            map.addListener('click', function(e) {
                var position = e.latLng;                
                //marker.setMap(null);
                //marker = new google.maps.Marker({
                //    position: position,
                //    map: map
                //});                           
                //map.panTo(position);               
                myGeoLocation.lat = e.latLng.lat();
                myGeoLocation.long = e.latLng.lng();
                setMarker(myGeoLocation.lat,myGeoLocation.long);
            });
           

            google.maps.event.addListener(marker, 'dragend', function (event) {
                myGeoLocation.lat = event.latLng.lat();
                myGeoLocation.long = event.latLng.lng();
            });

        }

        function setMarker(lat,lng){
            marker.setMap(null);
            var position = new google.maps.LatLng(lat, lng);
            marker = new google.maps.Marker({
                position: position,
                map: map
            });                           
            map.panTo(position);
        }

        $("#addNewUser").on('click', function () {
            $("#newUserCont").slideToggle();

            $('#userName,#middleName,#lastName,#entityName,#phoneNo,#desgination,#pincode,#streetAddress1, #streetAddress2,#countryCode').val('');//#address
            $('#usrRole').val('').trigger('change');
            $('#country').val('').trigger('change');
            $('#state').val('').trigger('change');
            $('#city').val('');//.trigger('change');
            
            //$('#pwd1').attr({ 'disabled': true });
            //$('#pwd1').parents('div.form-group').hide();
            //$('#pwd2').attr({ 'disabled': true });
            //$('#pwd2').parents('div.form-group').hide();

            //$('#country').val(usrInfo.countryId);
            //$('#state').val(usrInfo.stateId);
            //$('#city').val(usrInfo.cityId);          

            //$('#pwd1').attr({ 'disabled': false });
            //$('#pwd1').parents('div.form-group').show();
            //$('#pwd2').attr({ 'disabled': false });
            //$('#pwd2').parents('div.form-group').show();
        });

        $('#country').on('change', function () {
            var country = $(this).val();
            getStateList(country);


            var countryName = $(this).find('option:selected').text();

            //console.info("Selected Country: ", countryName);

            var countryDetails = cc.filter(function (item) {
                if (item.country.trim().toLowerCase() == countryName.trim().toLowerCase()) {
                    console.log(item.country, item.code, countryName);
                    return item.code;
                }
            });
            //console.info("Country Name : ", countryName, " ; Code: ", countryDetails[0]);
            //$('#countryCode').val(countryDetails[0].code);
        });

        /*$('#state').on('change', function () {
            var state = $(this).val();
            getCityList(state);
        });*/

        $('#createUser').on('click', function () {
            var userDetails = {
                userName: $('#userName').val(),
                middleName: $('#middleName').val(),
                lastName: $('#lastName').val(),
                entityName: $('#entityName').val(),
                phoneNumber: $('#phoneNo').val(),
                
                countryCode:$('#phoneNo').intlTelInput("getSelectedCountryData").dialCode,

                designation: $('#desgination').val(),
                pincode: $('#pincode').val(),
                
                //address: $('#address').val(),
                streetAddress1 :$('#streetAddress1').val(),
                streetAddress2 :$('#streetAddress2').val(),

                roleId: $('#usrRole').val(),
                countryId: $('#country').val(),
                stateId: $('#state').val(),
                
                //cityId: $('#city').val(),
                cityName: $('#city').val(),

                emailId:$('#email').val(),
                latitude:myGeoLocation.lat,
                longitude:myGeoLocation.long,
                countryCode:$('#countryCode').val()
            };
            //var pwd1 = $('#pwd1').val(),
            //    pwd2 = $('#pwd2').val();

            if (userDetails.userName == "") {
                swal("Please enter a Name!");
                return false;
            }

            if (userDetails.phoneNumber == "") {
                swal("Please enter Phone Number!");
                return false;
            }

            if (userDetails.pincode == "") {
                swal("Please enter a Zipcode!");
                return false;
            }
            
            if(userDetails.pincode.length > 6 || userDetails.pincode.length < 5){
                swal("Zipcode should be either 5 or 6 digit")
                return false;
            }

            //if (userDetails.address == "") {
            //    swal("Please enter an Address!");
            //    return false;
            //}

            if (userDetails.streetAddress1 == "") {
                swal("Please enter an Address!");
                return false;
            }

            if (userDetails.roleId == "") {
                swal("Please select a Role!");
                return false;
            }

            if (userDetails.countryId == "") {
                swal("Please select a Country!");
                return false;
            }

            if (userDetails.stateId == "") {
                swal("Please select a State!");
                return false;
            }

            //if (userDetails.cityId == "") {
            //    swal("Please select a City!");
            //    return false;
            //}

            if (userDetails.cityName == "") {
                swal("Please enter a City!");
                return false;
            }

            //if (pwd1 != pwd2) {
            //    alert("Passwords do not match!");
            //    return false;
            //}

            //userDetails['password'] = pwd1;            
            ajaxfunctioncallwithdata("POST", "./index.aspx/AddUser", { userDetails: userDetails }, true).then(function (resp) {
                //console.log(resp.d);
                if(resp.d){
                    swal("Success!", 'User added successfully.', 'success');
                    $('#userName,#middleName,#lastName').val('');
                    $('#entityName').val('');
                    $('#phoneNo').val('');
                    $('#email').val('');
                    $('#desgination').val('');
                    $('#pincode').val('');
                    
                    //$('#address').val('');
                    $('#streetAddress1').val('');
                    $('#streetAddress2').val('');

                    $('#usrRole').val('').trigger('change');
                    $('#country').val('').trigger('change');
                    $('#state').val('').trigger('change');
                    $('#city').val('');//.trigger('change');

                    $('#countryCode').val('');

                    $('#newUserCont').slideUp();
                    getAllMonitors(1);
                }
                else{
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });

        });


        $('#modifyUser').on('click', function () {      
            console.log($('#phoneNo').intlTelInput("getSelectedCountryData").dialCode);

            var userDetails = {
                userName: $('#userName').val(),

                middleName:$('#middleName').val(),
                lastName:$('#lastName').val(),
                countryCode:$('#phoneNo').intlTelInput("getSelectedCountryData").dialCode,

                entityName: $('#entityName').val(),
                phoneNumber: $('#phoneNo').val(),
                designation: $('#desgination').val(),
                pincode: $('#pincode').val(),
                
                //address: $('#address').val(),
                streetAddress1: $('#streetAddress1').val(),
                streetAddress2: $('#streetAddress2').val(),

                roleId: $('#usrRole').val(),
                countryId: $('#country').val(),
                stateId: $('#state').val(),
                
                //cityId: $('#city').val(),
                cityName: $('#city').val(),

                emailId:$('#email').val(),
                latitude:myGeoLocation.lat,
                longitude:myGeoLocation.long,                
            };

            if (userDetails.userName == "") {
                swal("Please enter a First Name!");
                return false;
            }

            if (userDetails.lastName == "") {
                swal("Please enter a Last Name!");
                return false;
            }

            if (userDetails.phoneNumber == "") {
                swal("Please enter Phone Number!");
                return false;
            }

            if (userDetails.pincode == "") {
                swal("Please enter a Zipcode!");
                return false;
            }

            if(userDetails.pincode.length > 6 || userDetails.pincode.length < 5){
                swal("Zipcode should be either 5 or 6 digit")
                return false;
            }

            //if (userDetails.address == "") {
            //    swal("Please enter an Address!");
            //    return false;
            //}
            if (userDetails.streetAddress1 == "") {
                swal("Please enter an Address!");
                return false;
            }

            if (userDetails.roleId == "") {
                swal("Please select a Role!");
                return false;
            }

            if (userDetails.countryId == "") {
                swal("Please select a Country!");
                return false;
            }

            if (userDetails.stateId == "") {
                swal("Please select a State!");
                return false;
            }

            //if (userDetails.cityId == "") {
            //    swal("Please select a City!");
            //    return false;
            //}
            if (userDetails.cityName == "") {
                swal("Please enter a City!");
                return false;
            }
           
            //console.log("Update User Details : ",userDetails);

            //return false;
            ajaxfunctioncallwithdata("POST", "./index.aspx/AddUser", { userDetails: userDetails }, true).then(function (resp) {
                //console.log(resp.d);
                if(resp.d){
                    swal("Success!", 'User updated successfully.', 'success');
                    $('#userName').val('');
                    $('#entityName').val('');
                    $('#phoneNo').val('');
                    $('#email').val('');
                    $('#desgination').val('');
                    $('#pincode').val('');
                    
                    //$('#address').val('');
                    $('#streetAddress1').val('');
                    $('#streetAddress2').val('');

                    $('#usrRole').val('').trigger('change');
                    $('#country').val('').trigger('change');
                    $('#state').val('').trigger('change');
                    $('#city').val('');//.trigger('change');

                    $('#newUserCont').slideUp();
                    getAllMonitors(1);
                }
                else{
                    swal("Oops!", 'Something went wrong.', 'danger');
                }

            });
        });

        //$('.usrStatusChkBx').on('click', function (e) {
        //    alert("dfsdf");
        //    var thiChkBox = $(this);
        //    if ($(this).is(':checked')) {
        //        $(this).siblings('span.usrStatusChkBxVal').text("Active");
        //    }
        //    else {
        //        $(this).siblings('span.usrStatusChkBxVal').text("Inactive");
        //    }
        //});

        async function populateRegionList(regionInfo){
            $('#country').val(regionInfo.country).trigger('change');
            await getStateList(regionInfo.country);
            $('#state').val(regionInfo.state).trigger('change');
            //await getCityList(regionInfo.state);
            //$('#city').val(regionInfo.city).trigger('change');
        }
       

        function getCountryList(){
            return ajaxfunctioncallwithoutdata("POST", "./index.aspx/GetCountries", true).then(function (resp) {
                //console.log(resp.d);
                var countryList = resp.d;
                $('#country').empty();
                $('<option>').attr({ value: '' }).text("Choose...").appendTo('#country');
                for (var ctry in countryList) {
                    $('<option>').attr({ value: countryList[ctry].countryId }).text(countryList[ctry].countryName).appendTo('#country');
                }
            });
        }

        function getStateList(country){
            return ajaxfunctioncallwithdata("POST", "./index.aspx/GetStates", { countryId: country }, true).then(function (resp) {
                //console.log(resp.d);
                var stateList = resp.d;
                $('#state').empty();
                $('<option>').attr({ value: '' }).text("Choose...").appendTo('#state');
                for (var st in stateList) {
                    $('<option>').attr({ value: stateList[st].stateId }).text(stateList[st].stateName).appendTo('#state');
                }
            });
        }

        /*function getCityList(state){
            return ajaxfunctioncallwithdata("POST", "./index.aspx/GetCities", { stateId: state }, true).then(function (resp) {
                //console.log(resp.d);
                var cityList = resp.d;
                $('#city').empty();
                $('<option>').attr({ value: '' }).text("Choose...").appendTo('#city');
                for (var ct in cityList) {
                    $('<option>').attr({ value: cityList[ct].cityId }).text(cityList[ct].cityName).appendTo('#city');
                }
            });
        }*/


        function getAllMonitors(pagenum){
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
            ajaxfunctioncallwithdata('POST', './index.aspx/GetAllMonitors', objs, true).then(function (resp) {
                var userList = resp.d;
                console.log(userList, userList.length);
                var usrTableBody = $('#userTable').find('tbody');
                usrTableBody.empty();
                if (userList.length > 0) {

                    userList.map(function (elem, index, arr) {
                        au_TotalUsers = elem.count;
                        
                        var tr = $('<tr>').attr({ 'data-id': elem.userId, 'data-info': btoa(JSON.stringify(elem)) }).appendTo(usrTableBody);
                        var td0 = $('<td>').attr({}).appendTo(tr);// radio button
                        var usrRad = $('<input>').attr({ type: 'radio', name: 'radUsr' }).addClass('flat usrRad').appendTo(td0);

                        var td1 = $('<td>').attr({}).text(parseInt(index) + 1).appendTo(tr);// Sl.no
                        var td2 = $('<td>').attr({}).text(elem.userName+" "+(elem.middleName !=""?elem.middleName+"  ":"")+elem.lastName).appendTo(tr);// Name
                        var td3 = $('<td>').attr({}).text(elem.entityName == "" ? "NA" : elem.entityName).appendTo(tr);// Entity Name
                        var td7 = $('<td>').attr({}).text(elem.cityName+", "+elem.stateName).appendTo(tr);
                        var td5 = $('<td>').attr({}).appendTo(tr);// Status

                        var statusChkBxLbl = $('<label>').css({ display: 'block' }).appendTo(td5);
                        $('<input>').attr({ type: 'checkbox', checked: (elem.status == "Active" ? true : false) }).addClass('js-switch usrStatusChkBx').bind('click', function () {
                            var thiChkBox = $(this);
                            var userId = $(this).parents('tr').attr('data-id');
                            if ($(this).is(':checked')) {
                                $(this).siblings('span.usrStatusChkBxVal').text("Active");
                                updateUserStatus(userId, "Active",thiChkBox);
                            }
                            else {
                                $(this).siblings('span.usrStatusChkBxVal').text("Inactive");
                                updateUserStatus(userId, "Inactive",thiChkBox);
                            }
                        }).appendTo(statusChkBxLbl);
                        $('<span>').addClass('usrStatusChkBxVal').text(elem.status).appendTo(statusChkBxLbl);

                        var td6 = $('<td>').attr({}).appendTo(tr);// Action

                        var editSpan = $('<span>').css({ 'font-size': 'large', color: 'orange', margin: '0 5px' }).bind('click', function () {
                            var thisTr = $(this).parents('tr');
                            var usrData = JSON.parse(atob(thisTr.data('info')));
                            console.log("USR DATA : ", usrData);

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var usrId = thisTr.attr('data-id'),
                                usrInfo = JSON.parse(atob(thisTr.attr('data-info')));
                            console.log(usrInfo);
                            $('#newUserCont').slideDown();
                            $('#userName').val(usrInfo.userName);
                            $('#middleName').val(usrInfo.middleName);
                            $('#lastName').val(usrInfo.lastName);
                            $('#entityName').val(usrInfo.entityName);
                            
                            //$('#phoneNo').val(usrInfo.phoneNumber);
                            $('#phoneNo').intlTelInput("setNumber",usrInfo.phoneNumber);  

                            if(usrInfo.countryCode != ''){
                                var countryIso = cc.filter(function(item){                                  
                                    if(item.code == usrInfo.countryCode)
                                        return item.iso;
                                });                
                                $('#phoneNo').intlTelInput("setCountry",countryIso[0].iso.toLowerCase());
                            }
                            

                            $('#countryCode').val(usrInfo.countryCode);
                            $('#email').val(usrInfo.emailId);
                            $('#usrRole').val(usrInfo.roleId).trigger('change');
                            $('#desgination').val(usrInfo.designation);

                            //$('#pwd1').attr({ 'disabled': true });
                            //$('#pwd1').parents('div.form-group').hide();
                            //$('#pwd2').attr({ 'disabled': true });
                            //$('#pwd2').parents('div.form-group').hide();

                            //$('#country').val(usrInfo.countryId);
                            //$('#state').val(usrInfo.stateId);
                            //$('#city').val(usrInfo.cityId);

                            $('#city').val(usrInfo.cityName);

                            $('#pincode').val(usrInfo.pincode);
                            
                            //$('#address').val(usrInfo.address);
                            $('#streetAddress1').val(usrInfo.streetAddress1);
                            $('#streetAddress2').val(usrInfo.streetAddress2);
                           
                            //marker.setMap(null);
                            //var position = new google.maps.LatLng(usrInfo.latitude, usrInfo.longitude);
                            //marker = new google.maps.Marker({
                            //    position: position,
                            //    map: map
                            //});                           
                            //map.panTo(position);
                            setMarker(usrInfo.latitude, usrInfo.longitude);

                            populateRegionList({ country: usrInfo.countryId, state:usrInfo.stateId, city:usrInfo.cityId });

                        }).appendTo(td6);
                        $('<i>').addClass('fa fa-pencil').appendTo(editSpan);
                        var delSpan = $('<span>').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).appendTo(td6);
                        $('<i>').addClass('fa fa-trash-o').appendTo(delSpan);

                        var elem = tr.find('.usrStatusChkBx')[0];
                        new Switchery(elem);

                    });                    

                    $('input.usrRad').iCheck({
                        radioClass: 'iradio_flat-green'
                    });
                }
                else {
                }




                var totalNoofPages = Math.ceil(au_TotalUsers / noofRowsPerPage);
                var startLoop = page;
                var diff = totalNoofPages - page;

                if (diff <= 5) {
                    startLoop = totalNoofPages - 5;
                }
                var endloop = startLoop + 4;
                $("#userListPagination").empty();
                if (page > 1) {
                    $('<li><a href="#" onclick="getAllMonitors(1)">FIRST</a></li>').appendTo("#userListPagination");
                    $('<li><a href="#" onclick="getAllMonitors(' + (page - 1) + ')"><<</a></li>').appendTo("#userListPagination");
                }
                for (i = startLoop; i <= endloop; i++) {
                    if (i > 0) {
                        $('<li><a href="#" onclick="getAllMonitors(' + i + ')">' + i + '</a></li>').appendTo("#userListPagination");
                    }
                }
                if (page <= endloop) {
                    $('<li><a href="#" onclick="getAllMonitors(' + (page + 1) + ')">>></a></li>').appendTo("#userListPagination");
                    $('<li><a href="#" onclick="getAllMonitors(' + totalNoofPages + ')">LAST</a></li>').appendTo("#userListPagination");
                }
            });
        }


        /*function getAllMonitors(){
            ajaxfunctioncallwithoutdata("POST", "./index.aspx/GetAllMonitors", true).then(function (resp) {
                //console.log(resp.d);
                var userList = resp.d;
                var usrTableBody = $('#userTable').find('tbody');
                usrTableBody.empty();
                for (var user in userList) {
                    var tr = $('<tr>').attr({ 'data-id': userList[user].userId, 'data-info': btoa(JSON.stringify(userList[user])) }).appendTo(usrTableBody);
                    var td0 = $('<td>').attr({}).appendTo(tr);// radio button
                    var usrRad = $('<input>').attr({ type: 'radio', name: 'radUsr' }).addClass('flat usrRad').appendTo(td0);

                    var td1 = $('<td>').attr({}).text(parseInt(user) + 1).appendTo(tr);// Sl.no
                    var td2 = $('<td>').attr({}).text(userList[user].userName).appendTo(tr);// Name
                    var td3 = $('<td>').attr({}).text(userList[user].entityName == "" ? "NA" : userList[user].entityName).appendTo(tr);// Entity Name
                    var td7 = $('<td>').attr({}).text(userList[user].cityName+", "+userList[user].stateName).appendTo(tr);
                    var td5 = $('<td>').attr({}).appendTo(tr);// Status

                    var statusChkBxLbl = $('<label>').css({ display: 'block' }).appendTo(td5);
                    $('<input>').attr({ type: 'checkbox', checked: (userList[user].status == "Active" ? true : false) }).addClass('js-switch usrStatusChkBx').bind('click', function () {
                        var thiChkBox = $(this);
                        var userId = $(this).parents('tr').attr('data-id');
                        if ($(this).is(':checked')) {
                            $(this).siblings('span.usrStatusChkBxVal').text("Active");
                            updateUserStatus(userId, "Active",thiChkBox);
                        }
                        else {
                            $(this).siblings('span.usrStatusChkBxVal').text("Inactive");
                            updateUserStatus(userId, "Inactive",thiChkBox);
                        }
                    }).appendTo(statusChkBxLbl);
                    $('<span>').addClass('usrStatusChkBxVal').text(userList[user].status).appendTo(statusChkBxLbl);

                    var td6 = $('<td>').attr({}).appendTo(tr);// Action

                    var editSpan = $('<span>').css({ 'font-size': 'large', color: 'orange', margin: '0 5px' }).bind('click', function () {
                        var thisTr = $(this).parents('tr');
                        var usrData = JSON.parse(atob(thisTr.data('info')));
                        //console.log("USR DATA : ", usrData);

                        thisTr.find('td:eq(0) input').iCheck('check');

                        var usrId = thisTr.attr('data-id'),
                            usrInfo = JSON.parse(atob(thisTr.attr('data-info')));
                        //console.log(usrInfo);
                        $('#newUserCont').slideDown();
                        $('#userName').val(usrInfo.userName);
                        $('#entityName').val(usrInfo.entityName);
                        $('#phoneNo').val(usrInfo.phoneNumber);
                        $('#email').val(usrInfo.emailId);
                        $('#usrRole').val(usrInfo.roleId).trigger('change');
                        $('#desgination').val(usrInfo.designation);

                        //$('#pwd1').attr({ 'disabled': true });
                        //$('#pwd1').parents('div.form-group').hide();
                        //$('#pwd2').attr({ 'disabled': true });
                        //$('#pwd2').parents('div.form-group').hide();

                        //$('#country').val(usrInfo.countryId);
                        //$('#state').val(usrInfo.stateId);
                        //$('#city').val(usrInfo.cityId);
                        $('#pincode').val(usrInfo.pincode);
                        $('#address').val(usrInfo.address);

                        populateRegionList({ country: usrInfo.countryId, state:usrInfo.stateId, city:usrInfo.cityId });

                    }).appendTo(td6);
                    $('<i>').addClass('fa fa-pencil').appendTo(editSpan);
                    var delSpan = $('<span>').css({ 'font-size': 'large', color: 'crimson', margin: '0 5px' }).appendTo(td6);
                    $('<i>').addClass('fa fa-trash-o').appendTo(delSpan);

                    var elem = tr.find('.usrStatusChkBx')[0];
                    new Switchery(elem);                    
                }

                $('#offersTable').on('draw.dt', function () {
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
        }*/

        function updateUserStatus(userId, status, thisObj){
            ajaxfunctioncallwithdata("POST","./index.aspx/UpdateUserStatus",{userId:userId,status:status},true)
                .then(function(resp){
                    if(resp.d){
                        swal('Update successful');
                    }
                    else{
                        changeSwitchery(thisObj, (status == 'Active'?false:true));
                        thisObj.siblings('span.usrStatusChkBxVal').text((status == 'Active'?"Inactive":"Active"));
                        
                    }
                },function(err){
                    console.error("ERROR: ",err);
                    changeSwitchery(thisObj, (status == 'Active'?false:true));
                    thisObj.siblings('span.usrStatusChkBxVal').text((status == 'Active'?"Inactive":"Active"));
                });
        }

    </script>
</asp:Content>
