//
//  SepetInteractor.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation
import Alamofire


class SepetInteractor : PresenterToInteractorSepetProtocol{
    var sepetPresenter: InteractorToPresenterSepetProtocol?
    
    func tumSepetiAl(kullanici_adi: String) {
        
        let params : Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)

                    if let liste = cevap.sepet_yemekler{
                        self.sepetPresenter?.presenteraVeriGonder(sepetListesi: liste)
                    }
                }catch{
                    // if cart is empty, return empty SepetItem list to update VC
                    let empty_list = [SepetItem]()
                    self.sepetPresenter?.presenteraVeriGonder(sepetListesi: empty_list)
                    print(error.localizedDescription)
                    
                }
            }
            
        }
        
        
        
    }
    
    func sepettenSil(sepet_yemek_id: Int, kullanici_adi: String) {
        
        let params : Parameters = ["sepet_yemek_id" : sepet_yemek_id, "kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    
                    self.tumSepetiAl(kullanici_adi: kullanici_adi)
                }catch{
                    print(error.localizedDescription)
                    
                }
            }
            
        }
        
    }
    
    func toplamiHesapla(sepetListesi: Array<SepetItem>) {
        var toplam : Int = 0
        for item in sepetListesi{
            toplam += Int(item.yemek_fiyat!)! * Int(item.yemek_siparis_adet!)!
        }
        sepetPresenter?.presenteraToplamGonder(toplamHesap: "\(String(toplam)) ₺")

    }
    
    func tumSepetiSil(sepetListesi: Array<SepetItem>, kullanici_adi: String) {
        var id_list = [String]()
        
        for item in sepetListesi{
            id_list.append(item.sepet_yemek_id!)
        }
        

        for id in id_list{
            let params : Parameters = ["sepet_yemek_id" : Int(id)!, "kullanici_adi":kullanici_adi]
            
            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response{ response in
                if let data = response.data{
                    do{
                        let cevap = try JSONSerialization.jsonObject(with: data)
                        print(cevap)
                    
                        
                    }catch{
                        print(error.localizedDescription)
                        
                    }
                }
                
            }
            
        }
        
        
        self.tumSepetiAl(kullanici_adi: kullanici_adi)
        
        
    }
}
