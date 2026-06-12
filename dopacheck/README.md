# dopacheck

Flask 기반 도파민 소비 체크 앱. 배달 지출·SNS 시간 소비를 분석하고 도파민 점수를 산출한다.

| 항목 | 값 |
| --- | --- |
| 스택 | Python 3.x · Flask · PyMySQL · Authlib · Gunicorn |
| DB | MariaDB (CloudType) |
| 인증 | Google OAuth 2.0 (Kakao 오류로 보류) |
| 로컬 저장소 | `C:\AGENTS\dopacheck` |

## 문서

| 문서 | 내용 |
| --- | --- |
| [`docs/backend.md`](docs/backend.md) | Flask 구현 가이드 — Supabase→MariaDB 마이그레이션 체크리스트 · 공통 패턴 · 라우트별 노트 |
