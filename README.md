# Ghost
### 완전한 익명성을 보장하는 자유로운 익명 커뮤니티 앱입니다.

![ghostMockUp](https://github.com/hwangyeri/Ghost/assets/114602459/ab68d37d-7ec5-43dc-8bcb-f49d02b48962)

## 주요 기능
- 회원가입 • 회원탈퇴 • 로그아웃 • 자동 로그인 기능
- 익명 기반의 게시글 • 댓글 • 좋아요 기능
- 내가 작성한 / 좋아요한 게시글 관리 기능
<br/>

## 개발 환경
- **최소 버전** : iOS 16.0
- **개발 인원** : 1명
- **개발 기간** : 2023.11.16 ~ 2023.12.16 (4주)
- **기타** : Dark Mode 지원
<br/>

## 기술 스택
- `UIKit`, `CodeBaseUI`, `RxSwift`
- `MVVM`, `Input-Output`, `Singleton`, `Repository`, `Design System`
- `Autolayout`, `Compositional Layout`, `Diffable DataSource`
- `Snapkit`, `Then`, `Kingfisher`, `SPM`
- `Moya`, `Alamofire`, `SwiftKeychainWrapper`
- `Tabman`, `TextFieldEffects`, `IQKeyboardManagerSwift`
<br/>

## 핵심 기술
- `RxSwift`와 `Alamofire Interceptor`를 이용한 `JWT` 기반의 회원 인증 로직 구현
- `Regular Expression`과 서버 통신을 이용한 로그인/회원가입 사용자 입력 정보 유효성 검증
- `flatMap`, `withLatestFrom` 등 `operator`를 이용한 `RxSwift` 기반의 반응형 UI 구현
- `Moya`, `Enum` 및 `Metatype`을 이용한 네트워트 구조 모듈화
- `Generic`과 `Router Pattern`을 이용한 API 메서드 추상화
- `debounce`, `distinctUntilChanged` 등 `operator`를 이용한 불필요한 네트워크 호출 최소화
- `Multipart/form-data` 형식의 여러 장의 이미지 업로드, 캐싱 및 다운샘플링 구현
- `prefetchRowsAt` 메서드를 이용한 `Cursor-based Pagination` 구현
<br/>

## 문제 해결
### 1. 실시간으로 게시글이 추가/삭제되는 경우, 중복 데이터 발생
- **문제 상황** : API 통신을 통해 가져온 대량의 데이터를 효과적으로 처리하고 화면(피드)에 표시하는 것이 필요했음.
- **해결 방법** : viewWillAppear 메서드와 Cursor-based Pagination 구현을 통해 실시간으로 데이터를 반영해서 중복되는 문제를 해결함. 마지막으로 로드된 데이터를 기반으로 다음 데이터셋을 가져와 서버 로드를 줄이고 데이터 일관성을 보장하며 사용자 경험을 최적화함.


a. 게시글이 새롭게 추가되거나 수정/삭제된 경우, 실시간으로 반영하기 위해 viewWillAppear 메서드에 구현했습니다.
``` swift
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false
        postDataList.data.removeAll()
        postRead(cursor: "") // 1. 초기 데이터 로드
    }
```

b. 마지막에 표시되는 셀의 인덱스가 지정한 범위 내에 있는지 확인하고, 커서 값과 함께 postRead 메서드를 사용해 현재 콘텐츠의 끝에 도달하기 전에 데이터를 사전에 로드시켰습니다.
``` swift
 private func prefetchData(for indexPaths: [IndexPath]) {
        guard let lastIndexPath = indexPaths.last else {
            return
        }

        let lastIndex = lastIndexPath.row
        let totalCount = postDataList.data.count

        if lastIndex >= totalCount - 3 {
            // 2. 다음 페이지 처리
            postRead(cursor: postDataList.next_cursor)
        }
    }
```

c. 불필요한 오류를 방지하기 위해 guard 문을 사용하여 예외 처리를 구현했습니다.
``` swift
private func postRead(cursor: String) {
        print(#function)

        // 더이상 로드할 데이터 없을 시 예외처리
        guard cursor != "0" else {
            print("더이상 로드 할 데이터가 없습니다.")
            return
        }

        // 게시글 조회 API
        PostAPIManager.shared.postRead(next: cursor)
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print("포스트 조회 성공")

                    // 3. 데이터 소스 업데이트
                    owner.postDataList.data.append(contentsOf: data.data)
                    owner.postDataList. = data.next_cursor

                    // 4. 테이블뷰 리로드
                    owner.mainView.tableView.reloadData()

                case .failure(let error):
                    print("포스트 조회 실패: ", error)
                    owner.showAlertMessage(title: "Error", message: "게시글 조회에 실패했어요. 😢\n다시 시도해 주세요.")
                }
            }
            .disposed(by: disposeBag)
    }
```

#### 1-1. 해당 이슈에 대한 블로그 링크
🔗 [Cursor-based Pagination 구현하기 (+ Prefetching)](https://yeridev.tistory.com/entry/XFile-42)


### 2. 사용자의 event에 따른 반응형 UI 구현
- **문제 상황** : 각기 다른 스트림에서 발생하는 입력 값으로 인해 반응이 뒤늦게 나타나는 문제가 발생함.
- **해결 방법** : 정규표현식과 flatMap, withLatestFrom, combineLatest 등의 operator를 활용하여 적절한 시점에 유효성을 검증하고 UI를 업데이트함.


``` swift
class LoginViewModel: BaseViewModel {

// 이전 코드 생략..

    func transform(input: Input) -> Output {
        
        // 이메일 유효성 검사
        let emailValidation = input.emailTextField
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { text in
                let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                guard let _ = text.range(of: emailRegex, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)

        // 코드 생략..

        // 로그인 버튼 탭
        let loginButtonTap = input.loginButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(input.emailTextField, input.passwordTextField))
            .flatMap { email, password in
                JoinAPIManager.shared.login(email: email, password: password)
                    .map { result in
                        switch result {
                        case .success(let data):
                            print("🩵 로그인 성공")
                            UserLoginManager.shared.isLogin = true
                            // 키체인에 유저 정보 저장
                            KeychainManager.shared.userID = data._id
                            KeychainManager.shared.token = data.token
                            KeychainManager.shared.refreshToken = data.refreshToken
                            return (true, "")
                        case .failure(let error):
                            print("💛 로그인 실패")
                            UserLoginManager.shared.isLogin = false
                            return (false, error.errorDescription)
                        }
                    }
            }
            .asDriver(onErrorJustReturn: (false, ""))

        // 코드 생략..
}
```
<br/>

## UI/UX
|<img src="https://github.com/hwangyeri/Ghost/assets/114602459/90f05dbb-c955-498c-8c9f-3f2f65feadfa.gif" width=240></img>|<img src="https://github.com/hwangyeri/Ghost/assets/114602459/cc4bcf34-9744-489a-b586-7873f4a923cb.gif" width=240></img>|<img src="https://github.com/hwangyeri/Ghost/assets/114602459/0e97bca6-646a-4d84-a21d-ec28b8fe4603.gif" width=240></img>|
|:-:|:-:|:-:|
|`회원가입/로그인 기능`|`좋아요/댓글 기능`|`게시글 작성/로그아웃 기능`|
<br/>

## Commit Convention
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

<br/>

## 개발 공수
| 진행 사항 | 진행 기간 | 세부 내용 |
| ------- | :----: | ------- |
| 프로젝트 설정 및 개발 환경 구성  | `2023.11.16 ~ 2023.11.19` | Design Sysytem, GColor, 로그인 및 회원가입 UI 구현 |
| Join API 통신 기능 구현      | `2023.11.20 ~ 2023.11.25` | 회원가입, 이메일 중복 확인, 로그인 API 통신 및 로직 구현 |
| 토큰 기반 인증 및 갱신 기능 구현 | `2023.11.26 ~ 2023.11.28` | AcessToken 갱신 API 통신 및 보안 토큰 관리 시스템 구현 |
| Post API 통신 기능 구현      | `2023.11.29 ~ 2023.12.08` | 게시글, 댓글, 좋아요 기능 및 피드 UI 및 Pagination 구현  |
| 프로필 탭 UI 및 로직 구현      | `2023.12.09 ~ 2023.12.16` | 자동 로그인, 로그아웃, 회원탈퇴 기능 및 프로필 탭 UI 및 로직 구현 |

<br/>

