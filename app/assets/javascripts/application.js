// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .

$(function(){
    $("#datepicker1").datepicker({
        dateFormat: 'yy-mm-dd',
        //勤怠日選択時、その日の勤怠が既に登録されていればそれを表示
        onSelect: function(){
            $.ajax({
                async: false,
                url: "kintais/exists_kintai?kintai_date=" + $("#datepicker1").val(),
                type: "GET",
                data: {kintai_date : $("#datepicker1").val()},
                dataType: "json",
                success: function(data) {
                    if (data["id"] != "")
                    {
                        window.location.replace("kintais/" + data["id"] + "/edit") ;
                    }
                    else
                    {
                        window.location.replace("kintais/new") ;
                    }
                },
                error: function(data) {
                    alert(error);
                }
            });
        }
    });

    $("#datepicker2").datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $("#datepicker3").datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $("#lnkKintaiLists").on('click', function () {
        var dateValue = $("#datepicker1").val()
        location.replace("/kintais/kintai_lists/" + dateValue.substr(0,4) + dateValue.substr(5,2));
    });
});

function getKintaiMonth(){
    var dateValue = $("#datepicker1").val()
    return "/kintais/kintai_lists/" + dateValue.substr(0,4) + dateValue.substr(5,2);
};