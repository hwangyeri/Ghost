//
//  SwipeViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/20.
//

import UIKit
import Tabman
import Pageboy

final class SwipeViewController: TabmanViewController {
    
    private var viewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
    }
    
    private func configureLayout() {
        let firstVC = FirstSwipeViewController()
        let secondVC = SecondSwipeViewController()
        
        viewControllers = [firstVC, secondVC]
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .intrinsic
        bar.layout.alignment = .centerDistributed
        bar.layout.interButtonSpacing = view.bounds.width / 4
        bar.buttons.customize {
            $0.tintColor = .lightGray
            $0.selectedTintColor = .white
            $0.selectedFont = UIFont.customFont(.semiBold, size: .L)
            $0.font = UIFont.customFont(.regular, size: .M) ?? UIFont.systemFont(ofSize: 13, weight: .regular)
            
        }
        bar.backgroundView.style = .blur(style: .dark)
        bar.indicator.weight = .custom(value: 3)
        bar.indicator.tintColor = .white
        bar.indicator.overscrollBehavior = .bounce
        
        addBar(bar, dataSource: self, at: .top)
    }
    
}

extension SwipeViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let item = TMBarItem(title: "")
        let title: String = index == 0 ? "게시글" : "좋아요"
        item.title = title
        
        return item
    }
    
}
