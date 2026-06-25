# PRD 작성법 개선하기

## 목적

이 문서는 여러 프로젝트에 공통으로 적용할 PRD 작성법을 개선하는 방법을 정의합니다.

목표는 특정 프로젝트 PRD 하나를 먼저 고치는 것이 아닙니다. 여러 프로젝트의 `docs/prd.md`에 반복해서 적용할 수 있는 출처 기반 PRD 작성법을 키우는 것입니다. 더 좋은 섹션, 더 분명한 품질 기준, 더 강한 리뷰 프롬프트, 더 나은 예시를 축적합니다.

## 기준 문서

- 워크스페이스 PRD 작성 규칙은 `_workspace-docs/README.md`에 있습니다.
- 재사용 가능한 PRD 템플릿은 `_workspace-docs/templates/prd.md`에 있습니다.
- 프로젝트 PRD는 각 프로젝트의 `docs/prd.md`에 있습니다.
- 외부 조사 도구는 조사와 종합을 위한 작업 공간이며 canonical 저장소가 아닙니다.
- 채택한 변경은 이 저장소에 반영합니다.
- 별도 `career` 저장소의 `portfolio/02-ml-sample-reports/`에 실제 ML/DL/웹 프로젝트 보고서 샘플과 WBS 샘플이 있습니다. 섹션 구성과 상세도 수준을 참고할 때 사용하며, 그대로 복사하지 않습니다.

## 조사 환경 설정

다음 이름으로 조사 문서를 하나 만듭니다.

```text
Workspace PRD Writing System
```

먼저 다음 로컬 소스를 추가합니다.

- `_workspace-docs/README.md`
- `_workspace-docs/templates/prd.md`
- `_workspace-docs/templates/docs.md`
- 대표 프로젝트 PRD 한두 개. 예: `dopacheck/docs/prd.md`

다음 노트를 만듭니다.

- `Source Intake`: 후보 외부 소스와 중요 이유.
- `PRD Principles`: 소스에서 추출한 재사용 가능한 작성 원칙.
- `PRD Quality Checklist`: 모든 프로젝트에 적용할 리뷰 체크.
- `Template Change Requests`: 로컬에 반영할 변경 제안.

## 소스 확장 요청

PRD 작성법 소스를 확장할 때 조사 도구에 다음 요청을 사용합니다.

```text
이 조사 문서의 기존 소스는 우리 문서 저장소의 PRD 작성 규칙과 템플릿이야.
특정 프로젝트 PRD를 바로 고치는 것이 아니라, 앞으로 여러 프로젝트에 반복해서 쓸 “PRD 작성 요령”을 키우기 위한 웹 소스를 찾아줘.

목표:
- 좋은 PRD의 목적, 필수 섹션, 품질 기준, 흔한 실패 패턴을 정리하기
- Agile/Lean 환경에서 PRD가 과도한 명세서가 아니라 의사결정 기준과 정렬 도구가 되게 하는 원칙 찾기
- MVP 범위, 제외 범위, 성공 지표, 가정, 리스크, 오픈 이슈, 요구사항 검증 기준을 더 잘 쓰는 방법 찾기
- 우리 템플릿 `_workspace-docs/templates/prd.md`에 반영할 수 있는 개선점 찾기

소스 우선순위:
1. 제품 관리 도구/방법론의 공식 가이드나 템플릿
2. 요구사항 작성, Agile requirements, product discovery 관련 권위 있는 자료
3. 실무 템플릿은 좋지만, 홍보성/얕은 글은 낮은 우선순위로 분류
4. Reddit, 개인 블로그, 무출처 글은 참고 후보로만 분류하고 템플릿 변경 근거로는 쓰지 마

각 후보 소스마다 다음 형식으로 정리해줘:
- 제목:
- URL:
- 발행/운영 주체:
- 날짜 또는 최신성:
- 신뢰도: 높음/중간/낮음
- PRD 작성법에 주는 교훈:
- 우리 템플릿 또는 표준에 반영할 수 있는 항목:
- 주의할 점:

마지막에는 “소스로 추가할 후보 7개”와 “보류할 후보”를 나눠줘.
```

## 집중 후속 요청

조사 도구의 소스 검색이 너무 넓을 때 사용합니다.

```text
Agile 환경에서 PRD를 “살아 있는 정렬 문서”로 쓰는 방법에 집중해서 권위 있는 소스 후보를 찾아줘. 특히 너무 상세한 선행 명세, 변경되지 않는 문서, 팀 참여 없는 PRD 작성 같은 실패 패턴을 정리해줘.
```

```text
PRD의 MVP 범위, 제외 범위, 성공 지표, 가정, 리스크, 오픈 이슈를 잘 쓰기 위한 소스 후보를 찾아줘. 템플릿 섹션 개선으로 이어질 수 있게 정리해줘.
```

```text
요구사항을 검증 가능하게 쓰는 방법에 대한 소스 후보를 찾아줘. acceptance criteria, measurable requirement, traceability, owner, validation plan 같은 관점을 PRD 작성 요령으로 반영하고 싶어.
```

