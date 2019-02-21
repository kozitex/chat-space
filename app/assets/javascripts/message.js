$(function() {

  function buildHTML(message) {
    if ( message.image.url == null ) {
      img_tag = '';
    }
    else {
      img_tag = `<img src="${message.image.url}">`;
    }

    var html = `<div class="chatSpace__chat">
                  <div class="chat__firstLine">
                    <p class="chat__userName">${message.user_name}</p>
                    <p class="chat__sendDate">${message.created_at}</p>
                  </div>
                  <p class="chat__message">${message.body}</p>
                  <p class="chat__image">` + img_tag + `</p>
                  <div class="chat__id" data-id="${message.id}"></div>
                </div>`;
    return html;
  }

  function autoUpdate() {
    var url = window.location.href;
    if (url.match('messages')) {
      if ( $('.chat__id:last').data('id') ) {
        var latest_mid = $('.chat__id:last').data('id');
      } else {
        var latest_mid = 0;
      }

      $.ajax({
        url: url,
        dataType: 'json',
        type: 'GET'
      })

      .done(function(messages) {
        var new_messages = $.grep(messages,
          function(message, i) {
            return(message.id > latest_mid);
          }
        );
        if (new_messages.length !== 0) {
          new_messages.forEach(function(message) {
            var html = buildHTML(message);
            $('.mainView__chatSpace').append(html);
          });
        };
      })

      .fail(function() {
        alert('Error!');
      });
    };
  };

  setInterval(autoUpdate, 5000);

  $(document).on('submit', '.chatSender__form', function(e){
    e.preventDefault();
    var form = $('.chatSender__form');
    var formData = new FormData(this);
    var href = form.attr('action');
    var method = form.attr('method');

    $.ajax({
      url: href,
      dataType: 'json',
      type: method,
      data: formData,
      processData: false,
      contentType: false
    })

    .done(function(data) {
      var html = buildHTML(data);
      $('.mainView__chatSpace').append(html);
      $('.chatSender__form')[0].reset();
      $('.mainView__chatSpace').animate({scrollTop: $('.mainView__chatSpace')[0].scrollHeight}, 'fast');
    })

    .fail(function() {
      alert('error!');
    })

    .always(function() {
      $('.form__submitButton').prop('disabled', false);
    });

  });

});
