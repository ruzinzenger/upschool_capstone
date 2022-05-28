//
//  AnasayfaInteractor.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation
import Alamofire


class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol{
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriAl() {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(YemekCevap.self, from: data)

                    if let liste = cevap.yemekler{
                        self.anasayfaPresenter?.presenteraVeriGonder(yemekListesi: liste)
                    }
                }catch{
                    print(error.localizedDescription)
                    
                }
            }
            
        }
        
        
    }
    
    
}
