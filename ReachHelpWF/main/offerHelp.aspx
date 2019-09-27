<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="offerHelp.aspx.cs" Inherits="ReachHelpWF.main.offerHelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btnUpload {
            text-align: center;
            margin: 24px 0;
            padding: 7px 4px 2px 4px;
            border: 1px solid #bdbcbc;
            width: 100%;
        }

            .btnUpload:hover {
                box-shadow: 0 2px 4px rgba(0,0,0,0.4);
            }

        .image-placeholder {
            /*min-height: 100px;*/
            border-radius: 4px;
            border: 1px solid #2a3f5485;
        }

            /*.image-placeholder:hover {
                background-color: #2a3f5485;
            }*/

            .image-placeholder > i {
                display: block;
                text-align: center;
                /*line-height: 100px;
                font-size: 5rem;*/
                color: #2a3f5485;
                transition: all 200ms ease-in;
                transform: scale(1);
            }

            .image-placeholder:hover > i {
                /*color: #fff;*/
                transition: all 200ms ease-in;
                transform: scale(1.5);
                line-height: 30px;
                font-size: 2rem;
                color: crimson;
            }

        #imgPreview {
            background-color: rgba(0, 0, 0, 0.75);
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 999;
        }

            #imgPreview div {
                width: 50vw;
                height: 52vh;
                display: block;
                position: fixed;
                top: 20vh;
                left: 25vw;
                padding: 10px;
                background-color: #fff;
            }

            #imgPreview img {
                width: 100%;
                cursor: pointer;
            }

            #imgPreview i {
                /* padding: 10px; */
                color: crimson;
                font-size: x-large;
                position: absolute;
                top: -25px;
                right: -20px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">Post Offer</h3>
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
                            <h2><small class="trn">Post your offer</small></h2>
                            <a href="myOffers" class="btn btn-sm btn-round btn-primary pull-right trn" style="margin: 5px 0 0 0;">Offers</a>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="category" class="trn">Category</label>
                                    <select id="category" class="form-control">
                                        <option value="">Choose..</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="subCategory" class="trn">Sub-Category</label>
                                    <select id="subCategory" class="form-control">
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
                                        <select id="unit" class="form-control">
                                            <option value="">Choose..</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-xs-12 form-group">
                                    <label for="description">Description</label>
                                    <textarea id="description" class="form-control"></textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-xs-6 form-group">
                                    <label for="deliveryMode" class="trn">Delivery Mode</label>
                                    <select id="deliveryMode" class="form-control">
                                        <option value="">Choose..</option>
                                        <option value="collect" selected>Collect</option>
                                        <option value="delivery">Delivery</option>
                                    </select>
                                </div>

                                <div class="col-md-3 col-xs-6 form-group" id="deliveryAddrCont">
                                    <label for="deliveryAddress" class="trn">Address</label>
                                    <i class="fa fa-clone pull-right copy-addr" style="position: relative; top: 5px; color: #03A9F4;" data-toggle="tooltip" data-placement="top" title="Copy Address/ Look on Map"></i>
                                    <textarea id="deliveryAddress" class="form-control" rows="3"></textarea>
                                </div>

                                <div class="col-md-3 col-xs-6 form-group">
                                    <div class="btnUpload">
                                        <label for="uploadImages">Upload Images <small>(Min 1 - Max 4)</small></label>

                                        <input type="file" id="uploadImages" class="form-control hidden" onchange="addImages(this)" multiple />
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="subCategoryImageCont">
                                <%--<div class="col-md-2">
                                    <div class="image-placeholder">
                                        <i class="fa fa-plus"></i>
                                    </div>
                                </div>--%>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <button type="button" id="btnCreateOffer" class="btn btn-md btn-primary pull-right trn">Submit Offer</button>
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
        var files = null;
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));

            $('.select2').select2({ width: '100%' });

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

                $('#measurableCont').show();

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
                        $('<option>').attr({ value: '' }).appendTo('#unit');
                        for (var unt in unitList) {
                            $('<option>').attr({ value: unitList[unt].unitId }).text(unitList[unt].unitName).appendTo('#unit');
                        }
                    });
        }

        $('#deliveryMode').on('change', function () {
            if ($(this).val() == "collect") {
                $('#deliveryAddrCont').show();
            }
            else {
                $('#deliveryAddrCont').hide();
            }
        });

        $('#btnCreateOffer').on('click', function () {
            var createOfferObj = {
                offerCategoryId: $('#category').val(),
                offerSubCategoryId: $('#subCategory').val(),
                offeredById: sessionStorage.getItem('userId'),
                offerQuantity: ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes" ? $('#qty').val() : '-1'),//'1'
                offerUnit: ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes" ? $('#unit').val() : ''),//''
                offerDeliveryMode: $('#deliveryMode').val(),
                offerDeliveryAddress: $('#deliveryAddress').val(),
                description: $('#description').val(),
                imagePath:null
            };

            if (createOfferObj.offerCategoryId == "") {
                swal("Notice!", 'Please select a Category!', 'warning');
                //alert("Please select a Category!");
                return false;
            }
            if (createOfferObj.offerSubCategoryId == "") {
                swal("Notice!", 'Please select a Sub-Category!', 'warning');
                //alert("Please select a Sub-Category!");
                return false;
            }
            if ($('#subCategory').find('option:selected').attr("data-measurable") == "Yes") {
                if (createOfferObj.offerQuantity == "") {
                    swal("Notice!", 'Please enter a Quantity!', 'warning');
                    //alert("Please enter a Quantity!");
                    return false;
                }
                if (createOfferObj.offerUnit == "") {
                    swal("Notice!", 'Please select a Unit!', 'warning');
                    //alert("Please select a Unit!");
                    return false;
                }
            }
            if (createOfferObj.offerDeliveryMode == "collect") {
                if (createOfferObj.offerDeliveryAddress == "") {
                    swal("Notice!", 'Please enter an Address!', 'warning');
                    //alert("Please enter an Address!");
                    return false;
                }
            }

            console.log("FILES: ",files);
            if (files == null) {
                swal("Notice!", 'Please upload at least one image of your item!', 'warning');
                //alert("Please upload at least one image of your item!"); return false;
            }

            console.log(createOfferObj);

            if (files != null) {
                uploadImages(files).then(function (imgResp) {
                    var resp = JSON.parse(imgResp);
                    console.log("RESP: ", resp);
                    if (resp.length == files.length) {

                        createOfferObj["imagePath"] = resp;

                        ajaxfunctioncallwithdata("POST", "./index.aspx/CreateOffer", { myOffer: createOfferObj }, true)
                        .then(function (resp) {
                            //console.log(resp.d);
                            if (resp.d) {
                                swal("Success!", 'Offer Posted Successfully', 'success');
                                $('#category,#deliveryMode').val('').trigger('change');
                                $('#subCategory,#unit').empty();
                                $('#subCategory').empty();
                                $('#deliveryAddress').val('');
                                $('#description').val('');
                                $('#qty').val('0');
                                $('#subCategoryImageCont').empty();
                                files = null;
                            }
                            else {
                                swal("Oops!", 'Something went wrong.', 'danger');
                            }
                        });
                    }

                });

            }            

            //(OffersModel myOffer)
        });

        function addImages(e) {
            //console.log("FILES: ", e.files)
            files = Array.from(e.files);


            for (var i = 0; i < files.length;) {
                (function (index) {
                    var cont = $('<div>').addClass('col-md-2 animated slideInLeft').on('click', function (e) {
                        if (e.target.tagName.toLowerCase() == "img")
                            previewImage(e.target);
                    }).appendTo('#subCategoryImageCont');
                    var placeHolderDiv = $('<div>').attr({ 'name': files[index].name.split('.')[0] }).addClass('image-placeholder').appendTo(cont);
                    $('<i>').addClass('fa fa-trash').on('click', function (e) {
                        if (e.target.tagName.toLowerCase() == "i") {
                            var fileName = $(this).siblings('img').attr('data-name');
                            var retEle = files.filter(function (ele) {
                                return ele.name.trim() == fileName.trim()
                            });

                            if (retEle.length > 0) {
                                var spliceIndex = files.indexOf(retEle[0])
                                console.info("SPLICE INDEX: ", fileName, spliceIndex);
                                files.splice(spliceIndex, 1);
                                console.log("FILES ARRAY : ", files);
                                $('#subCategoryImageCont').find('div[name="' + fileName.split('.')[0] + '"]').parent().remove();
                            }
                        }
                    }).appendTo(placeHolderDiv);
                    var img = $('<img>').attr({ id: 'img_' + index, 'data-name': files[index].name.trim() }).css({ width: '100%' }).appendTo(placeHolderDiv);
                    //placeHolderDiv.bind('click', fnAddImage);



                    //var preview = img;//document.querySelector('img');
                    var file = files[index]; //document.querySelector('input[type=file]').files[0];
                    var reader = new FileReader();

                    reader.onloadend = function () {
                        //preview.src = reader.result;                        
                        $(img).attr({ src: reader.result });
                    }
                    if (file) {
                        reader.readAsDataURL(file);
                    } else {
                        //preview.src = "";
                        $(img).attr({ src: "" });
                    }
                    i++;
                })(i)
            }

        }

        function previewImage(imgSrc) {
            $('#imgPreview').remove();
            var container = $('<div>').attr({ id: 'imgPreview' }).appendTo('body');
            var innerCont = $('<div>').appendTo(container);
            var imageCont = $('<i>').addClass('fa fa-close pull-right').on('click', function () {
                $('#imgPreview').remove();
            }).appendTo(innerCont);
            $('<img>').attr({ src: imgSrc.src }).appendTo(innerCont);
        }


        function uploadImages(files) {
            console.log(files);
            var formData = new FormData();
            for (var f = 0; f < files.length; f++) {
                console.log("F: ", files[f]);
                formData.append('file' + f, files[f]);
            }



            return $.ajax({
                type: 'POST',
                url: '../OfferUploads.ashx',
                data: formData,
                processData: false,
                contentType: false
            });
        }



    </script>
</asp:Content>
