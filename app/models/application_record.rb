# ApplicationRecord
# 모든 모델이 상속받는 기본 모델
# ActiveRecord::Base (ORM(Object-Relational Mapping)
# : 객체지향 프로그래밍의 객체와 관계형 데이터베이스의 테이블을 연결하는 기술)
# 를 상속받아 데이터베이스 연동 기능 사용

class ApplicationRecord < ActiveRecord::Base
  # 나는 진짜 데이터베이스 테이블이랑 연결되는 녀석이 아니야,
  # 그냥 설계도(추상 클래스)일 뿐이야
  primary_abstract_class
end
