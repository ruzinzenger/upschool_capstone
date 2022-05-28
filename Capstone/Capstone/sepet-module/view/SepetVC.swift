//
//  SepetVC.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import UIKit
import Kingfisher

class SepetVC: UIViewController {
    

    @IBOutlet weak var sepetTableView: UITableView!
    
    @IBOutlet weak var toplamLabel: UILabel!
    
    
    var sepetList = [SepetItem]()
    
    var sepetPresenterNesnesi : ViewToPresenterSepetProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sepetTableView.delegate = self
        sepetTableView.dataSource = self

        SepetRouter.createModule(ref: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetPresenterNesnesi?.sepetiYukle(kullanici_adi: my_kullanici_adi)
    }
    

    
    @IBAction func sepetiTemizleTikla(_ sender: Any) {
        let alert = UIAlertController(title: "Silme işlemi", message: "Sepetteki bütün ürünler silinsin mi?", preferredStyle: .alert)
        
        let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in }
        
        alert.addAction(iptalAction)
        
        let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
            self.sepetPresenterNesnesi?.tumuSil(sepetListesi: self.sepetList, kullanici_adi: my_kullanici_adi)
                
        }
        
        alert.addAction(evetAction)
        self.present(alert, animated: true)
    }
    
    
}


extension SepetVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let s_item = sepetList[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepet_hucre", for: indexPath) as! SepetTableViewCell
            
        
        DispatchQueue.main.async {
            let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(s_item.yemek_resim_adi!)")!
            // kf = kingfisher
            cell.sepetImageView.kf.setImage(with: url)
        }
        
        
        cell.sepetYemekLabel.text = s_item.yemek_adi
        cell.sepetAdetLabel.text = String(s_item.yemek_siparis_adet!)
        let ara_toplam = Int(s_item.yemek_fiyat!)! * Int(s_item.yemek_siparis_adet!)!
        cell.sepetAraToplamLabel.text = "\(ara_toplam) ₺"
            
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (action, view, void) in
            // reason for .self: we're in too many closures at this point
            // so the compiler can get confused sometimes
            let item = self.sepetList[indexPath.row]
            
            
            let alert = UIAlertController(title: "Silme işlemi", message: "\(item.yemek_adi!) sepetten silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in }
            
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                
                self.sepetPresenterNesnesi?.sil(sepet_yemek_id: Int(item.sepet_yemek_id!)!, kullanici_adi: my_kullanici_adi)
                    
            }
            
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        // since we just deleted an item, we need to re-calculate total cart cost
        self.sepetPresenterNesnesi?.hesapYap(sepetListesi: sepetList)
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}


extension SepetVC : PresenterToViewSepetProtocol{
    func vieweVeriGonder(sepetListesi: Array<SepetItem>) {
        self.sepetList = sepetListesi
        // once the sepetList is updated we want to re-calculate total cost of cart
        sepetPresenterNesnesi?.hesapYap(sepetListesi: sepetList)
        DispatchQueue.main.async {
            self.sepetTableView.reloadData()
        }
    }
    
    func vieweToplamGonder(toplamHesap: String) {
        toplamLabel.text = toplamHesap
    }
}
