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
                </div>`;
    return html;
  }

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
