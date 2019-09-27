<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="manageLanguage.aspx.cs" Inherits="ReachHelpWF.main.manageLanguage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="col-md-12">
            <div class="" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#managetab" id="manage-tab" role="tab" data-toggle="tab" aria-expanded="true">Manage</a>
                    </li>
                    <li role="presentation" class=""><a href="#translatetab" role="tab" id="translate-tab" data-toggle="tab" aria-expanded="false">Translate</a>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane fade active in" id="managetab" aria-labelledby="home-tab">
                        <div class="row">
                            <div class="col-md-12 col-xs-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Language<small>List of all the Languages.</small></h2>
                                        <div style="display: inline-block;">
                                            <button class="btn btn-sm btn-round btn-primary" id="addnewLanguage" type="button">New</button>
                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div id="managelang" style="display: none;">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="col-md-3 col-xs-6">
                                                        <label for="languagename">Language Name  <span id="langnameErr" style="display: none"></span></label>
                                                        <input type="text" id="languagename" class="form-control" required />
                                                    </div>
                                                    <button type="button" id="submitNewlang" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;">Add</button>
                                                    <button type="button" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;" id="modifylang">Modify</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12 table" style="overflow-x:auto;">
                                                <table class="table table-striped" id="listlanguagestable">
                                                    <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th>#</th>
                                                            <th>Language Name</th>
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
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="translatetab" aria-labelledby="profile-tab">
                        <div class="row">
                            <div class="col-md-12 col-xs-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Langauage Translation</h2>
                                        <div style="display: inline-block;">
                                            <button class="btn btn-sm btn-round btn-primary" id="newlangTranslate" type="button">New</button>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div id="langTranslateCont" style="display: none;">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="col-md-3 col-xs-6">
                                                        <label for="englishWord">English Word <span id="engwordErr" style="display: none"></span></label>
                                                        <input type="text" id="englishWord" class="form-control" />
                                                    </div>
                                                    <div class="col-md-3 col-xs-6">
                                                        <label for="addselectlanguage">Select Language* <span id="selLangErr" style="display: none"></span></label>
                                                        <select id="addselectlanguage" class="form-control select2">
                                                            <option value="">Select Language</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3 col-xs-6">
                                                        <label for="translatedWord">Translate Word*<span id="TransWordErr" style="display: none"></span></label>
                                                        <input type="text" id="translatedWord" class="form-control" />
                                                    </div>
                                                    <button type="button" id="addNewTranslate" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;">Add</button>
                                                    <button type="button" class="btn btn-md btn-primary" style="margin: 24px 0 0 0;" id="editNewTranslate">Modify</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="row">
                                            <small>List of all the Translated Words.</small>
                                            <div class="col-xs-12 table" style="padding-top: 25px; margin-top: 25px; border-top: 2px solid #ddd;">

                                                <div class="col-md-3 col-xs-6 form-group">
                                                    <label for="selectlanguageList">Select Language*</label>
                                                    <select id="selectlanguageList" class="form-control select2">
                                                        <option value="">Select Language</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-12" style="overflow-x:auto;">
                                                    <table class="table table-striped" id="translateTable">
                                                        <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>#</th>
                                                                <th>English</th>
                                                                <th>Translate</th>
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
                                                </div>
                                            </div>
                                        </div>
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
        //Manage Language
        (function () {
            translator.lang(sessionStorage.getItem('langCode'));

            getAllLangslist();
            getLanguageList("selectlanguageList");
            getLanguageList("addselectlanguage");
        })()

        $("#addnewLanguage").on('click', function () {
            $("#managelang").slideToggle();
        });

        function getAllLangslist() {
            ajaxfunctioncallwithoutdata("POST", "./index.aspx/ListLanguagesForAdmin", true).then(function (resp) {
                var listlang = resp.d;
                //console.log(listlang, listlang.length);
                var listlanguagestable = $('#listlanguagestable').find('tbody');

                if (listlang.length > 0) {
                    listlanguagestable.empty();
                    for (var langid in listlang) {
                        //console.log(listlang[langid]);
                        var tr = $('<tr>').attr({ 'data-langid': listlang[langid].languageId }).appendTo(listlanguagestable);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'radCat' }).addClass('flat catRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(langid) + 1).appendTo(tr);
                        var td3 = $('<td>').text(listlang[langid].languageName).appendTo(tr);
                        var td5 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;cursor:pointer"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var langid = thisTr.attr('data-langid'),
                                langName = thisTr.find('td:eq(2)').text();
                            $('#managelang').slideDown();
                            $('#languagename').val(langName);

                        }).appendTo(td5);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;cursor:pointer"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-langid'));
                        }).appendTo(td5);
                    }

                    $('input.flat').iCheck({
                        checkboxClass: 'icheckbox_flat-green',
                        radioClass: 'iradio_flat-green'
                    });
                }

            });
        }

        $('#submitNewlang').on('click', function () {
            var langname = $('#languagename').val();

            if (langname == "") {
                $('#langnameErr').text('Please enter a Language Name!').css({ color: 'red' }).show();
                return false;
            }
            $('#langnameErr').hide();

            var langdetais = {
                languageName: langname,
                languageId: ""
            };
            ajaxfunctioncallwithdata('POST', './index.aspx/AddLanguage', langdetais, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    getAllLangslist();
                }
            });
        });

        $('#modifylang').on('click', function () {
            var selectedlange = $('.catRad:checked').parents('tr');
            var langid = selectedlange.data('langid'),
                langname = $('#languagename').val();

            if (langname == "") {
                $('#langnameErr').text('Please enter a Language Name!').css({ color: 'red' }).show();
                return false;
            }

            $('#langnameErr').hide();

            var langdetais = {
                languageName: langname,
                languageId: langid
            };

            ajaxfunctioncallwithdata('POST', './index.aspx/AddLanguage', langdetais, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    getAllLangslist();

                    selectedlange.attr({ 'data-langid': langid });
                    selectedlange.find('td:eq(2)').text(languageName);
                    $('#languagename').val('');
                    $('#managelang').slideUp();
                }
            });
        });

        //Translate Language
        $("#newlangTranslate").on('click', function () {
            $("#langTranslateCont").slideToggle();
        });

        function getLanguageList(dropdownName) {
            return ajaxfunctioncallwithoutdata("POST", "./index.aspx/ListLanguagesForAdmin", true).then(function (resp) {
                //console.log(resp.d);
                var langList = resp.d;
                $('#' + dropdownName).empty();
                $('<option>').attr({ value: '' }).text("Select Language").appendTo('#' + dropdownName);
                for (var lList in langList) {
                    if (langList[lList].languageId != 1) {
                        $('<option>').attr({ value: langList[lList].languageId }).text(langList[lList].languageName).appendTo('#' + dropdownName);
                    }
                }
                $('.select2').select2({ width: '100%' });
            });
        }

        $("#selectlanguageList").change(function () {
            getAllTranslateList($(this).val());
        });

        function getAllTranslateList(lid) {
            var langdetais = {
                LangId: lid
            }
            ajaxfunctioncallwithdata('POST', './index.aspx/ListLanguageWords', langdetais, true).then(function (resp) {
                var listTransLang = resp.d;
                //console.log(listTransLang, listTransLang.length);
                var listTransLangtable = $('#translateTable').find('tbody');
                listTransLangtable.empty();
                if (listTransLang.length > 0) {

                    for (var langid in listTransLang) {
                        //console.log(listTransLang[langid]);
                        var tr = $('<tr>').attr({ 'data-langmapid': listTransLang[langid].mapId }).appendTo(listTransLangtable);
                        var td0 = $('<td>').appendTo(tr);
                        var subRad = $('<input>').attr({ type: 'radio', name: 'transCat' }).addClass('flat catRad').appendTo(td0);
                        var td1 = $('<td>').text(parseInt(langid) + 1).appendTo(tr);
                        var td3 = $('<td>').text(listTransLang[langid].englishWord).appendTo(tr);
                        var td3 = $('<td>').text(listTransLang[langid].languageWord).appendTo(tr);
                        var td5 = $('<td>').appendTo(tr);

                        var editSpan = $('<span style="font-size: large; color: orange; margin: 0 5px;cursor:pointer"><i class="fa fa-pencil"></i></span>').bind('click', function () {
                            var thisTr = $(this).parents('tr');

                            thisTr.find('td:eq(0) input').iCheck('check');

                            var langid = thisTr.attr('data-langmapid'),
                                EnglishWord = thisTr.find('td:eq(2)').text(),
                                TransLangId = $("#selectlanguageList").val(),
                                TransWord = thisTr.find('td:eq(3)').text();

                            $('#langTranslateCont').slideDown();
                            $('#englishWord').val(EnglishWord);
                            $('#addselectlanguage').val(TransLangId).select2();
                            $('#translatedWord').val(TransWord);

                        }).appendTo(td5);

                        var delSpan = $('<span style="font-size: large; color: crimson; margin: 0 5px;cursor:pointer"><i class="fa fa-trash-o"></i></span>').bind('click', function () {
                            alert("Delete" + $(this).parents('tr').attr('data-langmapid'));
                        }).appendTo(td5);
                    }

                    $('input.flat').iCheck({
                        checkboxClass: 'icheckbox_flat-green',
                        radioClass: 'iradio_flat-green'
                    });
                } else {
                    $('<tr><td colspan="5"><h3 style="text-align: center;">-- No Data --</h3></td></tr>').appendTo(listTransLangtable);
                }

            });
        }

        $('#addNewTranslate').on('click', function () {
            var englishWord = $('#englishWord').val(),
            addselectlanguage = $('#addselectlanguage').val(),
            translatedWord = $('#translatedWord').val();
            /*engwordErr
selLangErr
TransWordErr*/
            if (englishWord == "") {
                $('#engwordErr').text('Please enter English Word').css({ color: 'red' }).show();
                return false;
            } else if (addselectlanguage == "") {
                $('#selLangErr').text('Please Select Language').css({ color: 'red' }).show();
                return false;
            } else if (translatedWord == "") {
                $('#TransWordErr').text('Please Enter Translate Word').css({ color: 'red' }).show();
                return false;
            }
            $('#engwordErr, #selLangErr, #TransWordErr').hide();

            var langTransDetais = {
                englishWord: englishWord,
                languageId: addselectlanguage,
                languageWord: translatedWord
            };
            ajaxfunctioncallwithdata('POST', './index.aspx/LanguageTranslation', langTransDetais, true)
            .then(function (resp) {
                //console.log(resp.d);
                if (resp.d) {
                    $('#englishWord').val('');
                    $('#addselectlanguage').val('').select2();
                    $('#translatedWord').val('');

                    $('#selectlanguageList').val(addselectlanguage).select2();
                    getAllTranslateList(addselectlanguage);
                }
            });
        });


    </script>
</asp:Content>
