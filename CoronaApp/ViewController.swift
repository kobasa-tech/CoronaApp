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
        setUpContent()
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
    
    // コロナに関するデータ画面を作成
    func setUpContent() {
        let contentView = UIView()
        // 幅：デバイスの幅、高さ：340のviewをデバイスの中央に配置
        contentView.frame.size = CGSize(width: view.frame.size.width, height: 340)
        contentView.center = CGPoint(x: view.center.x, y: view.center.y)
        contentView.backgroundColor = .white
        // cornerRadiusの値が大きいほど角がまるくなる
        contentView.layer.cornerRadius = 30
        /* 影の設定。shadowOffsetで影の方向を設定。widthが正で右に、heightが正で下方向に広がる。
         shadowColorで影の色を設定。layerプロパティの色なのでcgColorに変換。影の透明度をshadowOpacityで設定 */
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
        
        /* contentViewよりも下方向の画面の背景色を変更。上方向はグラデーションのまま。
        →背景色がグレーに変更されず、下方向がグラデーションのままになっている。別の記述が必要? */
        view.backgroundColor = .systemGray6
        
        // 表示する文字の設定。
        let labelFont = UIFont.systemFont(ofSize: 15, weight: .heavy)
        // 文字を入れる箱の設定
        let size = CGSize(width: 150, height: 50)
        let color = colors.bluePurple
        let leftX = view.frame.size.width * 0.33
        let rightX = view.frame.size.width * 0.80
        
        // タイトルを設定。viewの上に配置されるが起点はcontentViewになっている。
        setUpLabel("Covid in Japan", size: CGSize(width: 180, height: 35), centerX: view.center.x - 20, y: -60,
                   font: .systemFont(ofSize: 25, weight: .heavy), color: .white, contentView)
        // 上記の設定で項目名を配置している。
        setUpLabel("PCR数", size: size, centerX: leftX, y: 20, font: labelFont, color: color, contentView)
        setUpLabel("感染者数", size: size, centerX: rightX, y: 20, font: labelFont, color: color, contentView)
        setUpLabel("入院者数", size: size, centerX: leftX, y: 120, font: labelFont, color: color, contentView)
        setUpLabel("重傷者数", size: size, centerX: rightX, y: 120, font: labelFont, color: color, contentView)
        setUpLabel("死者数", size: size, centerX: leftX, y: 220, font: labelFont, color: color, contentView)
        setUpLabel("退院者数", size: size, centerX: rightX, y: 220, font: labelFont, color: color, contentView)
    }
    
    // 文字の設定。テキストと親画面は引数で記述を省略できるようにしている。
    func setUpLabel(_ text: String, size: CGSize, centerX: CGFloat, y: CGFloat, font: UIFont, color: UIColor, _ parentView: UIView ) {
        let label = UILabel()
        label.text = text
        label.frame.size = size
        // 文字を入れる箱の中心を設定。文字は初期値が左寄りなので文字数が違っても揃って見える
        label.center.x = centerX
        // インスタンスの起点(左上)の場所を指定
        label.frame.origin.y = y
        label.font = font
        label.textColor = color
        parentView.addSubview(label)
    }
}

