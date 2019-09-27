<%@ Page Title="" Language="C#" MasterPageFile="~/main/Dashboard.Master" AutoEventWireup="true" CodeBehind="adminDash.aspx.cs" Inherits="ReachHelpWF.main.adminDash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="trn">Dashboard</h3>
                    <a href="adminDetailed" class="btn btn-info btn-xs">Detailed View</a>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12">
                    <div id="map" style="min-height:200px"></div>
                </div>
            </div>
            <div class="row tile_count">
                <div class="col-md-3 col-sm-6 col-xs-12 tile_stats_count">
                    <span class="count_top"><i class="fa fa-clock-o"></i> Average Latency</span>
                    <div class="count" id="AverageLatencyCT" runat="server"></div>
                    <span class="count_bottom" id="AverageLatencyCP" runat="server"></span>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12 tile_stats_count">
                    <span class="count_top"><i class="fa fa-clock-o"></i> Total Latency</span>
                    <div class="count" id="TotalLatencyCT" runat="server"></div>
                    <span class="count_bottom" id="TotalLatencyCP" runat="server"></span>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12 tile_stats_count">
                    <span class="count_top"><i class="fa fa-star"></i> Ratings</span>
                    <div class="count" id="RatingsCT" runat="server">2,500</div>
                    <span class="count_bottom" id="RatingsCP" runat="server"></span>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12 tile_stats_count">
                    <span class="count_top"><i class="fa fa-users"></i> Total Users</span>
                    <div class="count" id="totalUsers" runat="server"></div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#ReceivedVolumeTotaltab"><b>Received Volume Total</b></a></li>
                        <li><a data-toggle="tab" href="#ReceivedVolumePreMonthtab"><b>Received Volume Last Month</b></a></li>
                        <li><a data-toggle="tab" href="#OfferedVolumeTotaltab"><b>Offered Volume Total</b></a></li>
                        <li><a data-toggle="tab" href="#OfferedVolumePreMonthtab"><b>Offered Volume Last Month</b></a></li>
                    </ul>

                    <div class="tab-content">
                        <div id="ReceivedVolumeTotaltab" class="tab-pane fade in active" style="margin:20px 0">

                        </div>
                        <div id="ReceivedVolumePreMonthtab" class="tab-pane fade" style="margin:20px 0">
                            
                        </div>  
                         <div id="OfferedVolumeTotaltab" class="tab-pane fade" style="margin:20px 0">

                        </div>
                        <div id="OfferedVolumePreMonthtab" class="tab-pane fade" style="margin:20px 0">
                            
                        </div>                       
                    </div>
                </div>
            </div>

            
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptIncludesPlaceHolder" runat="server">    
    <script>
        var map, heatmap;

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                zoom: 13,
                center: { lat: 37.775, lng: -122.434 },
                mapTypeId: 'satellite'
            });

            heatmap = new google.maps.visualization.HeatmapLayer({
                data: getPoints(),
                map: map
            });
        }

        function toggleHeatmap() {
            heatmap.setMap(heatmap.getMap() ? null : map);
        }

        function changeGradient() {
            var gradient = [
              'rgba(0, 255, 255, 0)',
              'rgba(0, 255, 255, 1)',
              'rgba(0, 191, 255, 1)',
              'rgba(0, 127, 255, 1)',
              'rgba(0, 63, 255, 1)',
              'rgba(0, 0, 255, 1)',
              'rgba(0, 0, 223, 1)',
              'rgba(0, 0, 191, 1)',
              'rgba(0, 0, 159, 1)',
              'rgba(0, 0, 127, 1)',
              'rgba(63, 0, 91, 1)',
              'rgba(127, 0, 63, 1)',
              'rgba(191, 0, 31, 1)',
              'rgba(255, 0, 0, 1)'
            ]
            heatmap.set('gradient', heatmap.get('gradient') ? null : gradient);
        }

        function changeRadius() {
            heatmap.set('radius', heatmap.get('radius') ? null : 20);
        }

        function changeOpacity() {
            heatmap.set('opacity', heatmap.get('opacity') ? null : 0.2);
        }

        // Heatmap data: 500 Points
        function getPoints() {
            var arr = [];
            $.appPost('./adminDash.aspx/getHeatMapData', null)
            .then(function (data) {
                var locations = data.d;
                locations.forEach(function (item) {
                    var geo = item.location.split(',');
                    arr.push(new google.maps.LatLng(geo[0], geo[1]));
                });

                var position = new google.maps.LatLng(locations[0].location.split(',')[0], locations[0].location.split(',')[1]);
                map.panTo(position);
            })

            return arr;
            //return [
            //  new google.maps.LatLng(13.4281, 74.7762),
            //  new google.maps.LatLng(13.4281, 74.7762)              
            //];
        }

        $(document).ready(function () {            


            printalldata("ReceivedVolumeTotaltab", "ReceivedVolume", false);
            //printalldata("ReceivedVolumePreMonthtab", "ReceivedVolume", true);
            //printalldata("OfferedVolumeTotaltab", "OfferedVolume", false);
            //printalldata("OfferedVolumePreMonthtab", "OfferedVolume", true);

            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href");

                if (target.substring(1) == "ReceivedVolumePreMonthtab") {
                    printalldata("ReceivedVolumePreMonthtab", "ReceivedVolume", true);
                }
                if (target.substring(1) == "OfferedVolumeTotaltab") {
                    printalldata("OfferedVolumeTotaltab", "OfferedVolume", false);
                }
                if (target.substring(1) == "OfferedVolumePreMonthtab") {
                    printalldata("OfferedVolumePreMonthtab", "OfferedVolume", true);
                }

            });


            function printalldata(printid, url, input) {
                var objs = {
                    prevMonth: input
                }

                ajaxfunctioncallwithdata('POST', './adminDash.aspx/'+url, objs, true).then(function (resp) {
                    var reportsdata = resp.d;
                    //console.log(reportsdata, reportsdata.length);
                    $('#' + printid).empty();
                    var platformTB = $('<table>').addClass('table table-striped').attr({ id: printid+'_Table' }).css({ 'width': '100%' }).appendTo('#' + printid);
                    $('<thead>').appendTo(platformTB);
                    $('<tr>').appendTo('#'+printid+'_Table thead');

                    $('<th>').html('#').appendTo('#'+printid+'_Table thead tr');
                    $('<th>').html('Sub Category').appendTo('#'+printid+'_Table thead tr');
                    $('<th>').html('Category').appendTo('#'+printid+'_Table thead tr');
                    $('<th>').html('Quantity').appendTo('#'+printid+'_Table thead tr');
                    $('<th>').html('Unit').appendTo('#'+printid+'_Table thead tr');

                    $('<tbody>').appendTo(platformTB);
                    if (reportsdata.length > 0) {
                        for (var data in reportsdata) {
                            $('<tr>').attr({ id: printid + '_Table' + data }).appendTo('#'+printid+'_Table tbody');
                            $('<td>').html(parseInt(data) + 1).appendTo('#'+printid+'_Table' + data);
                            $('<td>').html(reportsdata[data].subCategory).appendTo('#'+printid+'_Table' + data);
                            $('<td>').html(reportsdata[data].category).appendTo('#'+printid+'_Table' + data);
                            $('<td>').html(reportsdata[data].quantity).appendTo('#'+printid+'_Table' + data);
                            $('<td>').html(reportsdata[data].unit).appendTo('#'+printid+'_Table' + data);
                        }
                    }

                    $('#'+printid+'_Table').DataTable();
                });
            }
        });
        

    </script>
</asp:Content>
