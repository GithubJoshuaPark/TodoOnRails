# users 테이블 생성용 마이그레이션 파일 (rails generate migration CreateUsers 명령어로 생성)
# 터미널에서 아래 명령어를 사용하여 실행 (마이그레이션 실행 > schema.rb 생성)
# bin/rails db:migrate

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :login_id
      t.string :password_digest # 암호화된 비밀번호 bcrypt로 생성

      t.timestamps # created_at, updated_at 자동 생성
    end
    add_index :users, :login_id, unique: true # login_id가 유일한 값이어야 함
  end
end
