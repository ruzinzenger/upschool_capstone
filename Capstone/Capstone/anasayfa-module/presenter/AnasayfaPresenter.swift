//
//  AnasayfaPresenter.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation


class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol{
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle() {
        anasayfaInteractor?.tumYemekleriAl()
    }
}



extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol{
    func presenteraVeriGonder(yemekListesi: Array<Yemek>) {
        anasayfaView?.vieweVeriGonder(yemekListesi: yemekListesi)
    }
}
