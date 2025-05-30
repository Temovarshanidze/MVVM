
import Foundation

class SaveData {
    
    enum UserDefaultKey: String {
        case movies
    }
    // შენახვა
    func saveMoviesToLocalStorage(_ movies: [MovieModel]) {
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: UserDefaultKey.movies.rawValue)
        }
    }
    //წაკითხვა
    func loadMoviesFromLocalStorage() -> [MovieModel] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultKey.movies.rawValue),
              let movies = try? JSONDecoder().decode([MovieModel].self, from: data)
        else {
            return []
        }
        return movies
    }
    //წაშლა
    func clearSavedMovies() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.movies.rawValue)
        print("🗑️ Saved movies cleared from local storage.")
    }
}
