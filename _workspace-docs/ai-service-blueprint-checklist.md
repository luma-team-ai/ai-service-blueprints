# 고급 AI 서비스 설계 체크리스트

## 목적

이 문서는 기본 템플릿인 `architecture.md`, `backend.md`, `data-model.md`, `api.md`를 작성할 때 프로젝트 성격에 따라 추가로 검토할 수 있는 고급 AI 아키텍처 질문을 모아둡니다.

모든 AI 프로젝트에 이 항목들이 필요한 것은 아닙니다. 프로젝트 요구사항에 해당하는 항목만 취사선택하고, 결정한 내용은 해당 프로젝트의 관련 문서에 기록합니다.

## 사용 방법

1. PRD와 기능 범위를 먼저 확인합니다.
2. 이 체크리스트에서 프로젝트에 해당하는 질문만 고릅니다.
3. 선택한 항목은 `docs/architecture.md`, `docs/backend.md`, `docs/data-model.md`, `docs/api.md` 중 가장 가까운 문서에 반영합니다.
4. 아직 결정하지 못한 항목은 강제로 채우지 말고 열린 질문으로 남깁니다.

## 1. RAG와 데이터 파이프라인

해당 시 반영 문서: `docs/architecture.md`, `docs/backend.md`, `docs/data-model.md`

| 질문 | 기록할 내용 |
| --- | --- |
| 단순 벡터 검색을 넘어 HyDE, 하이브리드 검색, 계층적 검색, 문맥 보존형 청킹이 필요한가? | 검색 전략, 선택 이유, 재검토 시점 |
| 원천 문서의 청킹, 메타데이터, 권한 필터링, 버전 관리가 필요한가? | 인덱싱 규칙, 민감 데이터 처리, 접근 제어 |
| 실시간 또는 증분 인덱싱이 필요한가? | 트리거, 실패 처리, 재처리 방식 |
| 검색 결과의 출처, 신뢰도, 재현성을 사용자나 운영자가 확인해야 하는가? | citation, audit metadata, 평가 기준 |

## 2. 도구 호출과 외부 시스템 연동

해당 시 반영 문서: `docs/architecture.md`, `docs/backend.md`, `docs/api.md`

| 질문 | 기록할 내용 |
| --- | --- |
| LLM 또는 자동화 흐름이 외부 도구, 내부 API, 파일, 데이터베이스에 접근해야 하는가? | 도구 목록, 권한 범위, 입력/출력 계약 |
| MCP(Model Context Protocol) 같은 표준 도구 호출 계층이 필요한가? | MCP 서버 책임, 클라이언트 경계, 보안 제한 |
| 도구 호출 통신이 로컬 `stdio`인지 원격 `SSE` 또는 HTTP인지 결정해야 하는가? | 전송 방식, 배포 위치, 인증 방식 |
| 도구 호출 실패, 지연, 부분 성공을 사용자 경험에 어떻게 반영해야 하는가? | timeout, retry, fallback, 사용자 메시지 |

## 3. 자동화 워크플로우와 런타임

해당 시 반영 문서: `docs/architecture.md`, `docs/backend.md`

| 질문 | 기록할 내용 |
| --- | --- |
| 단일 모델 호출이 아니라 여러 단계의 자동화 워크플로우가 필요한가? | 단계, 상태, 종료 조건, 실패 동작 |
| LangGraph, CrewAI 같은 오케스트레이션 프레임워크를 쓸 이유가 있는가? | 선택한 도구, 검토한 대안, 잠금 효과 |
| 자동화 실행을 컨테이너나 격리된 작업 공간 단위로 관리해야 하는가? | 격리 범위, 리소스 제한, 보안 경계 |
| Kubernetes 같은 오케스트레이션 환경과 선언적 YAML 실행 명세가 필요한가? | 배포 단위, 스케일링 기준, 운영 책임 |
| 사용자 여정을 Aware, Join, Use, Leave 같은 단계로 나누어 세션 종료와 리소스 반환까지 설계해야 하는가? | 단계별 책임, 종료 조건, 정산 또는 정리 작업 |

## 4. 모델 선택과 대화 이력

해당 시 반영 문서: `docs/architecture.md`, `docs/backend.md`, `docs/data-model.md`

| 질문 | 기록할 내용 |
| --- | --- |
| OpenAI, Anthropic, Google Gemini 등 여러 모델 제공자를 교체 가능하게 추상화해야 하는가? | provider interface, 모델 선택 기준, fallback |
| 대화 이력을 데이터베이스에 영구 저장할지, 플랫폼 API thread에 맡길지, 무상태로 둘지 결정했는가? | `local_text`, `api`, `none` 중 선택과 이유 |
| 모델 입력과 출력의 원문을 어디까지 저장해야 하는가? | 보존 기간, 마스킹, 디버깅 범위 |
| 구조화 출력이 필요한가? | JSON schema, validation, 실패 시 복구 |

## 5. 안정성, 보안, FinOps

해당 시 반영 문서: `docs/backend.md`, `docs/architecture.md`

| 질문 | 기록할 내용 |
| --- | --- |
| 모델 호출이나 도구 호출에 최대 반복 횟수, 최대 실행 시간, 토큰 예산이 필요한가? | iteration cap, timeout, token budget |
| 외부 모델 API 장애에 대비한 자동 재시도와 서킷 브레이커가 필요한가? | retry policy, circuit breaker, fallback |
| 프롬프트 인젝션, PII 유출, 권한 초과 도구 호출을 막기 위한 가드레일이 필요한가? | 정책 파일, 검사 시점, 차단 또는 경고 동작 |
| `agent.guard.yml` 같은 설정 파일로 권한, 예산, 금지 동작을 선언해야 하는가? | 설정 스키마, 소유자, 변경 승인 |
| 운영 비용과 지연 시간을 사전에 추정해야 하는가? | 입력/출력 토큰, 모델 단가, 인프라 비용, p95 latency |

예측식이 필요할 때는 프로젝트 맥락에 맞게 단순한 형태부터 시작합니다.

```text
O_cost = input_tokens * input_price + output_tokens * output_price + infra_cost + tool_cost
L_total = queue_latency + retrieval_latency + tool_latency + model_latency + postprocess_latency
```

## 6. 특수 목적 신뢰 인프라

해당 시 반영 문서: `docs/architecture.md`, `docs/backend.md`

| 질문 | 기록할 내용 |
| --- | --- |
| 다중 자동화 주체 간 신원, 평판, 작업 보증, 결제가 제품 요구사항인가? | 신뢰 모델, 행위자, 정산 흐름 |
| 온체인 레지스트리나 ERC-8004 같은 외부 프로토콜 검토가 필요한가? | 도입 이유, 대안, 보안과 비용 리스크 |
| 블록체인 연동이 MVP 검증에 필요한가, 아니면 향후 범위인가? | MVP 제외 여부, 재검토 조건 |

## 완료 체크리스트

- 선택한 항목이 PRD의 실제 문제와 범위에 연결되어 있다.
- 기본 템플릿을 특정 기술로 강제하지 않았다.
- 선택하지 않은 고급 항목은 문서에 억지로 넣지 않았다.
- 결정하지 못한 항목은 열린 질문으로 남겼다.
- 비용, 보안, 개인정보, 실패 동작이 사용자 영향과 연결되어 있다.
