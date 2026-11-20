# 뜨란채113동

GitHub Pages에 게시하는 공동 달력입니다. Supabase 공개 데이터베이스를 사용하므로 별도 로그인 없이 누구나 내역을 보고 추가·삭제할 수 있습니다.

## 공동 달력 설정

1. Supabase에서 프로젝트를 만듭니다.
2. Supabase **SQL Editor**에서 [supabase-schema.sql](./supabase-schema.sql) 내용을 한 번 실행합니다. 새 `shared_calendar_entries` 테이블을 만들며, 기존 `calendar_entries` 테이블은 사용하거나 변경하지 않습니다.
3. Supabase **Project Settings → API**에서 **Project URL**과 **Publishable key** 또는 레거시 **anon key**를 확인합니다.
4. [GitHub Pages에 게시하기](#github-pages에-게시하기) 순서대로 파일을 게시하고 HTTPS 사이트 주소를 엽니다.
5. 처음 한 번 Project URL과 공개 키를 입력해 공동 달력에 연결합니다.
6. 달력 위쪽의 **공유 링크 복사**를 눌러 그 링크를 다른 분들에게 보냅니다. 공유 링크에는 공개용 키가 포함되며, 링크를 받은 사람은 로그인 없이 사용할 수 있습니다.

브라우저에는 **Publishable/anon 공개 키만** 사용하세요. `service_role` 또는 Secret key는 입력하지 마세요. 데이터베이스 정책이 의도적으로 익명 사용자에게 읽기·추가·수정·삭제 권한을 줍니다.

## GitHub Pages에 게시하기

1. `index.html`, `supabase-schema.sql`, `README.md`를 GitHub 저장소에 올립니다.
2. 저장소의 **Settings → Pages**로 이동합니다.
3. **Build and deployment**에서 **Deploy from a branch**를 선택합니다.
4. 기본 브랜치와 `/(root)` 폴더를 선택하고 저장합니다.
5. Pages 설정에 표시되는 HTTPS 사이트 주소로 접속합니다.

## 사용 및 저장

- 날짜를 누르면 해당 날짜의 내역 창과 내역 추가 기능을 사용할 수 있습니다.
- 달력 아래에서 해당 월의 전체 내역을 날짜순으로 볼 수 있습니다.
- 공동 내역은 Supabase에 저장되며, 접속 중인 사람들의 화면에 변경사항이 실시간 반영됩니다.
- 기존 브라우저에만 저장되어 있던 내역은 연결 후 **기존 내역 함께 가져오기** 버튼으로 옮길 수 있습니다. 원래 브라우저 데이터는 삭제되지 않습니다.
- `file://`에서 쓰던 브라우저 내역을 GitHub Pages로 옮길 때는 기존 파일 화면에서 백업을 다운로드한 뒤, 공동 달력의 **백업 파일 가져오기**로 올립니다.

## 공개 범위 안내

이 방식은 비밀번호가 없으며, 웹사이트 주소와 공유 링크를 아는 누구나 공동 내역 전체를 읽고 추가·수정·삭제할 수 있습니다. 링크는 온라인에 공개된 것으로 취급하고, 개인 정보나 민감한 내용은 기록하지 마세요. 데이터베이스에서 삭제된 내역은 복구할 수 없습니다.
