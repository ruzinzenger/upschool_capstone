//
//  SepetPresenter.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


class SepetPresenter : ViewToPresenterSepetProtocol{
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    var sepetView: PresenterToViewSepetProtocol?
    
    func sepetiYukle(kullanici_adi: String) {
        sepetInteractor?.tumSepetiAl(kullanici_adi: kullanici_adi)
    }
    
    func sil(sepet_yemek_id: Int, kullanici_adi: String) {
        sepetInteractor?.sepettenSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func hesapYap(sepetListesi: Array<SepetItem>) {
        sepetInteractor?.toplamiHesapla(sepetListesi: sepetListesi)
    }
    
    func tumuSil(sepetListesi: Array<SepetItem>, kullanici_adi: String) {
        sepetInteractor?.tumSepetiSil(sepetListesi: sepetListesi, kullanici_adi: kullanici_adi)
    }

}



extension SepetPresenter : InteractorToPresenterSepetProtocol{
    func presenteraVeriGonder(sepetListesi: Array<SepetItem>) {
        sepetView?.vieweVeriGonder(sepetListesi: sepetListesi)
    }
    
    
    func presenteraToplamGonder(toplamHesap: String) {
        sepetView?.vieweToplamGonder(toplamHesap: toplamHesap)
    }
}
