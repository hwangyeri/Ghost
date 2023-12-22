//
//  SettingViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/21.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    
    private let disposeBag = DisposeBag()
    
    var email: String?
    
    private let section0Title = ["프로필 수정하기", "문의 남기기"]
    private let section1Title = ["알림 설정", "로그아웃", "회원탈퇴"]
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureLayout() {
        setBackButton()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    private func handleLogout() {
        // 로그아웃
        UserLoginManager.shared.isLogin = false
        let vc = InitialViewController()
        RootVCManager.shared.changeRootVC(vc)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func handleWithdraw() {
        // 탈퇴 API
        JoinAPIManager.shared.withdraw()
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print("회원 탈퇴 성공: ", data)
                    UserLoginManager.shared.isLogin = false
                    let vc = InitialViewController()
                    RootVCManager.shared.changeRootVC(vc)
                    self.navigationController?.popToRootViewController(animated: true)
                case .failure(let error):
                    print("회원 탈퇴 실패: ", error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return section0Title.count
        default:
            return section1Title.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SettingHeaderView()
        
        switch section {
        case 0:
            headerView.titleLabel.text = "내 정보"
        default:
            headerView.titleLabel.text = "설정"
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = section0Title[indexPath.row]
            return cell
        default:
            cell.titleLabel.text = section1Title[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            switch row {
            case 0:
                // 프로필 수정하기
                print("프로필 수정하기 탭")
            default:
                // 문의 남기기
                print("문의 남기기 탭")
            }
        default:
            switch row {
            case 0:
                // 알림 설정
                print("알림 설정 탭")
            case 1:
                // 로그아웃
                let alert = UIAlertController(title: "\(self.email ?? "")", message: "정말 로그아웃하실 건가요?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] _ in
                    self?.handleLogout()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                
                alert.addAction(ok)
                alert.addAction(cancel)
                
                present(alert, animated: true)
            default:
                // 회원탈퇴
                let alert = UIAlertController(title: "\(self.email ?? "")", message: "정말 회원 탈퇴하실 건가요? 😢", preferredStyle: .alert)
                let ok = UIAlertAction(title: "탈퇴", style: .destructive) { [weak self] _ in
                    self?.handleWithdraw()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                
                alert.addAction(ok)
                alert.addAction(cancel)
                
                present(alert, animated: true)
            }
        }
    }
    
}
