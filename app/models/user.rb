# User 모델
# users 테이블과 연결되는 모델
# ApplicationRecord를 상속받아 데이터베이스 연동 기능 사용

class User < ApplicationRecord
  # 테이블 이름 명시
  self.table_name = "users"

  # 비밀번호 암호화
  # has_secure_password
  # : bcrypt gem을 사용하여 비밀번호를 안전하게 암호화하고 인증하는 기능 제공
  # : authenticate 메소드를 통해 비밀번호 검증 가능
  has_secure_password

  # 역할 설정 (admin: 0, user: 1)
  enum :role, { admin: 0, user: 1 }, default: :user

  # 유효성 검사
  # validates :login_id, presence: true, uniqueness: true
  # : login_id가 반드시 존재해야 하고(presence: true),
  #   중복되지 않아야 함(uniqueness: true)
  validates :login_id, presence: true, uniqueness: true
  validates :user_name, presence: true # 이름 필수

  # Rails 7.1+ normalization: 양쪽 공백 자동 제거
  normalizes :user_name, with: ->(name) { name.strip }

  # 프로필 이미지 첨부 (Active Storage)
  has_one_attached :avatar

  # 연관관계 설정
  # has_many :todos, dependent: :destroy
  # : user가 삭제되면 해당 user가 작성한 모든 todo도 함께 삭제됨
  has_many :todos, dependent: :destroy
end
