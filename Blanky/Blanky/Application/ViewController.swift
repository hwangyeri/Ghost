//
//  ViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let mainLabel = {
        let view = BLabel(text: "dddd", fontWeight: .black, fontSize: .XXXL)
        view.textColor = .red
        return view
    }()
    
    let emailTextField = {
        let view = UITextField()
//        view.placeholder = "예) blanky@blanky.com"
        view.attributedPlaceholder = NSAttributedString(string: "예) blanky@blanky.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        view.font = .customFont(.regular, size: .S)
//        view.textColor = .black
//        view.borderStyle = .line
//        view.layer.borderColor = UIColor(ciColor: .black).cgColor
        view.autocapitalizationType = .none // 자동 대문자
        view.spellCheckingType = .no // 맞춤법 검사
        view.autocorrectionType = .no // 자동 수정
        view.keyboardType = .emailAddress
        view.clearButtonMode = .whileEditing
        view.clearsOnBeginEditing = true // 편집 시 기존 텍스트필드값 제거
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(60)
        }
    }


}

