//
//  HealthCheckViewController.swift
//  CoronaApp
//
//  Created by 小早川　聖 on 2021/11/05.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic // 日本の祝日判定をBool型で返してくれるメソッドがある

class HealthCheckViewController: UIViewController {
    
    let colors = Colors()
    var point = 0
    var today = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGroupedBackground
        today = dateFormatter(day: Date()) // 今日の日付のフォーマットを変換して取得
        
        // スクロールビューを作成
        let  scrollView = UIScrollView()
        // 画面上のどの範囲をスクロールビューにしたいかを設定する。画面全体を指定
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        // 実際にスクロールする量を設定
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 950)
        view.addSubview(scrollView)
        
        // カレンダーの設定
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 20, y: 10, width: view.frame.size.width - 40, height: 300)
        scrollView.addSubview(calendar)
        // カレンダーの月の色を設定
        calendar.appearance.headerTitleColor = colors.blue
        // カレンダーの週の色を設定
        calendar.appearance.weekdayTextColor = colors.blue
        // FSCalendarのdelegateに自信を代入して登録された関数と紐付けを行う
        calendar.delegate = self
        
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
            point += 1
        } else {
            point -= 1
        }
        print("point:\(point)")
    }
    // 診断完了ボタンを押したときの処理
    @objc func resultButtonAction() {
        /* アラートを出す。UIAlertControllerがベースになる。タイトルとメッセージを表示。
        preferredStyleでアラートの出現方法を設定。.actionSheetで画面下部。.alertで画面中央 */
        let alert = UIAlertController(title: "診断を完了しますか", message: "診断は1日に1回までです", preferredStyle: .actionSheet)
        /* 完了アクションの記述。style: .defaultで青いボタン。完了ボタンを押した後の処理をhandler以降に記述。
         handler: { action in この記述方法をクロージャと言い、クロージャ内では外部からの参照にはselfをつける */
        let yesAction = UIAlertAction(title: "完了", style: .default, handler: { action in
            // ポイントによって表示するタイトルとメッセージを変化させる
            var resultTitle = ""
            var resultMessage = ""
            if self.point >= 4 {
                resultTitle = "高"
                resultMessage = "感染している可能性が\n比較的高いです。\nPCR検査をしましょう。"
            } else if self.point >= 2 {
                resultTitle = "中"
                resultMessage = "やや感染している可能性が\nあります。外出は控えましょう。"
            } else {
                resultTitle = "低"
                resultMessage = "感染している可能性は\n今のところ低いです。\n今後も気をつけましょう。"
            }
            // preferredStyle: .alertで画面中央にアラートを表示
            let alert = UIAlertController(title: "感染している可能性「\(resultTitle)」", message: resultMessage, preferredStyle: .alert)
            self.present(alert, animated: true, completion: {
                /* DispatchQueueは本来自動で割り当てられるスレッドを手動で操作するもの。スレッドの切り替えや遅延処理に使用する。
                 2秒後にアラートが消える記述*/
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // 2秒後の処理を記述。dismissで表示を消している。クロージャ内なのでself付き
                    self.dismiss(animated: true, completion: nil)
            }
            })
        })
        // キャンセルアクションの記述。style: .destructiveで赤いボタン。アラート画面を閉じるだけなのでhandler: nil
        let noAction = UIAlertAction(title: "キャンセル", style: .destructive, handler: nil)
        // 完了アクションとキャンセルアクションをコントローラーに追加する
        alert.addAction(yesAction)
        alert.addAction(noAction)
        // アラートを表示する処理。第一引数に表示するアラート、第二引数にアニメーション表示の有無、第三引数に表示した後の処理
        present(alert, animated: true, completion: nil)
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

// FSCalendarの日付部分の設定。Delegateを利用して設定する。extensionはクラスの外に書く！
extension HealthCheckViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .clear // マスの色(背景色)
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        /* 今日の日付マスの枠線の色を変更
         左辺の引数dateはFSCalendarの関数から渡され、表示する月の日数+aの数だけ呼ばれる。
         右辺の引数Date()でインスタンスを生成すると今日の日付が生成される->変数todayで設定している */
        if dateFormatter(day: date) == today {
            return colors.bluePurple
        }
        // if Calendar.current.isDateInToday(date){return colors.bluePurple}でも同じ結果
        
        return .clear
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 0.5 // 角丸の度合い
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        // 曜日によって文字色を変更
        if judgeWeekday(date) == 1 { // 日曜日の場合
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        } else if judgeWeekday(date) == 7 { // 土曜日の場合
            return UIColor(red: 0/255, green: 30/255, blue: 150/255, alpha: 0.9)
        }
        // 祝日なら(関数の返り値がtrue)文字色を変更
        if judgeHoliday(date) {
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        }
        return colors.black // それ以外の曜日の文字色
    }
    
    // ロジックのための自作関数
    func dateFormatter(day: Date) -> String {
        let formatter = DateFormatter()
        // 日付のフォーマットを変更している。変更しないと時間などが入ってしまい条件式に使いづらいため。MMは大文字にする必要がある
        formatter.dateFormat = "yyyy-MM-dd"
        // 引数で受け取った日付のフォーマットを変換して返している。
        return formatter.string(from: day)
    }

    // 曜日判定(日曜日：1/土曜日：7)
    func judgeWeekday(_ date: Date) -> Int {
        // identifier: .gregorianを引数にしてカレンダーのインスタンスを作成できる。グレゴリオ歴という西暦の日付設定。
        let calendar = Calendar(identifier: .gregorian)
        // 第二引数の日付情報から第一引数で指定した情報を返してくれる(日曜日：1/土曜日：7)
        return calendar.component(.weekday, from: date)
    }
    
    // 祝日かどうかを判定する処理
    func judgeHoliday(_ date: Date) -> Bool {
        // Calendarインスタンスを生成してcomponentでInt型の年・月・日を取得
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        // judgeJapaneseHolidayメソッドに渡して祝日ならtrue、祝日でないならfalseを返す
        let holiday = CalculateCalendarLogic()
        let judgeHoliday = holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        return judgeHoliday
    }
}

