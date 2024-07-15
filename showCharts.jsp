<%-- 
    Document   : showvisuals
    Created on : 29-Apr-2021, 07:25:31
    Author     : drrprasath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tpt.dm.data.GenerateMarks"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Map.Entry" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Exploring Grades Distribution</title>

    <!-- Include necessary CSS and JavaScript files -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="jqplot/jquery.jqplot.min.css" />

    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jqplot/jquery.jqplot.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.barRenderer.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.cursor.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.canvasAxisLabelRenderer.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.categoryAxisRenderer.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.pointLabels.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.pieRenderer.js"></script>

    <!-- Custom CSS -->
    <style type="text/css">
            @import url(http://fonts.googleapis.com/css?family=Montserrat);
            body { font-family: montserrat, arial, verdana; color: #003300; background-color: #EEE; }
            a, a:active, a:before, a:after, a:visited, a:hover { text-decoration: none; }
            a, a:active, a:before, a:after, a:visited { color: #003300; }
            a:hover { color: #F40; }
            .tc { width: 100%; left: 0; top: 0; position: absolute;  }
            .tcc { width: 100%; }

            .wc { width: 100%;  }
            .wcc {  }

            .bc { width: 100%; max-width: 1280px; margin: 0 auto;  }
            .bcc {  }

            .h2h-canvas { width: 100%; min-width: 640px; max-width: 1280px; margin: 0 auto; 
                          text-align: center; align-content: center; }
            .b2i-cs-canvas { width: 100%; padding:10px 10px 10px 0px; margin: 0 auto; }
            .b2i-cs-wrapper { width: 100%; max-width: 800px;  margin: 0 auto; }
            #cs-charts { width: 100%; min-width: 300px; background-color: #FFF; padding: 10px 5px 10px 5px; 
                         margin: 10px; box-shadow: 0 0 10px #BBB; }
            #pb-charts { width: 100%; padding: 2px 0px 2px 4px; }
            .sm-chart { height: 360px; }
            #sm-total { font-size: 16px; font-weight: bold; }
            .fl { float: left; }

            .hrline { border: 0; height: 0; margin: 0 auto; margin-top: 5px; margin-bottom: 5px; border-top: 1px solid #6699ff; }

            .b2i-header { font-size: 24px; color: #F00; padding: 10px; }
            .b2i-shdr { font-size: 21px; font-weight: bold; color: #F00; }
            .b2i-stext { font-size: 12px; color: #F00; }
        </style>

     <script type="text/javascript">
        $(document).ready(function () {
            // Retrieve data from hidden inputs
            var pieData = eval(document.getElementById("pt1").value);
            var barData = eval(document.getElementById("pt2").value);
            var lineData = eval(document.getElementById("pt3").value);

            console.log(barData)
//            console.log(lineData)
              // Visualization for Pie Chart
            drawPieC('pb-pie-chart', pieData, 'Grade Distribution - Pie Chart');
            drawBarC('pb-bar-chart', barData, 'Grade Distribution - Bar Chart');
            drawLineC('pb-line-chart', lineData, 'Grade Distribution - Line Chart');
        });

        // JavaScript functions to draw charts
    function drawPieC(divid, data, ctitle) {
                var piechart = $.jqplot(divid, [data], {
                    title: ctitle,
                    grid: {drawBorder: true, drawGridlines: false, background: '#ffffff', shadow: true},
                    seriesColors: ['#00aa23', '#09ee71', '#ffe45c', '#ff9900', '#FF3433'],
                    axesDefaults: {},
                    seriesDefaults: {renderer: $.jqplot.PieRenderer, rendererOptions: {showDataLabels: true}},
                    legend: {show: true, location: 'e'}
                });
            }

            function drawBarC(divid,data, ctitle) {
                var ticks = ['O', 'A', 'B', 'C', 'D', 'P', 'F'];
                // Rearrange the data to match the order of ticks
                var rearrangedData = ticks.map(function(tick) {
                    var found = data.find(function(item) {
                        return item[0] === tick;
                    });
                    return found ? found[1] : 0;
                });

                var barchart = $.jqplot(divid, [rearrangedData], {
                    title: ctitle,
                    stackSeries: true,
                    captureRightClick: true,
                    seriesColors: ['#F90'],
                    seriesDefaults: {
                        renderer: $.jqplot.BarRenderer,
                        rendererOptions: { barMargin: 30, highlightMouseDown: true },
                        pointLabels: { show: true }
                    },
                    series: [{ label: ' &nbsp; Grades &nbsp; ' }],
                    axes: {
                        xaxis: { renderer: $.jqplot.CategoryAxisRenderer, ticks: ticks },
                        yaxis: { tickOptions: { formatString: '%d' } }
                    },
                    legend: { show: true }
                });
            }


                      
            function drawLineC(divid,data, ctitle) {
                var ticks = ['O', 'A', 'B', 'C', 'D', 'P', 'F'];
                // Rearrange the data to match the order of ticks
                var rearrangedData = ticks.map(function(tick) {
                    var found = data.find(function(item) {
                        return item[0] === tick;
                    });
                    return found ? found[1] : 0;
                });

                var linechart = $.jqplot(divid, [rearrangedData], {
                    title: ctitle,
                    captureRightClick: true,
                    seriesColors: ['#F90'],
                    seriesDefaults: {
                        renderer: $.jqplot.LineRenderer,
                        rendererOptions: { highlightMouseDown: true },
                        pointLabels: { show: true }
                    },
                    series: [{ label: ' &nbsp; Grades &nbsp; ' }],
                    axes: {
                        xaxis: { renderer: $.jqplot.CategoryAxisRenderer, ticks: ticks },
                        yaxis: { tickOptions: { formatString: '%d' } }
                    },
                    legend: { show: true }
                });
            }
    </script>
</head>
<body>
<%
    // Define seed value
    int seed = 10143;
    Random rand = new Random(seed);
     int co = 20 + Math.abs(rand.nextInt() % 100); // The number of students is generated randomly
    // Hardcoded value for co
//    int co = 116;
    
    int totalStudents = 0; // Initialize total students count
    
    // Declare variables outside of the if block
    StringBuilder pieData = new StringBuilder("[");
    StringBuilder barData = new StringBuilder("[");
    StringBuilder lineData = new StringBuilder("[");
    
    if (co > 0) {
        // Create an instance of GenerateMarks
        GenerateMarks generateMarks = new GenerateMarks();

        // Call the getIDGrade method to retrieve grade data
        Map<Character, Integer> gradeCounts = generateMarks.getIDGrade(co, seed);

        // Calculate total students
        for (int count : gradeCounts.values()) {
            totalStudents += count;
        }

        // Prepare data for visualization
        for (Map.Entry<Character, Integer> entry : gradeCounts.entrySet()) {
            char grade = entry.getKey();
            int count = entry.getValue();
            // Append data to respective StringBuilder objects
            pieData.append("['").append(grade).append("',").append(count).append("],");
            barData.append("['").append(grade).append("',").append(count).append("],");
            lineData.append("['").append(grade).append("',").append(count).append("],");
        }
    } else {
        // Handle the case where co <= 0
        out.println("<div class=\"b2i-shdr\">Number of Records must not be NULL to show the Visualization</div>");
        System.out.println("Count = " + co);
    }
    // Close StringBuilder objects
    pieData.append("]");
    barData.append("]");
    lineData.append("]");
%>

<div class="tc">
    <div class="tcc">
        <div class="wc">
            <div class="wcc">
                <div class="bc">
                    <div class="bcc">
                        <div id="bm-container" class="bm-container">
                            <div class="h2h-canvas">
                                <div class="b2i-header">
                                    <div class="b2i-shdr">Grade Distribution</div>
                                    <div class="b2i-stext">(Demonstrated by Dr. Rajendra Prasath, IIIT Sri City)</div>
                                </div>
                                <hr class="hrline">
                                <div style="float: right;">
                                </div>
                                <div class="b2i-cs-canvas">
                                    <div class="b2i-cs-wrapper">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="fl">Number of Students: <span id="sm-total"><%= totalStudents %></span></div>
                                                <button id="reload" onclick="window.location.reload();" style="float: right;">Reload</button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div id="cs-charts">
                                                    <div id="pb-pie-chart">
                                                        <div class="sm-chart"></div>
                                                    </div>
                                                </div>
                                                <div id="cs-charts">
                                                    <div id="pb-bar-chart">
                                                        <div class="sm-chart"></div>
                                                    </div>
                                                </div>
                                                <div id="cs-charts">
                                                    <div id="pb-line-chart">
                                                        <div class="sm-chart"></div>
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
    </div>
</div>

<input type="hidden" id="pt1" value="<%= pieData.toString()%>">
<input type="hidden" id="pt2" value="<%= barData.toString()%>">
<input type="hidden" id="pt3" value="<%= lineData.toString()%>">

</body>
</html>