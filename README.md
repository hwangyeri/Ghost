# Ghost
SeSAC iOS LSLP :: Ghost 익명 커뮤니티 앱

### 0. 완전한 익명성을 보장하는 자유로운 익명 커뮤니티 앱입니다.
- 텍스트 기반의 피드 UI 구현
- 게시글, 댓글, 좋아요 `CRUD` 기능 구현
- 내가 작성한 게시글/좋아요한 게시글 관리 기능 구현
<br/>

## 1. 개발 기간
- 2023.11.16 ~ 2023.12.16 (4주)
- 세부 개발 기간
 
| 진행 사항 | 진행 기간 | 세부 내용 |
| ------- | :----: | ------- |
| 프로젝트 설정 및 개발 환경 구성  | `2023.11.16 ~ 2023.11.19` | Design Sysytem, GColor, 로그인 및 회원가입 UI 구현 |
| Join API 통신 기능 구현      | `2023.11.20 ~ 2023.11.25` | 회원가입, 이메일 중복 확인, 로그인 API 통신 및 로직 구현 |
| 토큰 기반 인증 및 갱신 기능 구현 | `2023.11.26 ~ 2023.11.28` | AcessToken 갱신 API 통신 및 보안 토큰 관리 시스템 구현 |
| Post API 통신 기능 구현      | `2023.11.29 ~ 2023.12.08` | 게시글, 댓글, 좋아요 기능 및 피드 UI 및 Pagination 구현  |
| 프로필 탭 UI 및 로직 구현      | `2023.12.09 ~ 2023.12.16` | 자동 로그인, 로그아웃, 회원탈퇴 기능 및 프로필 탭 UI 및 로직 구현 |
<br/>

### 1.1 개발 인원
- 개인 프로젝트
<br/>

## 2. 개발 환경
- Xcooe 15.0.1
- Deployment Target iOS 17.0
- 다크모드 디폴트
- 가로모드 미지원

<br/>

## 3. 기술 스택
- `UIKit`, `Singleton`, `Moya`, `Alamofire`, `Interceptor`
- `Codable`, `CodeBaseUI`, `PHPicker`, `UIImagePicker`, `UserDefaults`
- `Design System`, `DarkMode`, `MVVM`, `RxSwift`, `Input-Output`
- `Autolayout`, `Compositional Layout`, `Diffable DataSource`
- `Snapkit`, `JSON parsing`, `Kingfisher`, `Then`
- `TextFieldEffects`, `IQKeyboardManagerSwift`
- `Tabman`, `SwiftKeychainWrapper` 
<br/>

### 3.1 라이브러리
 
| 이름 | 버전 | 의존성 관리 |
| ------------- | :-------: | :---: |
| SnapKit                | `5.6.0`  | `SPM` |
| TextFieldEffects       | `1.7.0`  | `SPM` |
| Then                   | `3.0.0`  | `SPM` |
| IQKeyboardManagerSwift | `6.5.16` | `SPM` |
| RxSwift                | `6.6.0`  | `SPM` |
| Moya                   | `15.0.3` | `SPM` |
| SwiftKeychainWrapper   | `4.0.1`  | `SPM` |
| Kingfisher             | `7.10.1` | `SPM` |
| Tabman                 | `3.0.2`  | `SPM` |
<br/>

### 3.2 Tools
- `Figma/FigJam`, `Git/Github`, `Insomnia`, `Jandi`, `Notion`, `Discode`
<br/>

## 4. 핵심 기능 (수정중)
- `Custom UIView` 및 `Component` 생성하여 코드 재사용성 향상
- `UIActivityIndicatorView`, Custom Toast Message, EmptyView, 상하단 스크롤 플로팅 버튼, 등을 활용해서 사용성 향상
- 휴먼 에러를 줄이기 위해 `Constant` 및 `Enum` 활용
- `Moya`, `Generic`, `Metatype`을 통한 API 메서드 모듈화 및 직관적인 라우터 패턴 구현
- `Moya`, `RxSwift` 기반의 API 통신 기능 구현
- `RxSwift`, `MVVM`, `Input-Output` 구조로 회원가입 로직 구현
- `SwiftKeychainWrapper` 활용해서 키체인에 토큰 값 저장 및 로그인 로직 구현
- 액세스 토큰 만료 시 `Alamofire`, `Interceptor`를 통해서 토큰 갱신 로직 구현
- 리프레시 토큰 만료 시 `UserDefaults`로 로그인 여부 관리 및 루트뷰 전환해서 로그인 화면으로 전환
- `Kingfisher`, `PHPicker`, `UIImagePicker` 사용해서 카메라, 여러 장 선택 가능한 앨범, 이미지 다운샘플링, 압축 기능 구현


## 5. 트러블 슈팅

## 6. 회고

<br/>

---
## ＞ Commit Convention
```
- [Feat] 새로운 기능 구현
- [Style] UI 디자인 변경
- [Fix] 버그, 오류 해결
- [Refactor] 코드 리팩토링
- [Remove] 쓸모 없는 코드 삭제
- [Rename] 파일 이름/위치 변경
- [Chore] 빌드 업무, 패키지 매니저 및 내부 파일 수정
- [Comment] 필요한 주석 추가 및 변경
- [Test] 테스트 코드, 테스트 코드 리펙토링
```


