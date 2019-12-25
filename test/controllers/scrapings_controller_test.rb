require 'test_helper'

class ScrapingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scrapings_index_url
    assert_response :success
  end

  test "should get show" do
    get scrapings_show_url
    assert_response :success
  end

end
