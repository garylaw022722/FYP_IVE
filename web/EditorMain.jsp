<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
</head>
<script>
    $(document).ready(function () {
        calendarSetting();
        GraphicSetting()
        $(".vtr").click(function () {
            alert("it is clicked")
        })
        
        $("#VotingResult").click(function(){
            window.location.href = "EditorContribution.jsp";
        })
        
          $("#Constract").click(function(){    
            window.location.href = "EditorContract.jsp";
        })
        $("#Request").click(function(){
            window.location.href = "meetingRequest.jsp";
        })
        $("#VotingResult").click(function(){
            window.location.href = "EditorContribution.jsp";
        })
        

    })
</script>
<body>
<div id="voting">
    <div id="t1">
        <div id='Constract'><span>Contract</span></div>
        <div id="Request"><span>Meeting Request</span></div>
        <!--            <div id="Request"><span>Meeting Request</span></div>-->
        <div id="VotingResult">
            <span style="display: inline-block;padding-bottom: 2px">Contribution</span>
            <!--                <canvas id="myChart" width="400px" height="200px"></canvas>-->
        </div>
        <div id="CalenderReading"><span>Calendar</span></div>
    </div>
</div>

<div id="voting" class="vtr" style="
        top: 290px;
        width: 29%;
        left: 70%;
        padding-top: 10px;
        height: 250px;
        box-shadow: 1px 1px  3px grey
       ">
    <canvas id="myChart" width="400px" height="200px"></canvas>
</div>

<div id='calendar'></div>

</body>
</html>