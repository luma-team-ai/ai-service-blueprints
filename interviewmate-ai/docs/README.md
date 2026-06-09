# InterviewMate AI 문서

## 목적

이 디렉터리는 InterviewMate AI의 기획, 발표, AI 프롬프트 문서를 보관합니다.

## 문서 목록

| 문서 | 상태 | 역할 |
| --- | --- | --- |
| [`prd.md`](prd.md) | Active | 제품 요구사항과 의사결정 기준선. |
| [`prototype.md`](prototype.md) | Active | 첫 Google AI Studio 프로토타입 프롬프트와 후속 프롬프트. |
| [`architecture.md`](architecture.md) | Active | 아키텍처 발표 대본. |

## 형식 규칙

[`../../_workspace-docs/README.md`](../../_workspace-docs/README.md)의 워크스페이스 표준을 따릅니다.

프로젝트 규칙:

- 프롬프트는 UI 코드에 흩어두지 말고 문서로 버전 관리합니다.
- UX 문구와 제품 예시는 한국어를 사용합니다.
- 교체되는 문서는 삭제 전에 `archive/YYYY-MM-DD-topic.md`에 보관합니다.
- `../README.md`는 프로젝트 진입점으로, 이 파일은 docs 인덱스로 사용합니다.

## 향후 문서

- `features.md`: 구현 전 PRD 범위를 기능별 요구사항으로 풀어낼 때 추가합니다.
- `backend.md`: 백엔드 구현 전 모듈, 인증/권한, 요청 생명주기, 외부 연동, 운영 기준을 정의할 때 추가합니다.
- `data-model.md`: 영속 데이터가 필요해질 때 ERD, 엔티티, 관계, 보존 정책, 접근 규칙을 정의합니다.
- `api.md`: API 구현 전 엔드포인트 계약, 요청/응답 스키마, 에러, 계약 테스트를 정의합니다.
- `architecture-notes.md`: 발표 대본을 넘어 구현 아키텍처가 바뀔 때 추가합니다.
