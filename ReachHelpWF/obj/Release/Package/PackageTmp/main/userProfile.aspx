<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="userProfile.aspx.cs" Inherits="ReachHelpWF.main.userProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>My Profile</h3>
                </div>

                <%-- <div class="title_right">
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
                            <h2><small>My profile information</small></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-xs-12">

                                    <div class="row">
                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="userName">Full Name <sup style="color:red">*</sup></label>
                                            <input type="text" id="userName" class="form-control" />
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="middleName">Middle Name</label>
                                            <input type="text" id="middleName" class="form-control" />
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="lastName">Last Name <sup style="color:red">*</sup></label>
                                            <input type="text" id="lastName" class="form-control" />
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="entityName">Entity Name</label>
                                            <input type="text" id="entityName" class="form-control" />
                                        </div>
                                        
                                    </div>

                                    <div class="row">

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="designation">Designation</label>
                                            <input type="text" id="designation" class="form-control" />
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="usrRole">Role <sup style="color:red">*</sup></label>
                                            <label id="usrRole" class="form-control"></label>
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="country">Country <sup style="color:red">*</sup></label>
                                            <select id="country" class="form-control select2">
                                                <option value="">Choose..</option>
                                            </select>
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="state">State <sup style="color:red">*</sup></label>
                                            <select id="state" class="form-control select2">
                                                <option value="">Choose..</option>
                                            </select>
                                        </div>
                                        
                                    </div>

                                    <div class="row">
                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="city">City <sup style="color:red">*</sup></label>
                                            <input type="text" id="city" class="form-control" />
                                            <%--<select id="city" class="form-control select2">
                                                <option value="">Choose..</option>
                                            </select>--%>
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="pincode">Zipcode <sup style="color:red">*</sup></label>
                                            <input type="number" id="pincode" class="form-control" />
                                        </div>


                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="phoneNo">Phone Number <sup style="color:red">*</sup></label>
                                            <input type="tel" id="phoneNo" class="form-control" placeholder="1234567890" pattern="(\+[0-9]{2}-)?[0-9]{10}" />
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="email">Email</label>
                                            <input type="email" id="email" class="form-control" />
                                        </div>
                                        
                                    </div>

                                    <div class="row">
                                        <%--<div class="col-md-3 col-xs-12 form-group">
                                            <label for="address">Address <sup style="color:red">*</sup></label>
                                            <textarea id="address" class="form-control"></textarea>
                                        </div>--%>

                                        <div class="col-md-3 col-xs-12 form-group">
                                            <label for="streetAddress1">Street Address 1 <sup style="color:red">*</sup></label>
                                            <textarea id="streetAddress1" class="form-control"></textarea>
                                        </div>

                                        <div class="col-md-3 col-xs-12 form-group">
                                            <label for="streetAddress2">Street Address 2</label>
                                            <textarea id="streetAddress2" class="form-control"></textarea>
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="oldPwd">Old Password</label>
                                            <input type="password" id="oldPwd" class="form-control" />
                                        </div>

                                        <div class="col-md-3 col-xs-6 form-group">
                                            <label for="newPwd">New Password</label>
                                            <input type="password" id="newPwd" class="form-control" />
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
                                        <div class="col-md-3">
                                            <button type="button" class="btn btn-md btn-primary" id="updateProfile">Update Profile</button>
                                        </div>
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

            $('.select2').select2({width:'100%'});

            $('#phoneNo').intlTelInput({                
                //initialCountry: "in",
                separateDialCode: true,
                nationalMode: false,
                formatOnDisplay: false,
            });


            getCountryList();
            getUserDetails('');
            
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

            google.maps.event.addListener(marker, 'dragend', function (event) {
                myGeoLocation.lat = event.latLng.lat();
                myGeoLocation.long = event.latLng.lng();
            });

        }


        $('#phoneNo').on('countrychange',function(e){
            console.log(e);
        })

        $('#updateProfile').on('click',function(){
            var userDetails = {
                userId:'TAKE FROM SESSION',
                userName:$('#userName').val(),

                middleName:$('#middleName').val(),
                lastName:$('#lastName').val(),

                countryCode:$('#phoneNo').intlTelInput("getSelectedCountryData").dialCode,

                roleId:'',
                emailId:$('#email').val(),
                phoneNumber:$('#phoneNo').val(),
                password:$('#newPwd').val(),
                entityName:$('#entityName').val(),
                designation:$('#designation').val(),
                //address:$('#address').val(),

                streetAddress1:$('#streetAddress1').val(),
                streetAddress2:$('#streetAddress2').val(),

                countryId:$('#country').val(),
                stateId:$('#state').val(),
                //cityId:$('#city').val(),
                cityName:$('#city').val(),
                pincode:$('#pincode').val(),
                latitude:myGeoLocation.lat,
                longitude:myGeoLocation.long,
            };

            //console.log("OBJ: ",userDetails);
            if(userDetails.pincode.length > 6 || userDetails.pincode.length < 5){
                swal("Zipcode should be either 5 or 6 digit")
                return false;
            }

            ajaxfunctioncallwithdata("POST","./userProfile.aspx/updateUserDetails",{userDetails:userDetails},true)
            .then(function(resp){
                //console.log(resp.d);
                if(resp.d){                    
                    swal("Success!", 'Profile updated successfully.', 'success');
                    getUserDetails('GET FROM SESSION');
                }
                else{
                    swal("Oops!", 'Something went wrong.', 'danger');
                }
            });
        });


        function getUserDetails(userId) {
            ajaxfunctioncallwithdata("POST", "./userProfile.aspx/getUserDetails", { userId: userId }, true)
            .then(function (resp) {
                //console.log(resp.d);
                var userDetails = resp.d;
                $('#userName').val(userDetails.userName);

                $('#middleName').val(userDetails.middleName);
                $('#lastName').val(userDetails.lastName);

                $('#entityName').val(userDetails.entityName);
                //$('#phoneNo').val(userDetails.phoneNumber);
                $('#usrRole').text(userDetails.roleName);
                $('#designation').val(userDetails.designation);           
                $('#email').val(userDetails.emailId);
                $('#phoneNo').intlTelInput("setNumber",userDetails.phoneNumber);  

                var countryIso = cc.filter(function(item){                
                    if(item.code == userDetails.countryCode)
                        return item.iso;
                });                
                $('#phoneNo').intlTelInput("setCountry",countryIso[0].iso.toLowerCase());
                
                populateRegionList({ country: userDetails.countryId, state:userDetails.stateId, city:userDetails.cityName });//userDetails.cityId

                $('#pincode').val(userDetails.pincode);
                //$('#address').val(userDetails.address);
                $('#streetAddress1').val(userDetails.streetAddress1);
                $('#streetAddress2').val(userDetails.streetAddress2);

                
                var userPos = new google.maps.LatLng(userDetails.latitude, userDetails.longitude)
                bounds.extend(userPos);
                marker.setPosition(userPos);                
                //map.fitBounds(bounds);
                map.setCenter(bounds.getCenter())
                map.panToBounds(bounds);
            });
        }

        function getCountryList() {
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

        function getStateList(country) {
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

        /*function getCityList(state) {
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

        async function populateRegionList(regionInfo){
            $('#country').val(regionInfo.country).trigger('change');
            await getStateList(regionInfo.country);
            $('#state').val(regionInfo.state).trigger('change');
            //await getCityList(regionInfo.state);
            //$('#city').val(regionInfo.city).trigger('change');
            $('#city').val(regionInfo.city);
        }

        $('#country').on('change',function(){
            getStateList($(this).val());

            var countryIso = cc.filter(function(item){                
                if(item.country.trim().toLowerCase() == $('#country').select2('data')[0].text.trim().toLowerCase())
                    return item.iso;
            });
            $('#phoneNo').intlTelInput("setCountry",countryIso[0].iso.toLowerCase());

        });
        //$('#state').on('change',function(){getCityList($(this).val())});


        



    </script>
</asp:Content>
