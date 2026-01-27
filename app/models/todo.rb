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

  # 유효성 검사
  validates :title, presence: true

  # 우선순위 설정 (Low: 0, Medium: 1, High: 2)
  enum :priority, { low: 0, medium: 1, high: 2 }, default: :medium

  # 상태 컬럼 타입 명시 (Rails 8.1 요구사항)
  attribute :status, :string

  # 상태 설정 (Ready: 'R', Doing: 'D', Done: 'C', Archived: 'A')
  # Kanban 보드의 컬럼별 분류를 위해 사용
  enum :status, { ready: "R", doing: "D", done: "C", archived: "A" }, default: :ready

  # Ransack용 설정
  def self.ransackable_attributes(auth_object = nil)
    [ "title", "description", "completed", "status", "created_at", "updated_at" ]
  end

  # Ransack용 설정
  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end
end
