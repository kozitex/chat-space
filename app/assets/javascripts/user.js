$(function() {

  var result_list = $('#user-search-result');

  function appendHTML(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${ user.name }</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
                </div>`;
    result_list.append(html);
  }

  $('.chat-group-form__input').on('keyup', function() {
    var input = $(this).val();

    $.ajax({
      url: '/users',
      type: 'GET',
      dataType: 'json',
      data: { keyword: input }
    })

    .done(function(users) {
      result_list.empty();
      if ( users.length !== 0) {
        users.forEach(function(user) {
          appendHTML(user);
        });
      };
    })

    .fail(function() {
      alert('ユーザー検索に失敗しました');
    });

  });

  $(document).on('click', '.user-search-add', function() {
    var user_id = $(this).attr('data-user-id');
    var user_name = $(this).attr('data-user-name');
    $(this).parent().remove();
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${ user_id }'>
                  <p class='chat-group-user__name'>${ user_name }</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                </div>`;
    $('#chat-group-users').append(html);
  });

  $(document).on('click', '.user-search-remove', function() {
    $(this).parent().remove();
  });

});
