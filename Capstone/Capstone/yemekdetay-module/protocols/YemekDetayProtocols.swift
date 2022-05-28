//
//  YemekDetayProtocols.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


protocol ViewToPresenterYemekDetayProtocol{
    var yemekDetayInteractor : PresenterToInteractorYemekDetayProtocol? {get set}
    var yemekDetayView : PresenterToViewYemekDetayProtocol? {get set}
    
    
    func ekle(yemek_adi: String, yemek_resim_adi : String, yemek_fiyat : Int, yemek_siparis_adet : Int, kullanici_adi : String)
    
    func hesapla(yemek_fiyat : Int, yemek_siparis_adet : Int)

}



protocol PresenterToInteractorYemekDetayProtocol{
    var yemekDetayPresenter : InteractorToPresenterYemekDetayProtocol? {get set}
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi : String, yemek_fiyat : Int, yemek_siparis_adet : Int, kullanici_adi : String)
    
    func araFiyatHesapla(yemek_fiyat : Int, yemek_siparis_adet : Int)
    
}


protocol InteractorToPresenterYemekDetayProtocol{
    func presenteraVeriGonder(araToplam : String)
}


protocol PresenterToViewYemekDetayProtocol{
    func vieweVeriGonder(araToplam : String)
    
}


protocol PresenterToRouterYemekDetayProtocol{
    static func createModule(ref: YemekDetayVC)
}
