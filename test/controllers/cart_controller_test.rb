require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get cart_edit_url
    assert_response :success
  end

end
