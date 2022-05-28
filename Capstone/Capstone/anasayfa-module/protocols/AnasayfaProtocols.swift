//
//  AnasayfaProtocols.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


protocol ViewToPresenterAnasayfaProtocol{
    
    var anasayfaInteractor : PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView : PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
}


protocol PresenterToInteractorAnasayfaProtocol{
    
    var anasayfaPresenter : InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYemekleriAl()
    
}




protocol InteractorToPresenterAnasayfaProtocol{
    func presenteraVeriGonder(yemekListesi: Array<Yemek>)
}



protocol PresenterToViewAnasayfaProtocol{
    func vieweVeriGonder(yemekListesi: Array<Yemek>)
    
    
}




protocol PresenterToRouterAnasayfaProtocol{
    static func createModule(ref: AnasayfaVC)
}
