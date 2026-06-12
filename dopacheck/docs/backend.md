# dopacheck 백엔드 구현 가이드

## 0. 문서 메타데이터

| 항목 | 값 |
| --- | --- |
| 상태 | Active |
| 담당자 | 김관영 (Flask 총괄) |
| 마지막 업데이트 | 2026-06-13 |
| 배경 | Supabase → CloudType MariaDB 마이그레이션 |

> 마이그레이션·라우트 구현(auth/db/history/report/delivery)은 완료되어 해당 절차·체크리스트 섹션은 정리했다.
> 이 문서는 이후 신규 라우트·유지보수 시 재사용할 **공통 패턴**만 남긴다.

---

## 1. 마이그레이션 개요

| 항목 | 기존 (Supabase) | 변경 (MariaDB) |
| --- | --- | --- |
| DB 클라이언트 | `supabase-py` (`get_supabase()`) | `PyMySQL` (`db()` 컨텍스트 매니저) |
| 인증 | Supabase Auth | Authlib + Flask 세션 |
| 사용자 ID 타입 | UUID 문자열 | BIGINT (int) |
| 데이터 격리 | RLS 정책 (DB 레벨) | 모든 쿼리에 `WHERE user_id = %s` 직접 추가 |
| 세션 키 | `session["user"]["id"]` | `session["user_id"]` |

---

## 2. 환경변수 체크리스트

`.env`에 모두 있어야 앱이 뜬다.

```
# DB
DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD

# OAuth
GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, GOOGLE_REDIRECT_URI
KAKAO_CLIENT_ID, KAKAO_REDIRECT_URI   ← 현재 Kakao는 오류로 미사용

# Flask
FLASK_SECRET_KEY

# AI
ANTHROPIC_API_KEY
```

---

## 3. 공통 패턴 요약

### 세션 키 규약

| 키 | 타입 | 설명 |
| --- | --- | --- |
| `session["user_id"]` | `int` | MariaDB `users.id` (BIGINT) |
| `session["nickname"]` | `str` | 표시 이름 |
| `session["email"]` | `str` | 이메일 |

### 라우트 기본 구조

```python
from flask import Blueprint, session, render_template
from db.client import db
from routes.auth import login_required

bp = Blueprint("xxx", __name__, url_prefix="/xxx")

@bp.route("/")
@login_required
def page():
    user_id = session["user_id"]   # 항상 int
    with db() as cursor:
        cursor.execute("SELECT ... WHERE user_id = %s", (user_id,))
        rows = cursor.fetchall()
    return render_template("xxx/index.html", rows=rows)
```

### DB 접근 규약

- 모든 DB 접근은 `db.client.db()` 컨텍스트 매니저를 통한다 (라우트에서 `pymysql.connect` 직접 호출 금지).
- 정상 종료 시 commit, 예외 시 rollback, 항상 close.
- RLS 없음 — 모든 조회는 앱에서 `WHERE user_id = %s` 로 스코프한다.
