//
//  ViewController.swift
//  CoronaApp
//
//  Created by 小早川　聖 on 2021/10/30.
//

import UIKit

class ViewController: UIViewController {

    let colors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpGradation()
        
    }

    // グラデーションの設定
    func setUpGradation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        // グラデーションの配色は配列で指定する
        gradientLayer.colors = [colors.bluePurple.cgColor, colors.blue.cgColor]
        // グラデーションの方向を設定している。0,0から始まって1,1方向の向き
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        /* レイヤーを載せる場合はinsertSublayer(子, at: 海藻)を使用する。
         親であるスマホ画面に作成したグラデーションレイヤーを載せる。レイヤーを重ねるときはatの値が大きい方が前面にいく。*/
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

