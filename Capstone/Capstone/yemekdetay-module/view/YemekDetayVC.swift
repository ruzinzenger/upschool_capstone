//
//  YemekDetayVC.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

/*
 https://www.ioscreator.com/tutorials/stepper-ios-tutorial
 https://cocoacasts.com/how-do-unwind-segues-work
 */

import UIKit
import Kingfisher

class YemekDetayVC: UIViewController {

    @IBOutlet weak var yemekDetayImageView: UIImageView!
    
    @IBOutlet weak var yemekDetayLabel: UILabel!
    
    
    @IBOutlet weak var fiyatDetayLabel: UILabel!
    
    
    @IBOutlet weak var adetLabel: UILabel!
    
    
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    
    @IBOutlet weak var araToplamLabel: UILabel!
    
    
    var yemek : Yemek?
    
    var fiyat : Int?
    
    var yemekDetayPresenterNesnesi : ViewToPresenterYemekDetayProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YemekDetayRouter.createModule(ref: self)

        
        adetLabel.text = "0"
        araToplamLabel.text = "0 ₺"
        
        stepperOutlet.wraps = true
        stepperOutlet.autorepeat = true
        stepperOutlet.maximumValue = 50
        
        
        if let y = yemek{
            yemekDetayLabel.text = y.yemek_adi
            
            DispatchQueue.main.async {
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)")!
                // kf = kingfisher
                self.yemekDetayImageView.kf.setImage(with: url)
            }
            
            fiyatDetayLabel.text = "\(y.yemek_fiyat!) ₺"
            fiyat = Int(y.yemek_fiyat!)!
        }
    }
    

    @IBAction func stepperClicked(_ sender: UIStepper) {
        let adet : Int = Int(sender.value)
        adetLabel.text = Int(sender.value).description
        if(adet > 0){
            adetLabel.textColor = UIColor.red
        }else{
            adetLabel.textColor = UIColor.black
        }
        if let yf = yemek?.yemek_fiyat{
            yemekDetayPresenterNesnesi?.hesapla(yemek_fiyat: Int(yf)!, yemek_siparis_adet: adet)
        }
    }

    
    @IBAction func sepeteEkleTikla(_ sender: Any) {
        if let ya = yemekDetayLabel.text, let yra = yemek?.yemek_resim_adi, let yf = yemek?.yemek_fiyat, let ysa = Int(adetLabel.text!){
            yemekDetayPresenterNesnesi?.ekle(yemek_adi: ya, yemek_resim_adi: yra, yemek_fiyat: Int(yf)!, yemek_siparis_adet: ysa, kullanici_adi: my_kullanici_adi)
            
        }
        
    }
    
}


extension YemekDetayVC : PresenterToViewYemekDetayProtocol{
    func vieweVeriGonder(araToplam: String) {
        araToplamLabel.text = araToplam
        if(araToplam != "0 ₺"){
            araToplamLabel.textColor = UIColor.red
        }else{
            araToplamLabel.textColor = UIColor.black
        }
    }
    
}
