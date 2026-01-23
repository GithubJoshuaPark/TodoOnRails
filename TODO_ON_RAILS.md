# TODO_ON_RAILS.md

## 🚀 1단계: 프로젝트 생성 및 설치

첫 번째 단계로 Rails 프레임워크를 설치하고 프로젝트를 생성하겠습니다.

### 실행할 작업:

```bash
~/…/TodoOnRails $ which ruby && gem env home
/Users/soromiso/.rbenv/shims/ruby
/Users/soromiso/.rbenv/versions/3.3.4/lib/ruby/gems/3.3.0

~/…/TodoOnRails $ brew install mysql && echo "MySQL installed successfully"

gem install rails (Rails 설치)
rails new TodoOnRails -d mysql (MariaDB 기반 프로젝트 생성)
참고: Rails는 MariaDB 어댑터로 mysql2 젬을 공통으로 사용합니다.
```

### Implementation Idea

```bash
MacOS,
MariaDB local에 설치(docker desktop) 사용중이다.

1. Ruby on Rails Framework 를 이용하여 새로운 프로젝트 TodoOnRails 를 만들고 싶다.
2. 구현 할 기능
- 로그인 (ID/PWD)
- Intro Page
- TodoList
    . 상단 조회기능, "조회", "추가"
    . Table List,
    . 하단 [Pagination, Prev, 10 Rows per page, Next] )
    . "추가" 시 추가 팝업
    . Table List 에 조회된 특정 행 선택 시 수정용 팝업
- About Page

3. MariaDB  (todo database)
   - 생성할 테이블들의 DDL 구문 알려달라.

4. Ruby on Rails  Project 설치 부터, 구조적 프로젝트 소스구현을
    내가 따라할 수 있도록 단계별로 알려 달라.

5. 각 단계를 진행하기 전에 설명과 함께 나에게 진행여부를 반드시 물어봐 달라.
```

### 🚀 TodoOnRails 프로젝트 계획 (Ruby on Rails + MariaDB)

요청하신 TodoOnRails 프로젝트를 위한 단계별 계획을 수립했습니다.

📋 주요 내용
Framework: Ruby on Rails (최신 버전)
DB: MariaDB (Docker 연결)
UI: Hotwire(Turbo)를 이용한 SPA 느낌의 팝업/수정 구현
기능: 로그인, 투두 관리(CRUD, 페이징, 검색), 소개 페이지

### 🚀 1단계: 프로젝트 생성 및 설치

첫 번째 단계로 Rails 프레임워크를 설치하고 프로젝트를 생성하겠습니다.

실행할 작업:

gem install rails (Rails 설치)
rails new TodoOnRails -d mysql (MariaDB 기반 프로젝트 생성)
참고: Rails는 MariaDB 어댑터로 mysql2 젬을 공통으로 사용합니다.

### 🚀 bin/ 폴더에 있는 스크립트(실행 파일)들의 용도를 표로 정리했습니다. 이 파일들은 프로젝트 뿌리(Root)에서 bin/명령어 형태로 실행합니다.

| 파일명                  | 용도 및 설명                                                                                                 | 자주 쓰는 명령어 예시                                                                   |
| :---------------------- | :----------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- |
| **`rails`**             | **가장 중요!** Rails 프레임워크의 모든 기능을 실행하는 만능 명령어입니다. (서버 실행, 콘솔, 코드 생성 등)    | `bin/rails server` (서버 켜기)<br>`bin/rails console` (콘솔)<br>`bin/rails g model ...` |
| **`rake`**              | Ruby의 빌드 도구인 Rake 작업을 실행합니다. (DB 마이그레이션 등) Rails 명령어에 통합되어 요즘은 잘 안 씁니다. | `bin/rake db:migrate`<br>(`bin/rails db:migrate`와 동일)                                |
| **`setup`**             | 프로젝트 초기 세팅을 도와주는 스크립트입니다. DB 생성, 라이브러리 설치 등을 한 번에 해줍니다.                | `bin/setup`<br>(처음 프로젝트 받으면 딱 한 번 실행)                                     |
| **`dev`**               | 개발 서버를 실행하는 단축 명령어입니다. (보통 Procfile을 사용하는 Foreman 등을 실행하도록 커스텀됩니다.)     | `bin/dev`                                                                               |
| **`ci`**                | `config/ci.rb`에 정의된 **CI(테스트, 보안 점검)** 과정을 실행합니다.                                         | `bin/ci`                                                                                |
| **`rubocop`**           | Ruby 코드 스타일 검사기(Linter)를 실행합니다. 코드가 못생겼는지 검사해줍니다.                                | `bin/rubocop`                                                                           |
| **`brakeman`**          | Rails 보안 취약점 정적 분석 도구를 실행합니다.                                                               | `bin/brakeman`                                                                          |
| **`bundler-audit`**     | 사용하는 젬(Gem)들의 보안 취약점을 검사합니다.                                                               | `bin/bundler-audit`                                                                     |
| **`docker-entrypoint`** | Docker 컨테이너가 실행될 때 맨 처음 실행되는 진입점 스크립트입니다. (우리가 직접 실행할 일은 없음)           | (Docker가 자동 실행)                                                                    |
| **`thrust`**            | Puma 웹 서버 앞단에서 정적 파일을 빠르게 서빙해주는 가속기(Thruster)를 실행합니다.                           | (배포 시 자동 실행)                                                                     |

### 🚀 서버 실행 방법

브라우저에서 확인하기 위해 서버를 실행하는 방법은 두 가지가 있습니다. 편한 것을 골라서 사용하시면 됩니다.

터미널을 열고 프로젝트 폴더(TodoOnRails)에서 아래 명령어 중 하나를 입력하세요.

1. 표준 실행 방법 (추천)

```bash
# rbenv를 현재 쉘에 적용
eval "$(rbenv init - zsh)"
# 다시 버전 확인
ruby -v

bin/rails server
# 또는 짧게 bin/rails s 라고 쳐도 됩니다.
# 가장 기본적이고 확실한 방법입니다.
```

2. 개발용 단축 명령어

```bash
bin/dev
```

이 명령어는 Foreman을 실행하여 개발 서버를 시작합니다.
