require 'test_helper'

class RepriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get repries_create_url
    assert_response :success
  end

  test "should get destroy" do
    get repries_destroy_url
    assert_response :success
  end

end
