# Rails DB 디렉토리 완벽 가이드 📚

> 💡 **Rails 프로젝트의 `db/` 디렉토리는 데이터베이스 관련 파일들을 관리하는 핵심 공간입니다.**

---

## 📁 디렉토리 구조

```bash
db/
├── migrate/                    # 마이그레이션 파일들 (DB 변경 이력)
│   ├── 20260122065724_create_users.rb
│   ├── 20260122065726_create_todos.rb
│   ├── 20260124071422_create_active_storage_tables.active_storage.rb
│   └── 20260125100003_add_role_to_users.rb
├── schema.rb                   # 현재 DB 구조 (자동 생성, 수정 금지!)
└── seeds.rb                    # 초기 데이터 투입용
```

---

## 1️⃣ **migrate/** - 마이그레이션 파일들

**마이그레이션**은 데이터베이스 변경 이력을 코드로 관리하는 Rails의 핵심 기능입니다.

### 📌 파일명 규칙

```
[타임스탬프]_[설명].rb
예: 20260122065724_create_users.rb
```

- **타임스탬프**: 파일 생성 시각 (YYYYMMDDHHmmss)
- **순서 보장**: 시간 순서대로 실행됨

---

### 📄 create_users.rb - Users 테이블 생성

```ruby
class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :login_id
      t.string :password_digest    # bcrypt 암호화용
      t.string :user_name
      t.text :bio
      t.timestamps                  # created_at, updated_at 자동 생성
    end
    add_index :users, :login_id, unique: true
  end
end
```

**역할**: `users` 테이블 생성

| 컬럼              | 타입     | 설명                          |
| ----------------- | -------- | ----------------------------- |
| `login_id`        | string   | 로그인 아이디 (유니크 인덱스) |
| `password_digest` | string   | bcrypt로 암호화된 비밀번호    |
| `user_name`       | string   | 사용자 이름                   |
| `bio`             | text     | 자기소개                      |
| `timestamps`      | datetime | 생성/수정 시간 자동 기록      |

---

### 📄 create_todos.rb - Todos 테이블 생성

```ruby
class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false
      t.datetime :due_date
      t.integer :priority
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
```

**역할**: `todos` 테이블 생성

| 설정                 | 설명                                |
| -------------------- | ----------------------------------- |
| `t.references :user` | User 모델과의 외래키 관계 자동 설정 |
| `null: false`        | user_id가 필수 (반드시 소유자 존재) |
| `foreign_key: true`  | DB 레벨에서 참조 무결성 보장        |

---

### 📄 create_active_storage_tables.rb - 파일 업로드

**역할**: 파일 업로드를 위한 Active Storage 테이블 생성

생성되는 3개의 테이블:

| 테이블                           | 역할                                                     |
| -------------------------------- | -------------------------------------------------------- |
| `active_storage_blobs`           | 파일 메타데이터 (key, filename, content_type, byte_size) |
| `active_storage_attachments`     | 파일과 모델 연결 (polymorphic 관계)                      |
| `active_storage_variant_records` | 이미지 변형 정보 (썸네일 등)                             |

**사용 예시**: User 모델의 `avatar` (프로필 사진)

---

### 📄 add_role_to_users.rb - 컬럼 추가

```ruby
class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer, default: 1, null: false
  end
end
```

**역할**: 기존 `users` 테이블에 `role` 컬럼 추가

- **값**: `admin(0)`, `user(1)`
- **기본값**: `1` (일반 사용자)
- 파일명 타임스탬프를 보면 나중에 추가된 것을 알 수 있음

---

## 2️⃣ **schema.rb** - 현재 DB 구조

> ⚠️ **중요**: 이 파일은 **절대 직접 수정하지 않습니다!**

### 특징

- 모든 마이그레이션을 실행한 **최종 결과물**
- `bin/rails db:migrate` 실행 시 자동 갱신
- 새로운 환경에서 `bin/rails db:schema:load`로 빠르게 DB 구조 복원 가능

### 언제 사용하나?

| 상황         | 명령어                     | 설명                                        |
| ------------ | -------------------------- | ------------------------------------------- |
| 개발 중      | `bin/rails db:migrate`     | 새로운 마이그레이션 실행                    |
| 새 팀원 합류 | `bin/rails db:schema:load` | 모든 마이그레이션 대신 스키마로 빠르게 복원 |
| DB 초기화    | `bin/rails db:reset`       | DB 삭제 → 재생성 → 스키마 로드 → seed 실행  |
| 구조 확인    | 파일 열람                  | 현재 DB 구조 파악 가능                      |

---

## 3️⃣ **seeds.rb** - 초기 데이터

**역할**: 개발/테스트용 샘플 데이터 생성

### 사용 예시

```ruby
# db/seeds.rb

# 관리자 사용자 생성
User.find_or_create_by!(login_id: 'admin') do |user|
  user.password = 'password'
  user.user_name = '관리자'
  user.role = :admin
end

# 일반 사용자 생성
User.find_or_create_by!(login_id: 'user') do |user|
  user.password = 'password'
  user.user_name = '일반사용자'
  user.role = :user
end

puts "✅ Seed 데이터가 성공적으로 생성되었습니다!"
```

