require 'test_helper'

class Api::V1::LinksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    user = User.create!(email: "emily@editingemily.com", password: "password")
    @current_user = user
    @current_user.links.create!(title: "Thing", url: "http://facebook.com")
  end

  test "#update responds to json" do
    get :update, format: :json, symbolize_names: true, id: @current_user.links.last.id, title: "Title", url: "http://google.com"
    assert_response :success
  end

  test "#update edits a record" do
    original = Link.last

    get :update, format: :json, symbolize_names: true, id: @current_user.links.last.id, title: "New Title", url: "http://google.com"

    refute_equal original.title, Link.last.title
    refute_equal original.url, Link.last.url
    assert_equal original.read, Link.last.read
    assert_equal "New Title", Link.last.title
    assert_equal "http://google.com", Link.last.url
  end

  test "#update doesn't add an extra record" do
    starting_count = Link.count

    get :update, format: :json, symbolize_names: true, id: Link.last.id, title: "New Title", url: "http://google.com"

    assert_equal starting_count, Link.count
  end

  test "#update saves old title correctly" do
    original_title = Link.last.title
    original_url = Link.last.url

    get :update, format: :json, symbolize_names: true, id: Link.last.id, url: "http://google.com"


    assert_response :success
    assert_equal original_title, Link.last.title
    refute_equal original_url, Link.last.url
    assert_equal Link.last.url, "http://google.com"
  end

end
