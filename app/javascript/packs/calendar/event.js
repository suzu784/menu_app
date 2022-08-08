/*global $*/
// インストールしたファイルたちを呼び出します。
import { Calendar} from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid'
import googleCalendarApi from '@fullcalendar/google-calendar'

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作成

document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');
    if(!calendarEl) {
      return;
    };

    //カレンダーの中身を設定(月表示、クリックアクションを起こす、googleCalendar使用)
    var calendar = new Calendar(calendarEl, {
        plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi ],

        events: '/events.json',
        //細かな表示設定
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 1,
        headerToolbar: {
          start: '',
          center: 'title',
          end: 'today prev,next'
        },
        expandRows: true,
        stickyHeaderDates: true,
        buttonText: {
           today: '今日'
        },
        allDayText: '終日',
        height: "auto",
        editable: true,

        eventDrop: function(info) {
            $.ajax({
                type: 'PATCH',
                url: '/events/' + info.event.id,
                data: {start: info.event.start,
                       end: info.event.end
                },
            })
        },

        dateClick: function(info) {
             //クリックした日付の情報を取得
            const year  = info.date.getFullYear();
            const month = (info.date.getMonth() + 1);
            const day   = info.date.getDate();

            //ajaxでevents/newを着火させ、htmlを受け取ります
            $.ajax({
                type: 'GET',
                url:  '/events/new',
            }).done(function (res) {
                // 成功処理
                // 受け取ったhtmlをさっき追加したmodalのbodyの中に挿入します
                $('.modal-body').html(res);

                //フォームの年、月、日を自動入力
                $('#event_start_1i').val(year);
                $('#event_start_2i').val(month);
                $('#event_start_3i').val(day);

                $('#event_end_1i').val(year);
                $('#event_end_2i').val(month);
                $('#event_end_3i').val(day);

                $('.modal-body').fadeIn();

            }).fail(function (result) {
                // 失敗処理
                alert("failed");
            });
        }

    });
    //カレンダー表示
    calendar.render();
    $(".error").click(function(){
        calendar.refetchEvents();
    });
});
