//
//  NetworkManger.swift
//  finalProject
//
//  Created by Иван Евсеев on 03.01.2023.
//

import Foundation
import Alamofire

class NetworkManager {
   
    static var networkManager = NetworkManager()
    
    
// MAIN VIEW CONTROLLER
    func getGenres(mediaType: String, completition: @escaping ([Genre]) -> Void) {

        let genresRequest = AF.request("https://api.themoviedb.org/3/genre/\(mediaType)/list?api_key=\(apiKey)&language=en-US", method: .get)
        
        genresRequest.responseDecodable(of: Genres.self) { response in
            do {
                if mediaType == "movie" {
                    let data = try response.result.get().genres
                    completition(data)
                } else {
                    let data = try response.result.get().genres
                    completition(data)
                }
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    func getTrandingMovies(completion: @escaping ([MovieResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/trending/movie/day?api_key=de2fa60445b65225004497a21552b0ce", method: .get)
            genresRequest.responseDecodable(of: Movies.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    func getTrandingSeries(completion: @escaping ([SeriesResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/trending/tv/day?api_key=de2fa60445b65225004497a21552b0ce", method: .get)
            genresRequest.responseDecodable(of: Series.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    
    func getPopularMovies(completion: @escaping ([MovieResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/movie/popular?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&page=1", method: .get)
            genresRequest.responseDecodable(of: Movies.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    func getPopularSeries(completion: @escaping ([SeriesResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/tv/popular?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&page=1", method: .get)
            genresRequest.responseDecodable(of: Series.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    
    func getUpcomingMovies(completion: @escaping ([MovieResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&page=1", method: .get)
            genresRequest.responseDecodable(of: Movies.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    func getUpcomingSeries(completion: @escaping ([SeriesResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/tv/airing_today?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&page=1", method: .get)
            genresRequest.responseDecodable(of: Series.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    
    func getTopRatedMovies(completion: @escaping ([MovieResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&page=1", method: .get)
            genresRequest.responseDecodable(of: Movies.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    func getTopRatedSeries(completion: @escaping ([SeriesResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/tv/top_rated?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&page=1", method: .get)
            genresRequest.responseDecodable(of: Series.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }

        }
    
    // AUTHENTIFICATION VC
    func getToken(completion: @escaping(String) -> Void){
        let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/token/new?api_key=de2fa60445b65225004497a21552b0ce", method: .get)
        genresRequest.responseDecodable(of: Token.self) { response in
            do {
                let data = try response.result.get()
                completion(data.requestToken ?? "")
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    func doTokenValidate(username: String, password: String, token: String, completion: @escaping(Token) -> Void) {
        let userParams: Parameters = [
            "username": username,
            "password": password,
            "request_token": token
        ]
        let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=de2fa60445b65225004497a21552b0ce", method: .post, parameters: userParams, headers: nil)
        genresRequest.responseDecodable(of: Token.self) { response in
            do {
                    
                let data = try response.result.get()
                completion(data)
                
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    
    func makeSession(token: String, completion: @escaping(SessionId) -> Void) {
        let params: Parameters = [
            "request_token": token
        ]
        let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/session/new?api_key=de2fa60445b65225004497a21552b0ce", method: .post, parameters: params)
        
        genresRequest.responseDecodable(of: SessionId.self) { response in
            do {
                let data = try response.result.get()
                completion(data)
                
                print("DLFDLSKFJLKD" + String(data.success))
                print("LDJAFLKDJAFLKJAf")
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    
    func createSession(requestToken: String, completion: @escaping (SessionId) -> Void) {
            let parameters: [String: Any] = [
              "request_token": requestToken
            ]
            let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/session/new?api_key=de2fa60445b65225004497a21552b0ce", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            genresRequest.responseDecodable(of: SessionId.self) { response in
                do {
                    let data = try response.result.get()
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }
        }
    
    func getDetails(sessionID: String, completion: @escaping(Int) -> Void) {

        let genresRequest = AF.request("https://api.themoviedb.org/3/account?api_key=de2fa60445b65225004497a21552b0ce&session_id=\(sessionID)", method: .get)
        
        genresRequest.responseDecodable(of: AccountID.self) { response in
            do {
                let data = try response.result.get()
                completion(data.id ?? 0)
                
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    func guestSession(completion: @escaping(Bool) -> Void){
        let genresRequest = AF.request("https://api.themoviedb.org/3/authentication/guest_session/new?api_key=de2fa60445b65225004497a21552b0ce", method: .get)
        genresRequest.responseDecodable(of: GuestSession.self) { response in
            do {
                let data = try response.result.get()
                completion(data.success)
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    // GENRE VIEWCONROLLER
    
    func getMovieGenreMedia(genreID: Int, completion: @escaping ([MovieResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/discover/movie?api_key=de2fa60445b65225004497a21552b0ce&with_genres=\(genreID)", method: .get)

            genresRequest.responseDecodable(of: Movies.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }
        
        }
    
    func getSeriesGenreMedia(genreID: Int, completion: @escaping ([SeriesResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/discover/tv?api_key=de2fa60445b65225004497a21552b0ce&with_genres=\(genreID)", method: .get)

            genresRequest.responseDecodable(of: Series.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }
        
        }
        
    // SEARCH VC
    
    func searchMovies(query: String, completion: @escaping ([MovieResult]) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let movieRequest = AF.request("https://api.themoviedb.org/3/search/movie?api_key=de2fa60445b65225004497a21552b0ce&page=1&query=\(query)", method: .get)
        movieRequest.responseDecodable(of: Movies.self) { responce in
            do {
                let data = try responce.result.get().results
                completion(data)
                
            } catch {
                print(error)
            }
        }
        
    }
        
    func searchSeries(query: String, completion: @escaping ([SeriesResult]) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let movieRequest = AF.request("https://api.themoviedb.org/3/search/tv?api_key=de2fa60445b65225004497a21552b0ce&page=1&query=\(query)", method: .get)
        movieRequest.responseDecodable(of: Series.self) { responce in
            do {
                let data = try responce.result.get().results
                completion(data)
                
            } catch {
                print(error)
            }
        }
        
    }
    
    // WATCHLIST VIEWCONTROLLER
    
    func getMoviesWatchlist(completion: @escaping ([MovieResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist/movies?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&session_id=\(sessionID)&sort_by=created_at.asc&page=1", method: .get)
                genresRequest.responseDecodable(of: Movies.self) { response in
                    do {
                        let data = try response.result.get().results
                        completion(data)

                    }
                    catch {
                        print("error: \(error)")
                    }
                }
        }
    func getSeriesWatchlist(completion: @escaping ([SeriesResult]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist/tv?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&session_id=\(sessionID)&sort_by=created_at.asc&page=1", method: .get)
                genresRequest.responseDecodable(of: Series.self) { response in
                    do {
                        let data = try response.result.get().results
                        completion(data)

                    }
                    catch {
                        print("error: \(error)")
                    }
                }
        }

    
    func deleteFromWatchlist(mediaId: Int, mediaType: String, completion: @escaping () -> Void) {
            let params: Parameters = [
                "media_type": mediaType,
                "media_id": mediaId,
                "watchlist": false
              ]
        let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist?api_key=de2fa60445b65225004497a21552b0ce&session_id=\(sessionID)", method: .post, parameters: params, encoding: JSONEncoding.default)
            genresRequest.responseDecodable(of: WatchList.self) { response in }
        }

    // FILM VC
    
    func getTrailers(mediaID: Int, mediaType: String, completion: @escaping([Trailer]) -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/\(mediaType)/\(mediaID)/videos?api_key=de2fa60445b65225004497a21552b0ce&language=en-US", method: .get)
            genresRequest.responseDecodable(of: Trailers.self) { response in
                do {
                    let data = try response.result.get().results
                    completion(data)
                }
                catch {
                    print("error: \(error)")
                }
            }
        }
    
    func addToWatchList(mediaType: String, mediaID: Int) {
            let params: Parameters = [
                "media_type": mediaType,
                "media_id": mediaID,
                "watchlist": true
              ]
            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist?api_key=de2fa60445b65225004497a21552b0ce&session_id=\(sessionID)", method: .post, parameters: params)
            genresRequest.responseDecodable(of: WatchList.self) { response in }
        }
    
}
