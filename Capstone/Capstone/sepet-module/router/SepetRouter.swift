//
//  SepetRouter.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


class SepetRouter : PresenterToRouterSepetProtocol{
    
    static func createModule(ref: SepetVC) {
        let presenter = SepetPresenter()
        
        ref.sepetPresenterNesnesi = presenter
        
        ref.sepetPresenterNesnesi?.sepetInteractor = SepetInteractor()
        ref.sepetPresenterNesnesi?.sepetView = ref
        
        ref.sepetPresenterNesnesi?.sepetInteractor?.sepetPresenter = presenter
        
    }
    
    
}
