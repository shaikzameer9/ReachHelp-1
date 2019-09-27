function ajaxfunctioncallwithoutdata(Atype, Aurl, Aasync) {
    return $.ajax({
        type: Atype,
        url: Aurl,
        contentType: "application/json; charset=utf-8 ",
        async: Aasync,
        dataType: "json"
    });
}

//default ajax call with Data 

function ajaxfunctioncallwithdata(Atype, Aurl, Adata, Aasync) {
    return $.ajax({
        type: Atype,
        url: Aurl,
        data: JSON.stringify(Adata),
        contentType: "application/json; charset=utf-8 ",
        async: Aasync,
        dataType: "json"
    });
}

function changeSwitchery(element, checked) {
    if ((element.is(':checked') && checked == false) || (!element.is(':checked') && checked == true)) {
        element.parent().find('.switchery').trigger('click');
        var isChecked = element.parent().find('.switchery').is(':checked');
    }
}


var TablePaginator = function (config) {
    console.info("Table Paginator Initialized..", config);

    var _rowsPerPage = (config.rowsPerPage == null ? 5 : config.rowsPerPage),
        _page = (config.page == null ? 1 : config.page),
        _startIndex = (_page - 1) * _rowsPerPage,
        _httpUrl = config.url;

    var _totalRecord = 0;

    var _httpMethod = function () {
        console.log({ startIndex: _startIndex, rowsPerPage: _rowsPerPage });
        return $.ajax({
            type: "POST",
            url: _httpUrl,
            data: JSON.stringify({ startValue: _startIndex, noOFRows: _rowsPerPage }),
            contentType: "application/json; charset=utf-8",
            async: true,
            dataType: "json"/*,
            success: function (response) {
                console.log("LIB RESP: ", response);
            },
            error: function (error) {
                console.error("LIB ERR: ", error);
            }*/
        });


        _httpMethod();

        return {
            httpMethod: _httpMethod
        };

    }





    return {
    };


}


jQuery["appPost"] = function (url, data) {
    // shift arguments if data argument was omitted
    if (jQuery.isFunction(data)) {
        callback = data;
        data = undefined;
    }
    
    var options = {
        url: url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        //data: JSON.stringify(data),
        //success: callback
    };

    if (data != null)
        options['data'] = JSON.stringify(data);

    return jQuery.ajax(options);
};

function getUrlParam(url_string, key) {
    var url = new URL(url_string);
    return url.searchParams.get(key);
}

function checkImage(imageSrc, good, bad) {
    var img = new Image();
    img.onload = good;
    img.onerror = bad;
    img.src = imageSrc;
}