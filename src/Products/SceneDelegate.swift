//
//  SceneDelegate.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        Task {
            let loginData = LoginDataDto(login: "aasdasd", password: "adsasdasd")
            let token = try await MockRegistrationService().sendLoginRequestAsync(loginData: loginData)
            _ = TokenService(loginData: loginData, token: token)
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = getRootNavigationController()
            window?.makeKeyAndVisible()
        }
    }
    
    /// Получить корневой контроллер навигации.
    ///
    /// - Returns: Корневой контроллер навигации
    func getRootNavigationController() -> UINavigationController {
        let rootView = NearestStoresView()
        let navigationController = UINavigationController(rootViewController: rootView)
        
        let navigationBarAppearence = getNavigationBarAppearence()
        navigationController.navigationBar.standardAppearance = navigationBarAppearence
        navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearence
        
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.tintColor = Constants.textColor
        
        return navigationController
    }
    
    /// Получить оформление навигационной панели.
    ///
    /// - Returns: Оформление навигационной панели.
    func getNavigationBarAppearence() -> UINavigationBarAppearance {
        let navigationBarAppearence = UINavigationBarAppearance()
        
        let imageAlignmentRectInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        let navigationBackButtonImage = UIImage(systemName: "chevron.backward")?.withAlignmentRectInsets(imageAlignmentRectInsets)
        
        navigationBarAppearence.setBackIndicatorImage(navigationBackButtonImage, transitionMaskImage: navigationBackButtonImage)
        navigationBarAppearence.backButtonAppearance = getNavigationBarBackButtonAppearence()
        navigationBarAppearence.titleTextAttributes = getNavigationBarTitleTextAttributes()
        
        return navigationBarAppearence
    }
    
    /// Получить оформление кнопки "Назад" панели навигации.
    ///
    /// - Returns: Оформление кнопки "Назад" панели навигации.
    func getNavigationBarBackButtonAppearence() -> UIBarButtonItemAppearance {
        let backButtonAppearence = UIBarButtonItemAppearance()
        backButtonAppearence.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        return backButtonAppearence
    }
    
    /// Получить атрибуты текста заголовка панели навигации.
    ///
    /// - Returns: Получить атрибуты текста заголовка панели навигации.
    func getNavigationBarTitleTextAttributes() -> [NSAttributedString.Key : Any] {
        let titleAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: Constants.textColor,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        return titleAttributes
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