### 실행 방법

```bash
bin/rails db:seed
```

### 💡 팁

- `find_or_create_by!`를 사용하면 중복 방지 가능
- **Idempotent** 하게 작성 (여러 번 실행해도 안전)

---

## 🔄 마이그레이션 워크플로우

### ✅ 올바른 DB 변경 순서

**1. 마이그레이션 파일 생성**

```bash
bin/rails g migration AddColumnToUsers
```

**2. 마이그레이션 파일 수정**

```ruby
# db/migrate/20260125100003_add_role_to_users.rb
class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer, default: 1, null: false
  end
end
```

**3. 마이그레이션 실행**

```bash
bin/rails db:migrate
```

**4. schema.rb 자동 갱신** ✨ (Rails가 자동으로 처리)

---

## 📋 주요 명령어 정리

### 마이그레이션 실행

```bash
# 실행되지 않은 마이그레이션 모두 실행
bin/rails db:migrate

# 특정 버전까지만 실행
bin/rails db:migrate VERSION=20260122065724

# 마이그레이션 실행 상태 확인
bin/rails db:migrate:status
```

### 마이그레이션 되돌리기

```bash
# 바로 직전 마이그레이션 되돌리기
bin/rails db:rollback

# 특정 횟수만큼 되돌리기
bin/rails db:rollback STEP=3

# 특정 마이그레이션 다시 실행 (되돌리기 + 재실행)
bin/rails db:migrate:redo

# 모든 마이그레이션 되돌리기 (⚠️ 주의! 데이터 삭제됨)
bin/rails db:migrate:reset
```

### 데이터베이스 관리

```bash
# DB 생성
bin/rails db:create

# DB 삭제
bin/rails db:drop

# DB 삭제 → 재생성 → 스키마 로드 → Seed 실행
bin/rails db:reset

# 스키마로 DB 구조 복원 (빠름!)
bin/rails db:schema:load

# Seed 데이터 투입
bin/rails db:seed

# DB 생성 + 스키마 로드 + Seed 실행 (초기 설정)
bin/rails db:setup
```

---

## ⚠️ 주의사항

### ❌ 절대 직접 수정하면 안 되는 파일

- ❌ `schema.rb` (마이그레이션으로만 변경)
- ❌ `structure.sql` (사용 시)

### ✅ 수정해도 되는 파일

- ✅ `migrate/` 폴더 안의 **새로운** 마이그레이션 파일
- ✅ `seeds.rb`

### 🚨 프로덕션 환경 주의

- **절대 `db:reset` 사용 금지!** (모든 데이터 삭제됨)
- **이미 배포된 마이그레이션은 수정하지 말 것**
- 변경이 필요하면 **새로운 마이그레이션 추가**

---

## 💡 핵심 개념 정리

### 마이그레이션의 장점

| 장점           | 설명                                         |
| -------------- | -------------------------------------------- |
| 📝 버전 관리   | Git으로 DB 변경 이력 추적                    |
| 👥 협업        | 팀원들이 같은 DB 구조 유지                   |
| ⏪ 롤백 가능   | 문제 발생 시 이전 상태로 복원                |
| 🌍 환경 독립적 | 개발/스테이징/프로덕션 모두 같은 코드로 관리 |

### schema.rb vs structure.sql

| 구분      | schema.rb         | structure.sql        |
| --------- | ----------------- | -------------------- |
| 형식      | Ruby DSL (추상적) | 실제 SQL 문          |
| 호환성    | DB 독립적         | DB별로 다름          |
| 사용 시점 | 일반적인 경우     | 고급 DB 기능 사용 시 |
| 가독성    | 높음              | 낮음 (SQL 지식 필요) |

---

## 🎯 실전 시나리오

### 시나리오 1: 새로운 컬럼 추가

```bash
# 1. 마이그레이션 생성
bin/rails g migration AddEmailToUsers email:string

# 2. 생성된 파일 확인 및 필요시 수정
# db/migrate/20260127_add_email_to_users.rb

# 3. 마이그레이션 실행
bin/rails db:migrate
```

### 시나리오 2: 새 팀원 프로젝트 세팅

```bash
# 1. 저장소 클론
git clone <repository>

# 2. 의존성 설치
bundle install

# 3. DB 생성 및 스키마 로드
bin/rails db:setup

# 또는 단계별로
bin/rails db:create
bin/rails db:schema:load
bin/rails db:seed
```

### 시나리오 3: 실수한 마이그레이션 취소

```bash
# 1. 마지막 마이그레이션 되돌리기
bin/rails db:rollback

# 2. 마이그레이션 파일 수정

# 3. 다시 실행
bin/rails db:migrate
```

---

## 📚 추가 학습 자료

- [Rails Guides - Migrations](https://guides.rubyonrails.org/active_record_migrations.html)
- [Rails Guides - Active Storage](https://guides.rubyonrails.org/active_storage_overview.html)
- [Rails API - Migration](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

---

**작성일**: 2026-01-27
**Rails 버전**: 8.1.2
**프로젝트**: TodoOnRails
