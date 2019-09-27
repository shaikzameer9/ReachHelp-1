<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="ReachHelpWF.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #modalOfferThumbnails {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }

            #modalOfferThumbnails .thumbnail {
                flex-basis: 33%;
                margin: auto 0;
                padding: 0;
            }

        #previewImg {
            width: 100%;
        }


        .front-image {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            height: 509px;
            background-image: url(img/bg1.png);
            object-fit: cover;
            background-repeat:no-repeat;
            /*background-size:100%;*/
        }

            .front-image button.actionhelp {
                height: 50%;
                font-size: 1.4rem;
                display: block;
                    margin: 10% auto;
            }

                .front-image button.actionhelp:focus {
                    outline: none;
                    color: #fff;
                }

            .front-image img {
                position: absolute;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .front-image .img-cont-6 {
                flex: 1;
                flex-basis: 50%;
                z-index: 1;
            }

                /*.front-image .img-cont-6 button {
                    width: 150px;
                    display: block;
                    margin: 10% auto;
                }*/

            .front-image .img-cont-12 {
                flex: 1;
                flex-basis: 100%;
                z-index: 1;
                /*border: 1px solid #7e7e7e;                               
                border-radius: 4px;*/
            }

                .front-image .img-cont-12 h4 {
                    position: relative;
                    color: #fff;
                    /*margin:0 20%;*/
                    text-align: center;
                    line-height: 2rem;
                    word-spacing: 0.5rem;
                    /*top: 15%;*/
                    font-size: 1rem;
                    margin: 0 40px;
                }

                .front-image .img-cont-12 button {
                    width: 150px;
                    display: block;
                    margin: 40% auto;
                }

        /* 
  ##Device = Desktops
  ##Screen = 1281px to higher resolution desktops
*/

        @media (min-width: 1281px) {
            #modalOfferThumbnails {
                /*height: 430px;*/
                overflow-y: auto;
            }

                #modalOfferThumbnails .thumbnail {
                    flex-basis: 100%;
                    border-radius: 4px;
                    padding: 0px;
                    box-shadow: 1px 2px 10px rgba(0,0,0,0.5);
                    margin: 10px 0;
                }

                    #modalOfferThumbnails .thumbnail:hover {
                        cursor: pointer;
                    }

                    #modalOfferThumbnails .thumbnail img {
                        width: 100%;
                        object-fit: cover;
                        height: 70px;
                    }

            #previewImg {
                width: 100%;
            }

            .img-magnifier-container {
                position: relative;
            }

            .img-magnifier-glass {
                position: absolute;
                /*border: 3px solid #000;*/
                border-radius: 50%;
                cursor: none;
                /*Set the size of the magnifier glass:*/
                width: 100px;
                height: 100px;
            }

            .desc-wrapper {
                white-space: nowrap;
                margin: 10px 0;
            }

                .desc-wrapper label {
                    font-weight: inherit;
                }

                .desc-wrapper > div, .desc-wrapper > label {
                    display: inline-block;
                }

            .front-image {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-around;

                background-image: url(img/bg1.png);
            object-fit: cover;
            background-repeat:no-repeat;
            background-size:100%;
            }

            .front-image button.actionhelp {
                height: 50%;
                width: 60%;
                font-size: 1.4rem;
                display: block;
                    margin: 10% auto;
            }

                .front-image img {
                    position: absolute;
                    width: 100%;
                }

                .front-image .img-cont-6 {
                    flex: 1;
                    flex-basis: 50%;
                    z-index: 1;
                }

                    /*.front-image .img-cont-6 button {
                        width: 150px;
                        display: block;
                        margin: 10% auto;
                    }*/

                .front-image .img-cont-12 {
                    flex: 1;
                    flex-basis: 100%;
                    z-index: 1;
                    /*border: 1px solid #7e7e7e;                               
                border-radius: 4px;*/
                }

                    .front-image .img-cont-12 h4 {
                        position: relative;
                        color: #fff;
                        /*margin:0 20%;*/
                        text-align: center;
                        line-height: 2rem;
                        word-spacing: 0.5rem;
                        font-size: 1.5rem;
                        top: 15%;
                    }

                    .front-image .img-cont-12 button {
                        width: 150px;
                        display: block;
                        margin: 10% auto;
                    }
        }

        /* 
  ##Device = Laptops, Desktops
  ##Screen = B/w 1025px to 1280px
*/

        @media (min-width: 1025px) and (max-width: 1280px) {
            #modalOfferThumbnails {
                /*height: 430px;*/
                overflow-y: auto;
            }

                #modalOfferThumbnails .thumbnail {
                    flex-basis: 100%;
                    border-radius: 4px;
                    padding: 0px;
                    box-shadow: 1px 2px 10px rgba(0,0,0,0.5);
                    margin: 10px 0;
                }

                    #modalOfferThumbnails .thumbnail:hover {
                        cursor: pointer;
                    }

                    #modalOfferThumbnails .thumbnail img {
                        width: 100%;
                        object-fit: cover;
                        height: 70px;
                    }

            #previewImg {
                width: 100%;
            }

            .img-magnifier-container {
                position: relative;
            }

            .img-magnifier-glass {
                position: absolute;
                /*border: 3px solid #000;*/
                border-radius: 50%;
                cursor: none;
                /*Set the size of the magnifier glass:*/
                width: 100px;
                height: 100px;
            }

            .desc-wrapper {
                white-space: nowrap;
                margin: 10px 0;
            }

                .desc-wrapper label {
                    font-weight: inherit;
                }

                .desc-wrapper > div, .desc-wrapper > label {
                    display: inline-block;
                }



            .front-image {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-around;

                background-image: url(img/bg1.png);
            object-fit: cover;
            background-repeat:no-repeat;
            background-size:100%;
            }

            .front-image button.actionhelp {
                height: 50%;
                width: 60%;
                font-size: 1.4rem;
                display: block;
                    margin: 10% auto;
            }

                .front-image img {
                    position: absolute;
                    width: 100%;
                }

                .front-image .img-cont-6 {
                    flex: 1;
                    flex-basis: 50%;
                    z-index: 1;
                }

                    /*.front-image .img-cont-6 button {
                        width: 150px;
                        display: block;
                        margin: 10% auto;
                    }*/

                .front-image .img-cont-12 {
                    flex: 1;
                    flex-basis: 100%;
                    z-index: 1;
                    /*border: 1px solid #7e7e7e;                               
                border-radius: 4px;*/
                }

                    .front-image .img-cont-12 h4 {
                        position: relative;
                        color: #fff;
                        /*margin:0 20%;*/
                        text-align: center;
                        line-height: 2rem;
                        word-spacing: 0.5rem;
                        font-size: 1.5rem;
                        top: 15%;
                    }

                    .front-image .img-cont-12 button {
                        width: 150px;
                        display: block;
                        margin: 10% auto;
                    }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- navigation -->
    <div class="navigation-agileits">
        <div class="container">
            <nav class="navbar navbar-default">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header nav_2">
                    <button type="button" class="navbar-toggle collapsed navbar-toggle1" data-toggle="collapse" data-target="#bs-megadropdown-tabs">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="index.aspx" class="act">Home</a></li>
                        <!-- Mega Menu -->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Category<b class="caret"></b></a>
                            <%--<ul class="dropdown-menu multi-column columns-3">
                                    <div class="row">
                                        <div class="multi-gd-img">
                                            <ul class="multi-column-dropdown" id="menuCategories">
                                                <h6>All Categories</h6>
                                                <li><a href="#">Dals & Pulses</a></li>
                                                <li><a href="#">Almonds</a></li>
                                            </ul>
                                        </div>

                                    </div>
                                </ul>--%>
                            <ul class="dropdown-menu multi-column columns-3">

                                <div class="row">
                                    <div class="multi-gd-img">
                                        <ul class="multi-column-dropdown" id="menuCategories">
                                            <h6>All Categories</h6>
                                            <li><a tabindex="-1" href="#">HTML</a></li>
                                            <li><a tabindex="-1" href="#">CSS</a></li>
                                            <li class="dropdown-submenu">
                                                <a class="test" tabindex="-1" href="#">New dropdown <span class="caret"></span></a>
                                                <ul class="dropdown-menu">
                                                    <li><a tabindex="-1" href="#">2nd level dropdown</a></li>
                                                    <li><a tabindex="-1" href="#">2nd level dropdown</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </ul>
                        </li>
                        <%--<li><a href="#">Contact</a></li>--%>
                    </ul>

                </div>
            </nav>
        </div>
    </div>

    <!-- //navigation -->


    <div class="front-image">
        <div class="img-cont-6">
            <%--<img src="img/bg1.png" alt="" />      --%>
            <button type="button" class="btn btn-md btn-outline light actionhelp"
                id="btnRequestHelp">
                Get Help</button>
        </div>
        <div class="img-cont-6">
            <%--<img src="img/bg2.png" alt="" />--%>
            <button type="button" class="btn btn-md btn-outline light actionhelp"
                id="btnOfferHelp">
                Give Help</button>
        </div>
        <div class="img-cont-12">
            <%--<img src="img/bg3.png" alt="" />--%>
            <h4><span style="color: #fe9126">ReacHelp</span> let’s you provide or receive help in the form of goods and services for free. If you find it useful, please spread the word. We would be grateful if you would consider making a donation (no amount is too small) towards maintaining and expanding ReacHelp.</h4>
            <%--<button type="button" class="btn btn-lg btn-rounded btn-green btn-outline light animated tada" style="width: 150px;" id="btnDonate">Donate</button>--%>
        </div>
        <%--<img src="img/bg1.png" alt="" />--%>
    </div>

    <!-- main-slider -->
    <%--<ul id="demo1">
			<li>
				<img src="img/bg1.png" alt="" />
				<!--Slider Description example-->
				<div class="slide-desc">
					<h3>In need of any help? Reach out for your need here.</h3>
                    <button type="button" class="btn btn-md btn-rounded btn-outline" style="width:150px;" id="btnRequestHelp">Need Help</button>
				</div>
			</li>
			<li>
				<img src="img/bg2.png" alt="" />
				  <div class="slide-desc">
					<h3>Provide relief to the people in need.</h3>
                    <button type="button" class="btn btn-md btn-rounded btn-outline" style="width:150px;" id="btnOfferHelp">Offer Help</button>
				</div>
			</li>

            <li>
				<img src="img/bg3.png" alt="" />
				  <div class="slide-desc">
					<h4>We would be grateful if you would consider making a donation towards maintaining and expanding ReacHelp.</h4>
                    <button type="button" class="btn btn-md btn-rounded btn-green btn-outline" style="width:150px;" id="btnDonate">Donate</button>
				</div>
			</li>
						
		</ul>--%>
    <!-- //main-slider -->

    <div class="newproducts-w3agile">
        <div class="container">
            <h3 style="font-size: x-large;">New offers</h3>
            <h2 style="font-size: x-large; margin-left: 15px;">Category: <small id="selectedCategoryLabel" style="font-size: smaller;">All</small></h2>
            <div class="pull-right">
                <input type="text" id="searchByLocation" class="form-control" style="border-radius: 50px;" placeholder="Search by Item/location..." />
            </div>
            <div style="margin-top:35px;">
                <h5>Search by location:</h5>
                <div id='map' style='height: 250px;'></div>
                <h6>Note:</h6>
                <ul style="display:inline-flex">
                    <li style="margin:0 15px"><small><i>Drag the marker to your desired location.</i></small></li>
                    <li style="margin:0 15px"><small><i>Use Ctrl + mouse wheel to zoom into the map area.</i></small></li>
                    <li style="margin:0 15px"><small><i>Results displayed are within 5Km from the marker location.</i></small></li>
                </ul>
                                                                                        
            </div>
            <div class="agile_top_brands_grids" id="newOffers">
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <!-- //new -->


    <!-- Modal -->
    <div class="modal fade" id="offerDescriptionModal" tabindex="-1" role="dialog" aria-labelledby="offerDescriptionModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Description</h4>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-2 col-xs-12">
                            <div id="modalOfferThumbnails">
                                <%--<div class="thumbnail">
                                    <img src="./Uploads/rice.jpg" />
                                </div>
                                <div class="thumbnail">
                                    <img src="./Uploads/rice.jpg" />
                                </div>
                                <div class="thumbnail">
                                    <img src="./Uploads/rice.jpg" />
                                </div>
                                <div class="thumbnail">
                                    <img src="./Uploads/rice.jpg" />
                                </div>--%>
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-12">
                            <%--<a href="#" disabled id="previewImgAnchor" title="" data-spzoom>
                                        <img src="" id="previewImg" disabled />
                                    </a>--%>
                            <div class="img-magnifier-container">
                                <img id="previewImg" src="" />
                            </div>
                        </div>
                        <div class="col-md-4 col-xs-12">

                            <div class="desc-wrapper">
                                <h4>Offer Details:</h4>
                            </div>
                            <div class="desc-wrapper">
                                <label style="color: #fe9126;">Item: </label>
                                <span id="modalOfferName">--</span>
                            </div>
                            <div class="">
                                <div style="font-size: 0.9rem;">
                                    <label style="font-weight: inherit; color: #fe9126;">Offered Qty:</label>
                                    <div style="display: inline-block"><span id="modalOfferQty">--</span> <span id="modalOfferUnit">--</span></div>
                                </div>
                                <div style="font-size: 0.9rem;">
                                    <label style="font-weight: inherit; color: #fe9126;">Posted On:</label>
                                    <div style="display: inline-block"><span id="modalOfferDate">--</span></div>
                                </div>
                            </div>
                            <div style="margin: 10px 0">
                                <h4>Description:</h4>
                                <p id="modalOfferDesc">--</p>
                            </div>

                            <% if (HttpContext.Current.Session["UserName"] != null)
                               {%>
                            <div>
                                <div class="form-group">
                                    <label for="modalRequiredQty">Required Qty</label>
                                    <input type="number" min="1" value="1" class="form-control" id="modalRequiredQty" />
                                </div>
                                <div class="form-group">
                                    <label for="modalExpectedDate">Expected Date</label>
                                    <input type="date" class="form-control" id="modalExpectedDate" />
                                </div>
                                <div class="form-group">
                                    <label for="modalAddress">Address</label>
                                    <textarea class="form-control" id="modalAddress"></textarea>
                                </div>
                            </div>
                            <%} %>



                            <%--<div><span>Offer: </span><strong><span id="modalOfferName">Rice</span></strong></div>
                                    <div style="display:flex; flex-direction:row;font-size: small;">
                                        <div style="flex-grow:1;flex-basis:0;">
                                            <span>Quantity: </span><strong><span id="modalOfferQty">1</span> <span id="modalOfferUnit">Kg</span></strong>
                                        </div>
                                        <div style="flex-grow:1;flex-basis:0;">
                                            <span>Date:</span> <strong><span id="modalOfferDate">2018/02/01</span></strong>
                                        </div>
                                    </div>
                                    <div style="padding: 25px 0;text-align: justify;">
                                        <h5>Description: </h5>
                                        <p id="modalOfferDesc" style="padding: 15px 0;"></p>
                                    </div>--%>
                        </div>

                    </div>

                    <%--<div class="row">
                        <div class="col-md-6">
                            <p><b>Offer: </b><span id="modalOfferName">Rice</span> <span id="modalOfferQty">1</span> <span id="modalOfferUnit">Kg</span></p>
                        </div>
                        <div class="col-md-6">
                            <p class="pull-right"><b>Date:</b> <span id="modalOfferDate">2018/02/01</span></p>
                        </div>
                    </div>
                    <div class="row" id="modalOfferImages">
                        <div class="col-md-2">
                            <div style="width: 150px; border-radius: 4px; padding: 0px; box-shadow: 1px 2px 10px rgba(0,0,0,0.5);">
                                <img src="./Uploads/rice.jpg" style="width: 100%; object-fit: cover;" />
                            </div>

                        </div>
                    </div>--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <% if (HttpContext.Current.Session["UserName"] == null)
                       {%>
                    <button type="button" class="btn btn-primary" id="modalLoginnRequest">Login & Request</button>
                    <%}
                       else
                       { %>
                    <button type="button" class="btn btn-primary" id="modalRequest">Request</button>
                    <%} %>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script>
        var typingTimer = null;
        var geoCord = { lat: 0.0, lng: 0.0 };
        getActiveOffers('', geoCord.lat, geoCord.lng);
        var searchVal = "";

        $('#searchByLocation').on('keyup', function () {
            clearTimeout(typingTimer);
            searchVal = $(this).val();
            if (searchVal) {
                typingTimer = setTimeout(function () {
                    getActiveOffers(searchVal, geoCord.lat, geoCord.lng);
                }, 5000);
            }
            else {
                getActiveOffers('', geoCord.lat, geoCord.lng);
            }
        })


        var map, myGeoLocation = { lat: 0.0, long: 0.0 };
        function initMap() {
            var myLatLng = { lat: 38.23894, lng: -100.98725 };
            map = new google.maps.Map(document.getElementById('map'), {
                center: myLatLng,
                zoom: 4
            });

            var marker = new google.maps.Marker({
                position: myLatLng,
                map: map,
                draggable: true,
                //title: 'Me'
            });

            // Add circle overlay and bind to marker
            var circle = new google.maps.Circle({
                map: map,
                radius: 5000,    // in metres
                fillColor: '#AA0000',
                strokeWeight: 0
            });

            circle.bindTo('center', marker, 'position');

            google.maps.event.addListener(marker, 'dragend', function (event) {
                myGeoLocation.lat = event.latLng.lat();
                myGeoLocation.long = event.latLng.lng();

                console.log(myGeoLocation);
                getActiveOffers(searchVal, myGeoLocation.lat, myGeoLocation.long);

            });

            //google.maps.event.addListener(map, 'zoom_changed', function () {
            //    for (var i = 0; i < circle.length; i++) {
            //        var p = Math.pow(2, (21 - map.getZoom()));
            //        circle[i].setRadius(p * 1128.497220 * 0.0027);
            //    }
            //});

        }



        initMap();


        function getActiveOffers(searchVal, lat, lng) {
            $.appPost("./index.aspx/getActiveOffers", { categoryId: 0, startValue: 0, noOfRows: 10, searchVal: searchVal, userLat: lat, userLng:lng }).then(function (resp) {
                //console.log("Index Get Active Offers: ", resp);
                var offers = resp.d;
                $('#newOffers').empty();
                if (offers.length > 0) {
                    offers.forEach(function (ele) {
                        createProductCard(ele);
                    });

                    if (getUrlParam(window.location.href, 'oid') != null) {
                        preLoadRequest();
                    }
                }
                else {
                    $('<h3>').text("-- No Offers Available --").css({ color: '#9a9a9a', 'text-transform': 'none' }).appendTo('#newOffers');
                }

            })
        }

        $('#offerDescriptionModal').on('show.bs.modal', function (e) {

            var offer = e.relatedTarget;
            //console.log("MODAL OFFER DETAILS : ", offer);
            $('#modalOfferName').text(offer.offerSubCategoryName);
            if (offer.offerQuantity != "-1") {
                $('#modalOfferQty').text(offer.offerQuantity);
                $('#modalOfferUnit').text(offer.offerUnit);
            }
            else {
                $('#modalOfferQty').text("NA");
                $('#modalOfferUnit').text("");
            }
            $('#modalOfferDate').text(offer.offerPostedDate.split(' ')[0]);
            $('#modalOfferDesc').text(offer.description == "" || offer.description.length < 2 ? "-- No Description Provided --" : offer.description);

            var now = new Date(),
                minDate = now.toISOString().substring(0, 10);

            $('#modalExpectedDate').prop('min', minDate);

            $('#modalLoginnRequest').on('click', function () {
                $.appPost('./index.aspx/makeRequest', { offerId: offer.offerId, offerDetails: offer }).then(function (resp) {
                    if (resp.d == "Expired") {
                        $('#offerDescriptionModal').modal('hide');
                        $("#lmodalid").click();
                    }
                })
            })

            $('#modalRequest').on('click', function () {
                alert("REQUESTED : ", sessionStorage.getItem('userId'));
                var offerDetails = { offerId: offer.offerId };
                var requestDetails = {
                    requestCategoryId: offer.offerCategoryId,
                    requestSubCategoryId: offer.offerSubCategoryId,
                    requestedById: sessionStorage.getItem('userId'),
                    requestQuantity: $('#modalRequiredQty').val(),
                    requestExpectedDate: $('#modalExpectedDate').val(),
                    requestUnit: offer.unitId,
                    requestDeliveryAddress: $('#modalAddress').val()
                };
                $.appPost('./main/myRequests.aspx/RequestAnOffer', { offerDetails: offerDetails, requestDetails: requestDetails }).then(function (resp) {
                    //console.log('RESP: ', resp.d);
                    if (resp.d == true) {
                        $('#offerDescriptionModal').modal('hide');
                        swal("Success", "Request sent successfully.", "success");
                    }
                });
                //RequestAnOffer(OffersModel offerDetails,RequestsModel requestDetails)

            });

            $('#modalOfferThumbnails').empty();
            if (offer.imagePath != null) {
                var offerImages = [];
                if (offer.imagePath.indexOf(',') > -1) {
                    offerImage = offer.imagePath.split(',');
                }
                else {
                    offerImages.push(offer.imagePath);
                }

                offerImages.forEach(function (ele) {
                    //var cont = $('<div>').addClass('col-md-2').appendTo('#modalOfferImages');
                    var innerCont = $('<div>').addClass('thumbnail').appendTo('#modalOfferThumbnails');
                    $('<img>').attr({ src: "./Uploads/" + ele }).on('click', viewImage).appendTo(innerCont);
                    /*
                    <div class="col-md-2">
                            <div style="width: 150px;border-radius: 4px;padding: 0px;box-shadow: 1px 2px 10px rgba(0,0,0,0.5);">
                                <img  style=""/>
                            </div>

                        </div>
                    */
                })
            }
            else {
                //var cont = $('<div>').addClass('col-md-2').appendTo('#modalOfferImages');
                var innerCont = $('<div>').addClass('thumbnail').appendTo('#modalOfferThumbnails');
                $('<img>').attr({ src: "./Uploads/" + offer.offerSubCategoryName.toLowerCase() + ".jpg" }).on('mouseover', viewImage)/*.on('mouseout', destroyZoom)*/.appendTo(innerCont);
            }
            $('#previewImg').attr('src', $('#modalOfferThumbnails').find('.thumbnail:eq(0) img').attr('src'));
            magnify = new Magnify("previewImg", 3);
        });

        function createProductCard(ele) {
            var cont1 = $('<div>').attr({ 'data-offerid': ele.offerId }).addClass('col-md-3 top_brand_left-1 offerCard').appendTo('#newOffers');
            var cont2 = $('<div>').addClass('hover14 column').appendTo(cont1);
            var cont3 = $('<div>').addClass('agile_top_brand_left_grid').appendTo(cont2);
            //var cont4 = $('<div>').addClass('agile_top_brand_left_grid_pos').appendTo(cont3);
            //$('<img>').attr({ src: 'lib/w3layout/images/offer.png', alt: "" }).addClass('img-responsive').appendTo(cont4);
            var cont5 = $('<div>').addClass('agile_top_brand_left_grid1').appendTo(cont3);
            var figure = $('<div>').appendTo(cont5);
            var cont6 = $('<div>').addClass('snipcart-item block').appendTo(figure);
            var cont7 = $('<div>').addClass('snipcart-thumb').appendTo(cont6);
            var prodAnchor = $('<a>').attr({ href: '#' }).appendTo(cont7);
            var mainImg = $('<img>').attr({ title: "", alt: "", src: "https://via.placeholder.com/500x400.png?text=No+Image+Available" }).css({ height: '150px', width: '100%', 'object-fit': 'cover' }).appendTo(prodAnchor);
            //console.log("OFFER IMAGE FOR " + ele.offerSubCategoryName + ": " + ele.imagePath);
            if (ele.imagePath == null) {
                //console.log("./Uploads/" + ele.offerSubCategoryName.toLowerCase() + ".jpg");
                //mainImg.attr({ src: "./Uploads/" + ele.offerSubCategoryName.toLowerCase() + ".jpg" });
            }
            else {
                var imgPathStr = ele.imagePath;
                var images = [];
                if (imgPathStr.indexOf(',') > -1) {
                    images = imgPathStr.split(',');
                }
                else {
                    images[0] = imgPathStr;
                }
                //console.log(images[0]);

                var imgUrl = './Uploads/' + images[0];
                checkImage(imgUrl, function () { $(mainImg).attr('src', imgUrl); }, function () { console.error('Image Not Found!') });

            }
            $('<p>').text(ele.offerSubCategoryName).appendTo(cont7);
            /*var ratingDiv = $('<div>').addClass('stars').appendTo(cont7);
            for (var r = 0; r < 5; r++) {
                var start = $('<i>').addClass('fa fa-star').attr({ 'aria-hidden': "true" }).appendTo(ratingDiv);
                if (r == 4)
                    start.addClass('blue-star');
                else
                    start.addClass('gray-star');
            }*/

            if (ele.offerQuantity != "-1" && ele.offerUnit != "None")
                $('<h4>').text(ele.offerQuantity + " " + ele.offerUnit).appendTo(cont7);
            else
                $('<h4>').text("--").appendTo(cont7);//"Qty: Not Specified"
            var cont8 = $('<div>').addClass('snipcart-details top_brand_home_details').appendTo(cont6);
            //$('<button>').attr({ type: "button" }).addClass('btn btn-primary btn-md').text('Request').appendTo(cont8);
            $('<input>').attr({ type: "button", name: "ViewDetails", value: 'View Details', 'data-offerid': ele.offerId, 'data-offer': btoa(JSON.stringify(ele)) }).addClass('button').text('View Details').on('click', function () {
                var offerId = $(this).attr('data-offerid');
                var offerDetails = JSON.parse(atob($(this).attr('data-offer')));
                $('#offerDescriptionModal').modal('show', offerDetails);
            }).appendTo(cont8);
        }

        function viewImage() {
            var imgSrc = $(this).attr('src');
            $('#offerDescriptionModal').find('#previewImgAnchor').attr('href', imgSrc);
            $('#offerDescriptionModal').find('#previewImg').attr('src', imgSrc);
            $('.img-magnifier-glass').remove();
            magnify = new Magnify("previewImg", 3);
        }

        function Magnify(imgID, zoom) {
            var img, glass = null, w, h, bw;

            var init = (function () {
                img = document.getElementById(imgID);

                /* Create magnifier glass: */
                glass = document.createElement("DIV");
                glass.setAttribute("class", "img-magnifier-glass");

                /* Insert magnifier glass: */
                img.parentElement.insertBefore(glass, img);

                /* Set background properties for the magnifier glass: */
                glass.style.backgroundImage = "url('" + img.src + "')";
                glass.style.backgroundRepeat = "no-repeat";
                glass.style.backgroundSize = (img.width * zoom) + "px " + (img.height * zoom) + "px";
                bw = 3;
                w = glass.offsetWidth / 2;
                h = glass.offsetHeight / 2;

                /* Execute a function when someone moves the magnifier glass over the image: */
                glass.addEventListener("mousemove", moveMagnifier);
                img.addEventListener("mousemove", moveMagnifier);

                /*and also for touch screens:*/
                glass.addEventListener("touchmove", moveMagnifier);
                img.addEventListener("touchmove", moveMagnifier);
            })();

            function moveMagnifier(e) {
                var pos, x, y;
                /* Prevent any other actions that may occur when moving over the image */
                e.preventDefault();
                /* Get the cursor's x and y positions: */
                glass.style.display = "block";
                pos = getCursorPos(e);
                x = pos.x;
                y = pos.y;
                /* Prevent the magnifier glass from being positioned outside the image: */
                if (x > img.width - (w / zoom)) {
                    glass.style.display = "none";
                    x = img.width - (w / zoom);
                }
                if (x < w / zoom) {
                    glass.style.display = "none";
                    x = w / zoom;
                }
                if (y > img.height - (h / zoom)) {
                    glass.style.display = "none";
                    y = img.height - (h / zoom);
                }
                if (y < h / zoom) {
                    glass.style.display = "none";
                    y = h / zoom;
                }
                /* Set the position of the magnifier glass: */
                glass.style.left = (x - w) + "px";
                glass.style.top = (y - h) + "px";
                /* Display what the magnifier glass "sees": */
                glass.style.backgroundPosition = "-" + ((x * zoom) - w + bw) + "px -" + ((y * zoom) - h + bw) + "px";
            }

            function getCursorPos(e) {
                var a, x = 0, y = 0;
                e = e || window.event;
                /* Get the x and y positions of the image: */
                a = img.getBoundingClientRect();
                /* Calculate the cursor's x and y coordinates, relative to the image: */
                x = e.pageX - a.left;
                y = e.pageY - a.top;
                /* Consider any page scrolling: */
                x = x - window.pageXOffset;
                y = y - window.pageYOffset;
                return { x: x, y: y };
            }
        }

        //ajaxfunctioncallwithdata("POST", "./index.aspx/MakeRequest", { myRequest: requestObj }, true)
        /*
        var requestObj = {
            requestCategoryId: $('#category').val(),
            requestSubCategoryId: $('#subCategory').val(),
            requestedById: sessionStorage.getItem('userId'),  // First set user id during login
            requestQuantity: ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes" ? $('#qty').val() : '-1'),//'1'
            requestUnit: ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes" ? $('#unit').val() : ''), //''
            requestExpectedDate: $('#expectedDate').val(),//moment().format("YYYY/MM/DD"),
            requestDeliveryAddress: $('#deliveryAddress').val()
        };
        */

        function preLoadRequest() {
            var currentUrl = window.location.href;
            var offerId = getUrlParam(currentUrl, 'oid'),
                categoryId = getUrlParam(currentUrl, 'c'),
                subCategoryId = getUrlParam(currentUrl, 'sc'),
                qty = getUrlParam(currentUrl, 'sc'),
                unit = getUrlParam(currentUrl, 'unit');

            $('#newOffers').find('.offerCard[data-offerid="' + offerId + '"] input').trigger('click');

        }

    </script>
</asp:Content>
