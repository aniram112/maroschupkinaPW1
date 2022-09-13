//
//  ViewController.swift
//  maroschupkinaPW1
//
//  Created by Marina Roshchupkina on 13.09.2022.
//
// в сториборде происходит что-то ужасное но зато ui вроде не съезжает даже на айподе

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isEnabled = false
        
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(UIColor.hexStringToUIColor(hex: UIColor.randomHex()))
        }
        
        UIView.animate(withDuration: 0.7, animations: {
            for view in self.views {
                view.layer.cornerRadius = 10
                view.backgroundColor = set.popFirst()
                view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                
            }
        }) {
            complition in
            button?.isEnabled = true
            UIView.animate(withDuration: 0.7, animations: {
                for view in self.views {
                    view.transform = CGAffineTransform.identity
                }
            })
        }
        
        
    }
}
extension UIColor {
    static func randomHex() -> String {
        let a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"];
        return "#"
            .appending(a[Int.random(in:0..<16)])
            .appending(a[Int.random(in:0..<16)])
            .appending(a[Int.random(in:0..<16)])
            .appending(a[Int.random(in:0..<16)])
            .appending(a[Int.random(in:0..<16)])
            .appending(a[Int.random(in:0..<16)])
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

