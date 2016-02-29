$(document).ready(function() {
  fetchLinks()
  updateTitle()
})

function renderLink(link) {
  $("#link-info").prepend(
    "<div class='link margin-bottom-40' data-id='" + link.id + "' data-read='" + link.read +
    "' data-title='" + link.title + "' data-url='" + link.url +
    "'><span class='title-span'><span><strong>Title: </strong></span><h4 contentEditable='true' class='link-title'>" + link.title + "</h4></span>" +
    "<span><strong>URL: </strong></span><p contentEditable='true' class='link-url'>" + link.url + "</p>" +
    "<div><p class='link-quality'><strong>Read: </strong>" + link.read + "</p>" +
    readButton(link) +
    "<button class='edit-link' name='edit-button' class=''>Edit</button>"
  )
}

function readButton(link) {
  if (link.read) {
    return "<button class='mark-as-unread-link' name='mark-as-unread-button' class=''>Mark as Unread</button></div>"
  } else {
    return "<button class='mark-as-read-link' name='mark-as-read-button' class=''>Mark as Read</button>"
  }
}

function fetchLinks() {
  var linkUri = '/api/v1/links'

  $.getJSON(linkUri, function(data) {
    $('#link-info').html('');
    $.each(data, function(key, val) {
      renderLink(val)
    })
    // editButton()
  })
}

function updateTitle() {
  $('#link-info').delegate('.link-title', 'keyup', function (event) {
    if(event.keyCode == 13) {
      event.preventDefault();
      var $link = $(this).closest('.link')
      var $updatedTitle = event.currentTarget.textContent
      var linkParams = {
        title: $updatedTitle
      }
      sendPut($link, linkParams, event)
    }
  })
}

function sendPut(link, data, event) {
  $.ajax({
    type: 'PUT',
    url: "/api/v1/links/" + link.attr('data-id') + "",
    data: data,
    success: function(updatedLink) {
      if (event != null) {
        $(event.target).blur()
      }
      replaceTitle(link, updatedLink.title);
    },
    error: function(xhr) {
      console.log("A title is required for your link.")
    }
  })
}

function replaceTitle(link, title) {
  $(link).find('.link-title').html(title)
}
