require 'test_helper'

class ImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get import" do
    get imports_import_url
    assert_response :success
  end

  test "should get export" do
    get imports_export_url
    assert_response :success
  end

end
