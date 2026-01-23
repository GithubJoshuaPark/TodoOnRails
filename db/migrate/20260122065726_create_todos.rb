# todos 테이블 생성용 마이그레이션 파일 (rails generate migration CreateTodos 명령어로 생성)
# 터미널에서 아래 명령어를 사용하여 실행 (마이그레이션 실행 > schema.rb 생성)
# bin/rails db:migrate

class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false # 완료 여부

      # 사용자(User)와의 Foreign Key관계
      # null: false -> 반드시 값이 있어야 함
      # foreign_key: true -> Users 테이블과의 관계를 나타냄 (N:1 관계)
      t.references :user, null: false, foreign_key: true

      t.timestamps # created_at, updated_at 자동 생성
    end
  end
end
