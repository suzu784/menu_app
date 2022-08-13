/*global $*/
// インストールしたファイルたちを呼び出します。
import { Calendar} from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid';
import googleCalendarApi from '@fullcalendar/google-calendar';

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作成

document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');
    if(!calendarEl) {
      return;
    }

    //カレンダーの中身を設定(月表示、クリックアクションを起こす、googleCalendar使用)
    var calendar = new Calendar(calendarEl, {
        plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi ],

        events: '/events.json',
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 1,
        headerToolbar: {
          start: '',
          center: 'title',
          end: 'today prev,next'
        },
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
                data: { start: info.event.start,
                        end: info.event.end
                },
            });
        },

        eventClick: function(info) {
          if(confirm('削除しますか？'))  {
          $.ajax({
              type: 'DELETE',
              url: '/events/' + info.event.id,
            });
            info.event.remove();
          }
        },

        dateClick: function(info) {
            $.ajax({
                type: 'GET',
                url:  '/events/new',
            }).done(function (res) {
                $('.modal-body').html(res);
            }).fail(function (result) {
                alert("failed");
            });
        }
    });
    //カレンダー表示
    calendar.render();
});
