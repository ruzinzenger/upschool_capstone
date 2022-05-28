//
//  ViewController.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/27/22.
//

import UIKit
import Kingfisher

class AnasayfaVC: UIViewController {
    
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    
    var yemekList = [Yemek]()
    
    var anasayfaPresenterNesnesi : ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        
        
        // NAVIGATION BAR
        self.navigationItem.title = "Menu"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "color_orange")
        
        // title text rengi ve fontu
        appearance.titleTextAttributes = [.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont(name: "Caveat-SemiBold", size: 36)!]
        
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        // -------------------------------------
        AnasayfaRouter.createModule(ref: self)
        anasayfaPresenterNesnesi?.yemekleriYukle()
        
        
    }
    
    
    // sending Yemek object to YemekDetayVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            if let yemek = sender as? Yemek{
                let gidilecekVC = segue.destination as! YemekDetayVC
                gidilecekVC.yemek = yemek
            }
        }
    }
    
    
    // reverses page navigation (For when the user clicks the Sepete Ekle button)
    @IBAction func unwindToAnasayfaController(segue: UIStoryboardSegue) {
        print("Unwind to Anasayfa Controller")
    }


}




extension AnasayfaVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = yemekList[indexPath.row]
        
        // for even numbered rows in tableview, use sol prototype cell (image is on the left)
        // for odd numbered rows in tableview, use sag prototype cell (image is on the right)
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "yemek_hucre_sol", for: indexPath) as! YemekSolTableViewCell
            
            DispatchQueue.main.async {
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)")!
                // kf = kingfisher
                cell.solImageView.kf.setImage(with: url)
            }
            
            cell.solYemekLabel.text = yemek.yemek_adi
 
            let buttonText : String = "\(yemek.yemek_fiyat!) ₺"
            cell.solFiyatButton.setTitle(buttonText, for: .normal)
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "yemek_hucre_sag", for: indexPath) as! YemekSagTableViewCell
            
            
            DispatchQueue.main.async {
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)")!
                // kf = kingfisher
                cell.sagImageView.kf.setImage(with: url)
            }
            
            cell.sagYemekLabel.text = yemek.yemek_adi
            
            let buttonText : String = "\(yemek.yemek_fiyat!) ₺"
            cell.sagFiyatButton.setTitle(buttonText, for: .normal)
            
            
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at: \(indexPath.row)")
        let yemek = yemekList[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension AnasayfaVC : PresenterToViewAnasayfaProtocol{
    func vieweVeriGonder(yemekListesi: Array<Yemek>) {
        self.yemekList = yemekListesi
        DispatchQueue.main.async {
            self.yemeklerTableView.reloadData()
        }
    }
}
