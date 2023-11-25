//
//  NicknameDataManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/26.
//

import Foundation

class NicknameDataManager {
    
    static let shared = NicknameDataManager()
    
    private init() {
        loadData()
    }
    
    var nicknameList: [NicknameData] = []
    
    //JSON 파일을 읽고 데이터를 디코딩하여 nicknameList에 저장하는 함수
    private func loadData() {
        if let jsonData = loadJSON() {
            do {
                //JSON 파일을 불러오는 코드
                let decodedData = try JSONDecoder().decode(Nickname.self, from: jsonData)
                self.nicknameList = decodedData.nicknameData
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Error loading JSON data")
        }
    }
    
    //앱 번들에서 JSON 파일을 로드하는 함수
    private func loadJSON() -> Data? {
        //1. 불러올 파일 이름
        let fileNm: String = "RandomNickname"

        //2. 불러올 파일의 확장자명
        let extensionType = "json"
        
        //3. 파일 위치
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            //4. 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            //5. 잘못된 위치나 불가능한 파일 처리 (수정필요)
            //파일 읽기 실패 시 nil 반환
            print("Error loading JSON file: \(error)")
            return nil
        }
    }
    
    //랜덤 닉네임 생성
    func createRandomNickname() -> String {
        let data = nicknameList[0]
        let determiner = data.determiners.randomElement() ?? "똑쟁이"
        let color = data.colors.randomElement() ?? "까만색"
        let animal = data.animals.randomElement() ?? "물개"
        return "\(determiner)\(color)\(animal)"
    }
    
}
