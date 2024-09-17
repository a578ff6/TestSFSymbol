//
//  ViewController.swift
//  TestSFSymbol
//
//  Created by 曹家瑋 on 2024/9/17.
//


/*
 ## SF Symbols 動畫與過渡效果
    - 用途與情境： 當圖像切換或按鈕需要動畫效果時，如何通過 setSymbolImage 或 addSymbolEffect 達到效果。
    - 特別注意： 在 UINavigationBar 中使用 SF Symbols 動畫時，必須嵌入 UIButton 中才能實現動畫效果。（重要）
    （當要在導航欄按鈕使用 SF Symbols 並且實現動畫效果時，必須將按鈕從 `UIBarButtonItem` 替換為 `UIButton`，因為 `UIBarButtonItem` 無法直接應用動畫效果。）
 
 1. setSymbolImage(contentTransition:)
    * 用途： 負責 SF Symbols 圖像之間的切換，並提供過渡效果（例如 .replace、.fade、.scale 等）。
    * 使用情境： 當需要從一個 SF Symbol 圖片換成另一個時（如從 heart 切換成 heart.fill），並希望過渡效果更加平滑。
    * 範例： button.imageView?.setSymbolImage(UIImage(systemName: "heart.fill")!, contentTransition: .replace)

 2. addSymbolEffect
    - 用途： 為 SF Symbols 添加動態效果，如彈跳（bounce）、脈衝（pulse）、縮放（scale）等，適用於圖像不變但需要增加動畫的情境。
    - 使用情境： 當你不打算更換 SF Symbol 圖像，但希望為當前的圖像添加動態效果（例如按鈕點擊後，讓圖像跳動或脈衝）。
    - 範例： button.imageView?.addSymbolEffect(.pulse)

 3. 兩者的區別：
    - setSymbolImage： 用於圖像切換時的過渡效果，適合在圖像之間轉換時使用，並可以控制切換動畫效果。
    - addSymbolEffect： 用於為當前圖像增加特效或動態效果，適合當你不需要更換圖像，但想讓圖像看起來更生動。

 4. 實作範例：
    - 若想要同時進行圖像切換和添加動畫效果，可以這樣組合使用：
      button.imageView?.setSymbolImage(UIImage(systemName: "heart.fill")!, contentTransition: .replace)
      button.imageView?.addSymbolEffect(.pulse)
*/

// MARK: - setSymbolImage、addSymbolEffect（UIButton）
/*
import UIKit

class ViewController: UIViewController {

    let heartButton = UIButton(type: .system)
    let shareButton = UIButton(type: .system)
    var isLiked = false
    var heartImage: UIImage?
    var heartFillImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化 heart 和 heart.fill 圖片
        heartImage = UIImage(systemName: "heart")
        heartFillImage = UIImage(systemName: "heart.fill")
        
        // 初始化按鈕
        setupButton(heartButton, image: heartImage!, position: CGPoint(x: 100, y: 100), action: #selector(didTapHeartButton))
        setupButton(shareButton, image: UIImage(systemName: "square.and.arrow.up")!, position: CGPoint(x: 100, y: 250), action: #selector(didTapShareButton))
    }
    
    /// 設置按鈕
    func setupButton(_ button: UIButton, image: UIImage, position: CGPoint, action: Selector) {
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: position.x, y: position.y, width: 100, height: 100)
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    // MARK: - Action
    
    /// 為點擊愛心按鈕添加replace動畫效果
    @objc func didTapHeartButton() {
        isLiked.toggle()
        let newImage = isLiked ? heartFillImage : heartImage            // 獲取新的圖片
        animateButton(heartButton, newImage: newImage!)
    }
    
    // 為分享按鈕添加 bounce 效果
    @objc func didTapShareButton() {
        animateBounceEffect(shareButton)
    }
    
    // MARK: - Helper Methods
    
    /// 按鈕圖片切換和動畫的邏輯
    func animateButton(_ button: UIButton, newImage: UIImage) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // 放大動畫
        }, completion: { _ in
            button.imageView?.setSymbolImage(newImage, contentTransition: .replace)
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity // 恢復原來大小
            }
        })
    }
    
    /// 按鈕的 bounce 動畫
    func animateBounceEffect(_ button: UIButton) {
        button.imageView?.addSymbolEffect(.bounce)
    }

}
*/



