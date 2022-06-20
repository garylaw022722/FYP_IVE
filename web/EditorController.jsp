<!DOCTYPE html>
<%@page  import="ict.bean.Account"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="css/EditorController.css">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
        <link rel="stylesheet" href="css/customCalender.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
        

    </head>
    <style>
        #calendar table {
            height: 100%;
            overflow: auto;
            box-shadow: 1px 3px 10px rgba(0, 0, 0, 0.8);
            background: whitesmoke;
            border-radius: 3px;
        }

        #calendar table tbody {
            color: #646767;
            font-size: 15px;
        }

        #calendar {
            position: relative;
            z-index: 30;
            left: 70%;
        }

        .fc-toolbar-title {
            color: #859dc1;
        }

        .fc-prev-button, .fc-next-button, .fc-today-button {
            background: #41607c;
        }

        .fc-list-event-dot {
            background: #2e2e30;
        }


    </style>
    <%Account editor = (Account)request.getSession().getAttribute("editor");%>
    
    <%if(editor==null){%>
    <script>window.location.href = "Login2.jsp";</script>
    <%}%>
    
    
    <script>
        function Time() {
            this.title = 'My java is the beser';
            this.start = '2021-03-01T07:00:00';
            this.end = '2021-03-01T08:00:00';
        }

        var item = []
        item.push(new Time())
        var j = JSON.stringify(item);

//        var s = "meetingRequestPanel.jsp";
        s = "EditorMain.jsp"
        $(document).ready(function () {


            $("#contentInsert").load(s)

        });


        function calendarSetting() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                themeSystem: 'bootstrap',
                contentHeight: 500,
                // initialView: 'dayGridMonth',
                initialView: 'listDay',
                events: JSON.parse(j)
            });

            calendar.render();
        }


        function GraphicSetting() {
            var ctx = document.getElementById('myChart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['day 1', 'day 2', 'day 3', 'day 4', 'day 6', 'day 7', 'day 8'],
                    datasets: [
                        {
                            label: 'MArrusa',
                            borderColor: "#6649b0",
                            backgroundColor: [
                                'rgb(0,0,0 ,.3)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            data: [0, 10, 5, 20, 30, 49, 59],
                        }
                    ]
                }, options: {
                    legend: {
                        display: false
                    }, scales: {
                        xAxes: [{
                                ticks: {
                                    fontColor: "#a8c7f1",
                                }

                            }],
                        yAxes: [{

                                ticks: {
                                    fontColor: "#a8c7f1",
                                    beginAtZero: true
                                }
                            }]
                    },
                    title: {
                        position: 'top',
                        display: true,
                        fontColor: "#a8c7f1",
                        text: 'voting Result',
                        fontSize: "13"
                    },
                }
            });
        }
    </script>
    <script></script>
    <body>
        <div id="topNav"></div>
        <div id="left">
            <%@include file="parts/editorLeftBar.jsp" %>
        </div>
        <div id="reight">
            <div id="contentInsert"></div>
        </div>


    </body>
</html>