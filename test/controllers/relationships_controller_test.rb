require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest

  # ログインしてないユーザーがフォロー使用とするとログインページに飛ばされるためRelationshipの数は変わらない
  test "create should require logged-in user" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_url
  end

  # ログインしてないユーザーはフォロー関係を削除できない
  test "destroy should require logged-in user" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:one))
    end
    assert_redirected_to login_url
  end
end