//
//  HealthCheckViewController.swift
//  CoronaApp
//
//  Created by 小早川　聖 on 2021/11/05.
//

import UIKit
import FSCalendar

class HealthCheckViewController: UIViewController {
    
    let colors = Colors()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGroupedBackground
        
        // スクロールビューを作成
        let  scrollView = UIScrollView()
        // 画面上のどの範囲をスクロールビューにしたいかを設定する。画面全体を指定
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        // 実際にスクロールする量を設定
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 950)
        view.addSubview(scrollView)
        
        // カレンダーの位置とサイズを設定
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 20, y: 10, width: view.frame.size.width - 40, height: 300)
        scrollView.addSubview(calendar)
        
        let checkLabel = UILabel()
        checkLabel.text = "健康チェック"
        checkLabel.textColor = colors.white
        checkLabel.frame = CGRect(x: 0, y: 340, width: view.frame.size.width, height: 21)
        checkLabel.backgroundColor = colors.blue
        checkLabel.textAlignment = .center
        checkLabel.center.x = view.center.x
        scrollView.addSubview(checkLabel)
        
        // 体調チェック部分を作成
        let uiView1 = createView(y: 380)
        scrollView.addSubview(uiView1)
        createImage(parentView: uiView1, imageName: "check1")
        createLabel(parentView: uiView1, text: "37.5度以上の熱がある")
        createUISwitch(parentView: uiView1, action: #selector(switchAction))
        let uiView2 = createView(y: 465)
        scrollView.addSubview(uiView2)
        createImage(parentView: uiView2, imageName: "check2")
        createLabel(parentView: uiView2, text: "のどの痛みがある")
        createUISwitch(parentView: uiView2, action: #selector(switchAction))
        let uiView3 = createView(y: 550)
        scrollView.addSubview(uiView3)
        createImage(parentView: uiView3, imageName: "check3")
        createLabel(parentView: uiView3, text: "匂いを感じない")
        createUISwitch(parentView: uiView3, action: #selector(switchAction))
        let uiView4 = createView(y: 635)
        scrollView.addSubview(uiView4)
        createImage(parentView: uiView4, imageName: "check4")
        createLabel(parentView: uiView4, text: "味が薄く感じる")
        createUISwitch(parentView: uiView4, action: #selector(switchAction))
        let uiView5 = createView(y: 720)
        scrollView.addSubview(uiView5)
        createImage(parentView: uiView5, imageName: "check5")
        createLabel(parentView: uiView5, text: "だるさがある")
        createUISwitch(parentView: uiView5, action: #selector(switchAction))
        
        // 診断完了ボタンを作成
        let resultButton = UIButton(type: .system)
        resultButton.frame = CGRect(x: 0, y: 820, width: 200, height: 40)
        resultButton.center.x = scrollView.center.x
        resultButton.titleLabel?.font = .systemFont(ofSize: 20)
        resultButton.layer.cornerRadius = 5
        resultButton.setTitle("診断完了", for: .normal)
        resultButton.setTitleColor(colors.white, for: .normal)
        resultButton.backgroundColor = colors.blue
        // 一度押したらボタンの内側でも外側でも発火するようにしている
        resultButton.addTarget(self, action: #selector(resultButtonAction), for: [.touchUpInside, .touchUpOutside])
        scrollView.addSubview(resultButton)
    }
    
    // 体調チェック部分の土台を作成するメソッド
    func createView(y: CGFloat) -> UIView  {
        let uiView = UIView()
        uiView.frame = CGRect(x: 20, y: y, width: view.frame.size.width - 40, height: 70)
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 0.3
        // 影のぼかしの強さ。0に近いと影がはっきりして、大きくなると広くモヤモヤする
        uiView.layer.shadowRadius = 4
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return uiView
    }
    // 体調チェック画像部分を設定するメソッド
    func createImage(parentView: UIView, imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.frame = CGRect(x: 10, y: 12, width: 40, height: 40)
        parentView.addSubview(imageView)
    }
    // 体調チェック部分の項目名を設定するメソッド
    func createLabel(parentView: UIView, text: String) {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 60, y: 15, width: 200, height: 40)
        parentView.addSubview(label)
    }
    // 体調チェック部分のスイッチを設定するメソッド。引数のSelector型は関数を受け取れる型
    func createUISwitch(parentView: UIView, action: Selector) {
        // UISwitchインスタンスを生成するだけで切り替えスイッチの画像が表示される
        let uiSwitch = UISwitch()
        uiSwitch.frame = CGRect(x: parentView.frame.size.width - 60, y: 20, width: 50, height: 30)
        uiSwitch.addTarget(self, action: action, for: .valueChanged)
        parentView.addSubview(uiSwitch)
    }
    // スイッチ切り替え処理をするメソッド。Selector型で呼び出すため@objcの記述が必要
    @objc func switchAction(sender: UISwitch) {
        // onかoffで処理が変わる。isOnメソッドによりonならtrue、offならfalseを受け取る。
        if sender.isOn {
            print("on")
        } else {
            print("off")
        }
    }
    // 診断完了ボタンを押したときの処理
    @objc func resultButtonAction() {
        print("resultButtonTapped")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