// MARK: - 單獨展示 addSymbolEffect 範例（UIButton）
/*
import UIKit

class ViewController: UIViewController {

    /// 分享按鈕
    let shareButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton(shareButton, image: UIImage(systemName: "square.and.arrow.up")!, position: CGPoint(x: 100, y: 250), action: #selector(didTapShareButton))
    }
    
    /// 設置按鈕
    func setupButton(_ button: UIButton, image: UIImage, position: CGPoint, action: Selector) {
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: position.x, y: position.y, width: 100, height: 100)
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
    
    // MARK: - Action
    
    /// 點擊分享按鈕，添加 bounce 動畫效果
    @objc func didTapShareButton() {
        animateBounceEffect(shareButton)
    }
    
    // MARK: - Helper Methods
    
    /// 按鈕的 bounce 動畫
    func animateBounceEffect(_ button: UIButton) {
        button.imageView?.addSymbolEffect(.bounce) // 添加彈跳動畫效果
    }
}
*/


// MARK: - 單獨展示 setSymbolImage 範例（UIButton）
/*
import UIKit

class ViewController: UIViewController {

    let heartButton = UIButton(type: .system) // 定義愛心按鈕
    var isLiked = false
    var heartImage: UIImage?
    var heartFillImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // heart 和 heart.fill 圖片
        heartImage = UIImage(systemName: "heart")
        heartFillImage = UIImage(systemName: "heart.fill")
        
        setupButton(heartButton, image: heartImage!, position: CGPoint(x: 100, y: 100), action: #selector(didTapHeartButton))
    }
    
    /// 設置按鈕
    func setupButton(_ button: UIButton, image: UIImage, position: CGPoint, action: Selector) {
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: position.x, y: position.y, width: 100, height: 100)
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
    
    // MARK: - Action
    
    /// 點擊愛心按鈕，觸發圖標替換動畫
    @objc func didTapHeartButton() {
        isLiked.toggle()
        let newImage = isLiked ? heartFillImage : heartImage            // 獲取新的圖片
        animateButton(heartButton, newImage: newImage!)
    }
    
    // MARK: - Helper Methods
    
    /// 按鈕圖片切換和動畫的邏輯
    func animateButton(_ button: UIButton, newImage: UIImage) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // 放大動畫
        }, completion: { _ in
            button.imageView?.setSymbolImage(newImage, contentTransition: .replace) // 圖片替換過渡效果
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity // 恢復原來大小
            }
        })
    }
}
*/


// MARK: - setImage、addSymbolEffect（navigationItem）
import UIKit

class ViewController: UIViewController {

    var isLiked = false
    var heartImage: UIImage?
    var heartFillImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化 heart 和 heart.fill 圖片
        heartImage = UIImage(systemName: "heart")
        heartFillImage = UIImage(systemName: "heart.fill")

        // 設置 NavigationBar 上的按鈕
        setupNavigationBarButtons()
    }
    
    /// 設置 NavigationBar 上的分享和我的最愛按鈕
    func setupNavigationBarButtons() {
        let shareBarButton = createShareButton()
        let favoriteBarButton = createFavoriteButton()
        
        // 將兩個按鈕添加到 NavigationBar
        navigationItem.rightBarButtonItems = [shareBarButton, favoriteBarButton]
    }
    
    // MARK: - Create UIBarButtonItems
    
    /// 創建分享按鈕
    func createShareButton() -> UIBarButtonItem {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "square.and.arrow.up")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let shareButton = UIButton(configuration: config)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return UIBarButtonItem(customView: shareButton)
    }
    
    /// 創建我的最愛按鈕
    func createFavoriteButton() -> UIBarButtonItem {
        var config = UIButton.Configuration.plain()
        config.image = heartImage
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let favoriteButton = UIButton(configuration: config)
        favoriteButton.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return UIBarButtonItem(customView: favoriteButton)
    }
    
    // MARK: - Action
    
    /// 點擊我的最愛按鈕時，切換圖標並添加動畫
    @objc func didTapHeartButton() {
        isLiked.toggle()
        let newImage = isLiked ? heartFillImage : heartImage
        if let favoriteButton = navigationItem.rightBarButtonItems?[1].customView as? UIButton {
            animateButton(favoriteButton, newImage: newImage!)
        }
    }
    
    /// 點擊分享按鈕時，添加彈跳動畫
    @objc func didTapShareButton() {
        if let shareButton = navigationItem.rightBarButtonItems?[0].customView as? UIButton {
            animateBounceEffect(shareButton)
        }
    }
    
    // MARK: - Helper Methods
    
    /// 按鈕圖片切換和動畫的邏輯
    func animateButton(_ button: UIButton, newImage: UIImage) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // 放大動畫
        }, completion: { _ in
            button.setImage(newImage, for: .normal) // 直接替換按鈕圖片
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity // 恢復原來大小
            }
        })
    }
    
    /// 按鈕的 bounce 動畫
    func animateBounceEffect(_ button: UIButton) {
        button.imageView?.addSymbolEffect(.bounce)
    }

}


