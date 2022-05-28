//
//  YemekDetayRouter.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


class YemekDetayRouter : PresenterToRouterYemekDetayProtocol{
    static func createModule(ref: YemekDetayVC) {
        let presenter = YemekDetayPresenter()
        
        ref.yemekDetayPresenterNesnesi = presenter
        
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = YemekDetayInteractor()
        ref.yemekDetayPresenterNesnesi?.yemekDetayView = ref
        
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor?.yemekDetayPresenter = presenter
    }
    
}