```text
AI가 PRD 작성을 도울 때 생길 수 있는 문제를 줄이기 위한 작성 원칙을 찾아줘. 예를 들어 과도한 기능 확장, 근거 없는 시장 주장, 개인정보/안전 요구사항 누락, 합의되지 않은 구현 세부사항을 PRD에 넣는 문제를 막고 싶어.
```

## 로컬 변경 요청 정리

선별한 소스를 추가한 뒤, 로컬 변경 요청 묶음을 정리합니다.

```text
새로 추가한 PRD 작성법 관련 웹 소스들을 기존 워크스페이스 소스와 비교해서, 로컬 저장소에 반영할 변경 요청을 만들어줘.

규칙:
- 특정 프로젝트 PRD를 바로 고치지 말고, 공용 PRD 작성법과 템플릿 개선에 집중해줘.
- 변경 대상은 주로 `_workspace-docs/README.md`와 `_workspace-docs/templates/prd.md`야.
- 각 제안은 소스 근거와 연결해줘.
- 근거가 약하거나 우리 구조와 충돌하는 제안은 “보류”로 분류해줘.

출력 형식:
1. 추가한 소스 목록
   - 제목:
   - URL:
   - 핵심 근거:

2. 공용 표준 변경 요청
   - 파일: _workspace-docs/README.md
   - 섹션:
   - 이유:
   - 소스 근거:
   - 제안 수정안:

3. PRD 템플릿 변경 요청
   - 파일: _workspace-docs/templates/prd.md
   - 섹션:
   - 이유:
   - 소스 근거:
   - 제안 수정안:

4. 보류할 제안
   - 제안:
   - 보류 이유:
```

## 소스 평가 기준

다음 중 하나 이상을 개선하는 소스를 우선합니다.

- PRD 목적: 문서가 왜 존재하고 누가 사용하는가.
- 의사결정 품질: 목표, 트레이드오프, 가정, 열린 질문, 리스크.
- 범위 통제: MVP, next, future, 명시적 제외 범위.
- 요구사항 명확성: 테스트 가능한 요구사항, 인수 조건, 측정 가능한 결과.
- 팀 정렬: 협업, 소유권, 상태, 이해관계자, 변경 이력.
- 근거 품질: 사용자 조사, 시장 근거, 출처 링크, 확신 수준.
- 유지보수성: 얼어붙은 과잉 명세가 아니라 간결한 살아있는 문서.

## 로컬 반영 규칙

변경 제안이 나오면 다음 순서로 반영합니다.

1. 일반 작성법 개선은 `_workspace-docs/README.md`에 반영합니다.
2. 재사용 가능한 구조 변경은 `_workspace-docs/templates/prd.md`에 반영합니다.
3. 프로젝트별 인사이트는 대상 프로젝트 PRD를 고른 뒤에만 반영합니다.
4. 특정 섹션이 의사결정을 개선한다는 근거가 있을 때만 프로젝트 PRD를 확장합니다.
5. 소스가 규칙이나 템플릿 섹션을 실질적으로 바꾸면 출처 링크를 추가합니다.

## 시작 소스 범주

처음 찾기 좋은 소스 범주:

- Agile 제품 요구사항 가이드.
- 제품 관리 도구의 PRD 템플릿.
- 측정 가능하고 테스트 가능한 요구사항에 대한 요구공학 자료.
- Product discovery와 사용자 조사 자료.
- 명확성, 소유권, 유지보수성을 다루는 문서 스타일 가이드.

템플릿을 자동으로 정답 취급하지 않습니다. 원칙을 추출한 뒤 이 워크스페이스에 맞게 조정합니다.

## 초기 후보 소스

신호가 강한 소스를 몇 개 먼저 추가한 뒤, 인접 소스를 추가로 찾습니다.

| 소스 | URL | 도움이 되는 이유 |
| --- | --- | --- |
| Atlassian PRD guide | https://www.atlassian.com/agile/requirements | Agile 환경의 PRD 원칙, 안티패턴, 협업, 가정, "충분한 만큼의 요구사항" 관점을 얻을 수 있습니다. |
| Atlassian product requirements template | https://www.atlassian.com/software/confluence/templates/product-requirements | 실무적인 섹션 구조와 출시 준비 관점을 참고할 수 있습니다. |
| Productboard PRD glossary | https://www.productboard.com/glossary/product-requirements-document | PRD의 목적과 협업 용도를 간결하게 정의하는 데 도움이 됩니다. |
| Aha! PRD template guide | https://www.aha.io/roadmapping/guide/requirements-management/what-is-a-good-product-requirements-document-template | 제품 관리 관점의 템플릿 구성과 요구사항 정리 방식을 참고할 수 있습니다. |
| Jama PRD guide | https://www.jamasoftware.com/requirements-management-guide/writing-requirements/product-requirements-document/ | 측정 가능하고 추적 가능하며 검증 중심인 요구사항 작성에 유용합니다. |

이 소스들을 추가한 뒤, 로컬 템플릿을 바꾸기 전에 소스 간 합의점, 충돌점, 빈틈을 먼저 정리합니다.
