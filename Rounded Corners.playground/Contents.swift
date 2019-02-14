import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    var cardView: UIView!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .black
        
        cardView = UIView()
        view.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cardView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.7176470588, blue: 0, alpha: 1)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 平常會用的方法，設定四邊圓角
//        cardView.roundCorners(cornerRadius: 20.0)
        
        // iOS 11 提供的新屬性
        cardView.specific(cornerRadious: 20.0)
        
        // 點擊事件
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateCornerChange(recognizer:)))
        
        cardView.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        // iOS 10 以下的作法
//        cardView.pathCorners(cornerRadious: 20.0)
    }
    
    
    @objc func animateCornerChange(recognizer: UITapGestureRecognizer) {
        let targetRadioud: CGFloat = (cardView.layer.cornerRadius == 0) ? 100.0 : 0.0
        
        // 使用 UIViewPropertyAnimator 來建立動畫
        UIViewPropertyAnimator(duration: 1.0, curve: .easeOut) {
            self.cardView.layer.cornerRadius = targetRadioud
        }.startAnimation()
    }
    
}

extension UIView {
    
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
    func specific(cornerRadious: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadious)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func pathCorners(cornerRadious: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadious, height: cornerRadious))
        
        // 建立一個形狀圖層作為 Mask
        let masklayer = CAShapeLayer()
        masklayer.frame = self.bounds
        masklayer.path = path.cgPath
        
        // 覆蓋原本 mask 圖層
        self.layer.mask = masklayer
        
    }
    
}


// Present the view controller in the Live View window

PlaygroundPage.current.liveView = MyViewController()
