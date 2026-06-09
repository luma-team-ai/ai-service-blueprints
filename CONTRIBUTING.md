# AI Service Blueprints 기여 가이드

## 시작하기

이 저장소는 특정 에이전트나 IDE에 종속되지 않습니다. 작업 전에는 다음 문서를 순서대로 확인합니다.

1. [`README.md`](README.md): 저장소와 프로젝트 인덱스.
2. [`_workspace-docs/README.md`](_workspace-docs/README.md): 문서 구조, 주제 승격, 문서별 소유권과 추적성 규칙.
3. [`_workspace-docs/decisions.md`](_workspace-docs/decisions.md): 저장소 전체 구조에 영향을 주는 합의와 재검토 조건.
4. 대상 프로젝트의 `README.md`, `docs/README.md`, 관련 주제 문서.
5. 새 프로젝트 주제 발굴은 [`_workspace-docs/topic-brainstorming.md`](_workspace-docs/topic-brainstorming.md).

상세 규칙을 이 파일에 반복하지 않습니다. 문서 작성과 구현 준비 기준은 공용 문서 표준을 기준으로 합니다.

## 저장소 독립성

- 저장소 내부 링크는 상대 경로를 사용합니다.
- 문서와 스크립트에 특정 사용자명, 드라이브, 홈 디렉터리, clone 위치를 넣지 않습니다.
- 사용자별 에이전트 지침, IDE 설정, 비밀값, 로컬 캐시는 커밋하지 않습니다.
- 저장소는 자동 탐색형 `AGENTS.md` 또는 `AGENTS.override.md`를 제공하지 않습니다.
- 로컬 에이전트 지침을 의도적으로 사용할 때만 `.git/info/exclude`에 `/AGENTS.md` 또는 `/AGENTS.override.md`를 추가합니다.
- 로컬 자동 지침 파일을 추가하거나 제거한 뒤에는 에이전트가 지침 체인을 다시 구성하도록 새 세션을 시작합니다.
- 에이전트를 사용할 때는 공용 문서 표준과 대상 프로젝트 문서를 명시적으로 컨텍스트에 포함합니다.

## 변경 원칙

- 프로젝트 파일을 다른 프로젝트 디렉터리에 섞지 않습니다.
- 새 프로젝트는 저장소 루트 아래의 형제 디렉터리로 추가합니다.
- 이 저장소에서 제품 프로젝트 디렉터리는 루트 `README.md`에 등록되고 `README.md`, `docs/README.md`, `docs/prd.md`를 함께 가진 최상위 디렉터리입니다.
- 루트 프로젝트 표를 수정할 때 `project-index` 주석 마커를 유지합니다.
- `assets/`, `examples/`, `tools/` 같은 공용 디렉터리는 프로젝트로 간주하지 않으며 필요한 진입 문서를 자체적으로 둡니다.
- 후보, PRD, 기능, 설계 문서 사이의 ID와 상대 링크를 유지합니다.
- 공용 규칙은 [`_workspace-docs/README.md`](_workspace-docs/README.md), 프로젝트별 결정은 해당 프로젝트 문서에서 변경합니다.
- 구조를 바꾼 뒤에는 검증 스크립트를 실행합니다.

## 검증

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/validate-workspace.ps1
```

PowerShell Core:

```powershell
pwsh -File scripts/validate-workspace.ps1
```

스크립트는 자신의 위치에서 저장소 루트를 계산하므로 clone 위치나 현재 작업 디렉터리에 의존하지 않습니다.
