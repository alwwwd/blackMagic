import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .systemBlue
        tabBar.barStyle = .black
        tabBar.isTranslucent = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        overrideUserInterfaceStyle = .dark
        showOnboardingIfNeeded()

    }
    
    private func showOnboardingIfNeeded() {
            // Проверяем, был ли онбординг уже пройден
            let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        
            guard !hasCompletedOnboarding else { return }
    
            let title: NSString = "Welcome to BoosterCraft"
            let detailText: NSString = ""
            let welcomeController = OBWelcomeController(title: title, detailText: detailText, symbolName: "wand.and.stars")
            
            welcomeController.addBulletedListItem(
                title: "MTG boosters here",
                description: "Virtual versions of Magic: the Gathering packs available",
                symbolName: "sparkles.rectangle.stack"
            )
    
            welcomeController.addBulletedListItem(
                title: "Buy and open packs for free",
                description: "Get virtual currency every day",
                symbolName: "infinity"
            )
    
            welcomeController.addBulletedListItem(
                title: "Sell and trade your cards",
                description: "Exchange them for currency or make deals with players",
                symbolName: "arrow.left.arrow.right"
            )
    
            welcomeController.addBoldButton(title: "Get Started") {
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                self.dismiss(animated: true)
            }
    
            present(welcomeController.viewController, animated: true)
        }

//    
    
    
    // MARK: - Setup Tabs
    
    private func setupTabs() {
        let mainVC = MainViewController()
        let boostersVC = OpenBoostersViewController()
        let collectionVC = MyCollectionViewController()
        let dailyRewardVC = DailyRewardViewController() // Новая вкладка
        
        mainVC.tabBarItem = UITabBarItem(title: "Buy boosters", image: UIImage(systemName: "cart.fill"), tag: 0)
        boostersVC.tabBarItem = UITabBarItem(title: "Open boosters", image: UIImage(systemName: "gift.fill"), tag: 1)
        collectionVC.tabBarItem = UITabBarItem(title: "My collection", image: UIImage(systemName: "book.fill"), tag: 2)
        dailyRewardVC.tabBarItem = UITabBarItem(title: "Daily Reward", image: UIImage(systemName: "star.fill"), tag: 3)
        
        viewControllers = [
            UINavigationController(rootViewController: boostersVC),
            UINavigationController(rootViewController: mainVC),
            UINavigationController(rootViewController: collectionVC),
            UINavigationController(rootViewController: dailyRewardVC) // Добавляем новую вкладку
        ]
        
        selectedIndex = 1
    }
}
