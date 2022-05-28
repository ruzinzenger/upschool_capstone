//
//  YemekDetayInteractor.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import Foundation
import Alamofire


class YemekDetayInteractor : PresenterToInteractorYemekDetayProtocol{
    var yemekDetayPresenter: InteractorToPresenterYemekDetayProtocol?
    
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        
        // only add an item to the cart if the user incremented the stepper
        if(yemek_siparis_adet > 0){
            
            var yemek_siparis_adet_var = yemek_siparis_adet
        
            // FIRST GET THE CURRENT CONTENTS OF THE CART
            // if there is already an entry for the food type that the user is currently adding to cart, then delete the previous entry, add the counts, and add a new entry with the combined count
            let params : Parameters = ["kullanici_adi": kullanici_adi]
                    
            AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{ response in
                if let data = response.data{
                    do{
                        let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)

                        if let liste = cevap.sepet_yemekler{
                            for item in liste{
                                // if a match is found
                                if item.yemek_adi! == yemek_adi{
                                    self.repeatSil(sepet_yemek_id: Int(item.sepet_yemek_id!)!, kullanici_adi: kullanici_adi)
                                    yemek_siparis_adet_var += Int(item.yemek_siparis_adet!)!
                                }
                            }
                            self.sepeteEkleHelper(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet_var, kullanici_adi: kullanici_adi)
                        }
                        print()
                    }catch{
                        // if this is the first item being added to the cart
                        // sepettekiYemekleriGetir webservice throws an exception if the cart is empty which brings us here
                        self.sepeteEkleHelper(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet_var, kullanici_adi: kullanici_adi)
                        print(error.localizedDescription)
                                
                    }
                }
                        
            }

                
            
                
   
        }
    }
    
    // helper method that deletes the previous entry for the food item with the same name as the current one being added to cart
    func repeatSil(sepet_yemek_id : Int, kullanici_adi : String){
        let params : Parameters = ["sepet_yemek_id" : sepet_yemek_id, "kullanici_adi":kullanici_adi]
        
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

    // helper method that calls the web service that adds the food item with the updated count to the cart
    func sepeteEkleHelper(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
        let params : Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat" : yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]

            
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{

                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print("sepete ekle: \(cevap)")
                        
                        
                }catch{
                    print(error.localizedDescription)
                        
                }
            }
                
        }
        
    }
    
    func araFiyatHesapla(yemek_fiyat: Int, yemek_siparis_adet: Int) {
        let ara : Int = yemek_fiyat * yemek_siparis_adet
        let araToplamText = "\(ara) ₺"
        yemekDetayPresenter?.presenteraVeriGonder(araToplam: araToplamText)
    }
    
}
