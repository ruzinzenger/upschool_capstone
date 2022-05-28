//
//  SepetProtocols.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


protocol ViewToPresenterSepetProtocol{
    var sepetInteractor : PresenterToInteractorSepetProtocol? {get set}
    var sepetView : PresenterToViewSepetProtocol? {get set}
    
    func sepetiYukle(kullanici_adi : String)
    func sil(sepet_yemek_id : Int, kullanici_adi : String)
    func hesapYap(sepetListesi : Array<SepetItem>)
    func tumuSil(sepetListesi : Array<SepetItem>, kullanici_adi : String)
}


protocol PresenterToInteractorSepetProtocol{
    var sepetPresenter : InteractorToPresenterSepetProtocol? {get set}
    
    func tumSepetiAl(kullanici_adi : String)
    func sepettenSil(sepet_yemek_id : Int, kullanici_adi : String)
    func toplamiHesapla(sepetListesi : Array<SepetItem>)
    func tumSepetiSil(sepetListesi : Array<SepetItem>, kullanici_adi : String)
    
    
}


protocol InteractorToPresenterSepetProtocol{
    func presenteraVeriGonder(sepetListesi : Array<SepetItem>)
    
    func presenteraToplamGonder(toplamHesap : String)
    
}


protocol PresenterToViewSepetProtocol{
    func vieweVeriGonder(sepetListesi : Array<SepetItem>)
    
    func vieweToplamGonder(toplamHesap : String)
    
    
}


protocol PresenterToRouterSepetProtocol{
    static func createModule(ref: SepetVC)
    
}
