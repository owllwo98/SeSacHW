//
//  ShoppingInfo.swift
//  SeSacHW8
//
//  Created by 변정훈 on 1/5/25.
//

import Foundation

/*
 뭔가 초기에 구현한 코드가 DIP 에 적합하지 않은 코드인 것 같아서 조금 수정해봤습니다.
 */
//class Shopping {
//    var title: String
//    var favorite: Bool
//    var purchase: Bool
//    
//    init(title: String, favorite: Bool, purchase: Bool) {
//        self.title = title
//        self.favorite = favorite
//        self.purchase = purchase
//    }
//}
//
//
//struct ShoppingInfo {
//    let shopping: [Shopping] = [
//        Shopping(title: "", favorite: false, purchase: false),
//        Shopping(title: "그립톡 구매하기", favorite: true, purchase: true),
//        Shopping(title: "사이다 구매", favorite: false, purchase: false),
//        Shopping(title: "아이패드 케이스 최저가 알아보기", favorite: true, purchase: false),
//        Shopping(title: "양말", favorite: true, purchase: false)
//        
//    ]
//}

/* 조금 수정해보았는데 ShoppingInfoRepository 가 Shopping 를 사용하고 있어서 완벽하게 분리하지는 못한 것 같습니다. 아마 팩토리 패턴? 을 사용하면 될 것 같은데 아직 개념적으로나 실제로 사용해본적이 없어서 그냥 남겨놓겠습니다 ㅎㅎ;
 */

protocol ShoppingItem {
    var title: String { get }
    var favorite: Bool { get set }
    var purchase: Bool { get set }
}

protocol ShoppingRepository {
    var items: [ShoppingItem] { get }
}

class Shopping: ShoppingItem {
    var title: String
    var favorite: Bool
    var purchase: Bool
    
    init(title: String, favorite: Bool, purchase: Bool) {
        self.title = title
        self.favorite = favorite
        self.purchase = purchase
    }
}

class ShoppingInfoRepository: ShoppingRepository {
    let items: [ShoppingItem] = [
        Shopping(title: "", favorite: false, purchase: false),
        Shopping(title: "그립톡 구매하기", favorite: true, purchase: true),
        Shopping(title: "사이다 구매", favorite: false, purchase: false),
        Shopping(title: "아이패드 케이스 최저가 알아보기", favorite: true, purchase: false),
        Shopping(title: "양말", favorite: true, purchase: false)
    ]
}



