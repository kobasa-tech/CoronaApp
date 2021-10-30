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
        
        // ボタンの高さ配置に使用する。親をviewとしてyの値を設定する。
        let height = view.frame.size.height / 2
        setUpButton("健康管理", size: size, y: height + 190, color: colors.yellowOrange, parent: view)
        setUpButton("県別状況", size: size, y: height + 240, color: colors.yellowOrange, parent: view)
        
        /* 表示する画像の名前と位置を引数にしている。
        引数でUIButtonが返されているので、ボタンのように.addTargetを使用できる。
        自分自身が(self)タップされたときに(for: .touchDown)に処理を呼び出す(action: #selector(chatAction)) */
        setUpImageButton("chat", x: view.frame.size.width - 50).addTarget(self, action: #selector(chatAction), for: .touchDown)
        setUpImageButton("reload", x: 10).addTarget(self, action: #selector(reloadAction), for: .touchDown)
    }
    // チャットボタンの設定
    func setUpImageButton(_ name: String, x: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: name), for: .normal) // 画像名を引数から取得
        button.frame.size = CGSize(width: 30, height: 30)
        button.tintColor = .white // 画像の色を変更
        button.frame.origin = CGPoint(x: x, y: 25)
        view.addSubview(button)
        return button
    }
    
    // リロードボタンが押されたときの処理。画面を更新している
    @objc func reloadAction() {
        print("リロード")
        loadView()
        viewDidLoad()
    }
    
    // チャットボタンが押されたときの処理
    @objc func chatAction() {
        print("タップchat")
    }
    
    
    // ボタンの設定
    func setUpButton(_ title: String, size: CGSize, y: CGFloat, color: UIColor, parent: UIView) {
        let button = UIButton(type: .system) // .systemでタップすると光るなどボタンとしての機能を持たせる
        button.setTitle(title, for: .normal) // .normalで通常のタイトルの状態を設定。他には.selectedなども
        button.frame.size = size
        button.center.x = view.center.x
        
        // NSAttributedStringは文字に装飾をするときに使う。文字間隔を設定した。
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.kern: 8.0])
        button.setAttributedTitle(attributedTitle, for: .normal) // 通常状態のタイトルの装飾を設定
        button.frame.origin.y = y
        button.setTitleColor(color, for: .normal) // 通常状態のタイトルの色を設定
        parent.addSubview(button)
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

