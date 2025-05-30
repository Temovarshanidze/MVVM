

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        
    }
    
    func configureTabs() {
        
        
        
        /*
         let vc1 = MovieListViewController()
         let vc2 = FavoriteMoviesViewController()
         let vc3 = AnimationViewController()
         let vc4 = ProfileViewController()
         viewControllers = [
         UINavigationController(rootViewController: vc1),
         UINavigationController(rootViewController: vc2),
         UINavigationController(rootViewController: vc3),
         UINavigationController(rootViewController: vc4)
         ]
         */
        
        let moviesViewModel = MovieListViewModel()
        let vc1 = UINavigationController(rootViewController: MovieListViewController(viewModel: moviesViewModel))
        let vc2 = UINavigationController(rootViewController: FavoriteMoviesViewController(moviemodel: moviesViewModel))
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        
     
        
        vc1.tabBarItem.image = UIImage(systemName: "film")
        vc2.tabBarItem.image = UIImage(systemName: "star.fill")
        vc3.tabBarItem.image = UIImage(systemName: "person.circle")
        
        vc1.title = "Movies"
        vc2.title = "Favorites"
        vc3.title = "Profile"
        
        tabBar.tintColor = .orange
        tabBar.backgroundColor = .white
        // tabBar.barStyle = .black
        
        
        setViewControllers([vc1 , vc2 , vc3 ], animated: true)
    }
    
    
    
}
