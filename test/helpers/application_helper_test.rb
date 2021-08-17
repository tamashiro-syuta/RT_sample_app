# full_titleヘルパーの単体テスト

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    # full_titleの引数が空の時に期待する値
    assert_equal full_title,         "Ruby on Rails Tutorial Sample App"
    # full/titleの引数がHelpの時に期待する値
    assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
  end
end