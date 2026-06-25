# AI Service Blueprints

프로젝트, 공용 문서 표준, 재사용 가능한 기획/설계 템플릿을 모아두는 한국어 워크스페이스입니다.

이 `README.md`는 프로젝트와 공용 문서의 진입점입니다.

## 구성

| 경로 | 역할 |
| --- | --- |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | 기여자가 따라갈 도구 중립적인 문서 진입점. |
| [`_workspace-docs/README.md`](_workspace-docs/README.md) | 모든 프로젝트에 적용하는 문서 작성 표준. |
| [`_workspace-docs/decisions.md`](_workspace-docs/decisions.md) | 저장소 전체에 영향을 주는 구조·운영 합의 기록. |
| [`_workspace-docs/topic-brainstorming.md`](_workspace-docs/topic-brainstorming.md) | 포트폴리오용 프로젝트 주제 후보와 보류·배제 이력. |
| [`_workspace-docs/prd-writing.md`](_workspace-docs/prd-writing.md) | 공용 PRD 작성법을 개선하는 절차. |
| [`_workspace-docs/templates/`](_workspace-docs/templates) | 주제 발굴, PRD, 핵심 기능, 아키텍처, 백엔드, 데이터 모델, API, 일반 문서 템플릿. |
| [`scripts/validate-workspace.ps1`](scripts/validate-workspace.ps1) | 워크스페이스 문서 구조 검증 스크립트. |

<!-- project-index:start -->
## 현재 프로젝트

| 프로젝트 | 설명 | 진입점 |
| --- | --- | --- |
| `dopacheck` | 배달 지출·SNS 시간 소비를 분석해 도파민 점수를 산출하는 Flask 앱. | [`dopacheck/README.md`](dopacheck/README.md) |
<!-- project-index:end -->

> `review-sentiment`(NSMC 감성 분석 ML 과제)는 별도 단일 레포로 분리·이관되었습니다 → [Ketose333/review-sentiment](https://github.com/Ketose333/review-sentiment)
>
> `music-mood-recs`(음악 무드 분류+추천 DL 과제)는 이 레포 바깥의 형제 디렉터리 `../music-mood-recs`에서 별도 레포로 관리됩니다. 후보 평가·승격 근거는 [`_workspace-docs/topic-brainstorming.md`](_workspace-docs/topic-brainstorming.md#t-026-음악-무드-분류-및-콘텐츠-기반-추천)에 있습니다.

## 저장소 독립성

- 저장소는 특정 사용자명, 드라이브, clone 경로를 전제로 하지 않습니다.
- 내부 문서와 프로젝트 연결은 상대 경로를 사용합니다.
- 저장소는 자동 탐색형 에이전트 지침 파일을 제공하지 않습니다.
- 에이전트를 사용할 때는 [`CONTRIBUTING.md`](CONTRIBUTING.md), 공용 문서 표준, 대상 프로젝트 문서를 명시적으로 컨텍스트에 포함합니다.
- 사용자별 `AGENTS.md`와 `AGENTS.override.md`는 로컬에서 사용할 수 있지만 저장소의 공유 `.gitignore`로 숨기지 않습니다.
- 로컬 지침 파일을 의도적으로 사용하는 사용자는 자신의 `.git/info/exclude`에 `/AGENTS.md` 또는 `/AGENTS.override.md`를 추가합니다.

## 포트폴리오 맥락

주제 발굴 시 저장소에 등록된 프로젝트뿐 아니라 다음 기존 프로젝트도 중복 비교 대상으로 사용합니다. review-sentiment는 Mooditree의 발전형 프로젝트로, 동일 감정 도메인을 UI 중심에서 ML 중심으로 확장합니다.

| 프로젝트 | 상태 | 주제 발굴 시 고려할 영역 |
| --- | --- | --- |
| 취업 준비 영역 | 기존 프로젝트, 이 저장소에는 미등록(레거시 종료) | 취업 준비, 자기소개서·이력서, 직무 매칭, 면접 연습. |
| MeetingHub | 기존 프로젝트, 이 저장소에는 미등록 | 회의록 수집·요약·분석, 회의 후속 작업. |
| Mooditree | 기존 포트폴리오 프로젝트, 이 저장소에는 미등록 | 감정 기록 기반 콘텐츠 추천 UI (review-sentiment 원천 연결). |

새 프로젝트 후보, 평가 기준, 보류·배제 사유는 [`_workspace-docs/topic-brainstorming.md`](_workspace-docs/topic-brainstorming.md)에서 관리합니다.

## 기획 수립 흐름

주제 발굴부터 구현 준비까지 다음 한 흐름을 사용합니다. 단계별 상세 기준과 문서 소유권은 [`_workspace-docs/README.md`](_workspace-docs/README.md)에 있습니다.

1. **포트폴리오 기준선**: 기존 프로젝트가 보여주는 문제 영역과 기술 역량을 확인합니다.
2. **후보 발굴**: `_workspace-docs/topic-brainstorming.md`에 사용자 문제, 핵심 흐름, 전달 방식, 기술적 증거를 기록합니다.
3. **비교와 검증**: 중복, 데이터 접근성, 외부 API, MVP 규모, 목표 직무 적합성을 비교합니다.
4. **선택 또는 보관**: 후보를 `Selected`, `Parked`, `Rejected`, `Merged` 중 하나로 결정하고 근거를 남깁니다.
5. **프로젝트 승격**: 선택된 후보로 `<project>/README.md`, `<project>/docs/README.md`, `<project>/docs/prd.md`를 만들고 양방향 링크를 둡니다.
6. **제품 구체화**: `docs/features.md`에서 PRD 요구사항을 기능, 입력, 출력, 상태, 인수 조건으로 풉니다.
7. **구현 설계**: 필요한 경우 `docs/architecture.md`, `docs/backend.md`, `docs/data-model.md`, `docs/api.md`를 작성합니다.
8. **정합성 검증**: 요구사항 ID, 기능 ID, API 필드, 데이터 모델, 링크를 점검하고 검증 스크립트를 실행합니다.

## 시각화 기본값

- Markdown 안에서는 Mermaid를 기본 다이어그램 형식으로 사용합니다.
- 복잡한 관계형 스키마에는 DBML을 보조 산출물로 사용할 수 있습니다.
- 구현 단계의 REST API 계약에는 OpenAPI를 보조 산출물로 사용할 수 있습니다.
- 다이어그램은 설명하는 결정, 흐름, 계약 가까이에 둡니다.

## 언어 기준

- 사람용 문서와 템플릿 설명은 한국어를 기본으로 작성합니다.
- 코드 식별자, 파일명, 표준명, 외부 스펙명은 필요한 경우 영어를 유지합니다.
- 사용자에게 노출되는 제품 문구는 프로젝트 맥락에 맞는 자연스러운 한국어를 우선합니다.

## 검증

문서 구조를 바꾼 뒤에는 다음 명령을 실행합니다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/validate-workspace.ps1
```

PowerShell Core 환경에서는 다음 명령을 사용합니다.

```powershell
pwsh -File scripts/validate-workspace.ps1
```

## README의 역할

- `README.md` 파일은 사람이 읽는 진입점과 문서 인덱스입니다.
- 상세 문서는 각 프로젝트의 `docs/` 디렉터리에 둡니다.
