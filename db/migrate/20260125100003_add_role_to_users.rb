# users 테이블에 role 컬럼 추가
# role 값: admin(0), user(1)
# 기본값: user(1)
class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer, default: 1, null: false
  end
end
