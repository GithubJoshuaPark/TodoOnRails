# Todo 모델
# todos 테이블과 연결되는 모델
# ApplicationRecord를 상속받아 데이터베이스 연동 기능 사용

class Todo < ApplicationRecord
  # 테이블 이름 명시
  self.table_name = "todos"

  # 연관관계 설정
  # belongs_to :user
  # : user_id 컬럼을 통해 User 모델과 연결
  # : user_id가 반드시 존재해야 함(null: false)
  belongs_to :user

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "description", "completed", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end
end
