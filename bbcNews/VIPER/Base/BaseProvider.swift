//
//  BaseProvider.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import UIKit
import Alamofire

enum ProviderType: Int {
    
    case json = 0
    case xml = 1
    case text = 2
}

enum ProviderSubType: Int {
    
    case dictionary = 0
    case array = 1
    case number = 2
    case status = 3
}

struct ProviderDTO {
    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var method: HTTPMethod
    var endpoint: String
    
    init(params: [String: Any]?,
         method: HTTPMethod,
         endpoint: String) {
        
        self.params = params
        self.method = method
        self.endpoint = endpoint
    }
    
    init(arrayParams: [[String: Any]]?,
         method: HTTPMethod,
         endpoint: String) {
        
        self.arrayParams = arrayParams
        self.method = method
        self.endpoint = endpoint
    }
}

class BaseProvider: NSObject {
    
    var type: ProviderType = .json
    var subType: ProviderSubType = .dictionary
    var task: URLSessionTask?
    
    // Autenticación de los servicios de la app
    static func getAuthorizationHeader() -> [String: String] {
        
        let username = UserDefaults.standard.string(forKey: "GraylogUser") ?? ""
        let password = UserDefaults.standard.string(forKey: "GraylogPassword") ?? ""
        
        let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        return ["Authorization": "Basic \(credentialData.base64EncodedString(options: []))"]
    }
    
    private var manager: Alamofire.SessionManager!
    private func createManager(timeout: TimeInterval) -> Alamofire.SessionManager {
        
        // Creamos las políticas de confianza del servidor.
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        // Creamos el manager personalizado.
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let manager = Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }
    
    // MARK: INTERNAL
    
    internal func getProviderData(dto: ProviderDTO,
                                  timeout: TimeInterval = 60,
                                  loader: Bool = true,
                                  baseURL: String,
                                  additionalHeader: [ String: String] = [:],
                                  success: @escaping(Data) -> Void,
                                  failure: @escaping(NSError) -> Void) -> URLSessionTask? {
        
        let endpoint = "\(baseURL)\(dto.endpoint)"
        
        var headers: [String: String] = ["Content-Type": "application/json"]
        
        //se añaden nuevas cabeceras si el parametro viene lleno. por defecto es nil i es opcional.
        if additionalHeader.count > 0 {
            for item in additionalHeader {
                headers[item.key] = item.value
            }
        }
        
        if loader {
            
            BBCNewsLoader.showProgressHud(fullScreen: true)
        }
        
        // Crea el manager, en la primera ejecución del provider, o cuando el timeout se modifica.
        if self.manager == nil ||
            self.manager.session.configuration.timeoutIntervalForRequest != timeout {
            
            self.manager = self.createManager(timeout: timeout)
        }
        
        let request = self.manager.request(endpoint,
                                           method: dto.method,
                                           
                                           parameters: dto.params,
                                           encoding: (dto.method == .post || dto.method == .put || dto.method == .patch) && dto.arrayParams == nil ? JSONEncoding.default : CustomGetEncoding(arrayParams: dto.arrayParams),
                                           headers: headers)
        request.authenticate(user: UserDefaults.standard.string(forKey: "GraylogUser") ?? "", password: UserDefaults.standard.string(forKey: "GraylogPassword") ?? "")
        
        let data = dto.arrayParams != nil
            ? try? JSONSerialization.data(withJSONObject: (dto.arrayParams ?? [:]), options: .prettyPrinted)
            : try? JSONSerialization.data(withJSONObject: (dto.params ?? []), options: .prettyPrinted)
        print("*************************** LLAMADA ALAMOFIRE ***************************")
        print("Fecha LLamada: \(Date().format(format: "dd/MM/yyyy-HH:mm:ss"))")
        print("URL: \(endpoint)")
        print(String(data: data ?? Data(), encoding: .utf8) ?? "")
        print("*************************** FIN ***************************")
        
        /* Esta comporbación es necesaria porque en estos dos servicios la llamada se hace al mismo tiempo,
         * y al ser de tipos distintos (JSON y array) el que llegue antes le cambia el tipo del provider al otro
         */
        if self.type == .json {
            
            request.responseJSON { response in
                
                if (200..<300).contains(response.response?.statusCode ?? 0) {
                    // Gestión del caso correcto
                    
                    self.hideLoader(loader: loader)
                    // Se obtiene la respuesta.
                    guard let data = response.data else {
                        // Si la respuesta no tiene datos, se devuelve un error.
                        self.apiResponseError(loader: loader,
                                              response: response,
                                              failure: failure)
                        return
                    }
                    
                    print("*************************** RESPUESTA ALAMOFIRE ***************************")
                    print("Fecha Respuesta: \(Date().format(format: "dd/MM/yyyy-HH:mm:ss"))")
                    print("URL: \(endpoint)")
                    print(String(data: data, encoding: .utf8) ?? "")
                    print("*************************** ACABADA ***************************")
                    
                    success(data)
                    
                } else {
                    
                    // Si no se trata de un 200
                    
                    if let error = response.result.error as NSError? {
                        
                        print("*************************** RESPUESTA ALAMOFIRE ***************************")
                        print("Fecha Respuesta: \(Date().format(format: "dd/MM/yyyy-HH:mm:ss"))")
                        print("URL: \(endpoint)")
                        print(NSError(domain: "BBCNews", code: error.code, userInfo: nil))
                        print("*************************** ACABADA ***************************")
                    }
                    
                    self.hideLoader(loader: loader)
                    self.apiResponseError(loader: loader,
                                          response: response,
                                          failure: failure)
                    return
                }
            }
        } else {
            
            print("\nURL: \(endpoint)")
            print("\nParámetros: \(String(describing: dto.params))")
            
            request.responseString { response in
                
                self.hideLoader(loader: loader)
                
                if response.response?.statusCode == 200 {
                    
                    guard let jsonData = self.convertToDictionary(text: response.result.value ?? ""),
                        let data = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted) else {
                            
                            self.apiResponseError(loader: loader,
                                                  response: response,
                                                  failure: failure)
                            return
                            
                    }
                    
                    success(data)
                    
                } else {
                    
                    self.apiResponseError(loader: loader,
                                          response: response,
                                          failure: failure)
                    return
                }
            }
        }
        
        self.task = request.task
        return request.task
    }
    
    /// Oculta el cargando, en caso de que se haya especificado que lo tenga.
    private func hideLoader(loader: Bool) {
        
        if loader {
            BBCNewsLoader.hideProgressHud()
        }
    }
    
    // Remove square brackets for GET request
    struct CustomGetEncoding: ParameterEncoding {
        
        var arrayParams: [[String: Any]]?
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var request = try URLEncoding().encode(urlRequest, with: parameters)
            if let arrayParams = arrayParams, let httpBody = try? JSONSerialization.data(withJSONObject: arrayParams) {
                request.httpBody = httpBody
            }
            request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
            return request
        }
    }
    
    fileprivate func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    fileprivate func apiResponseError(loader: Bool = true,
                                      response: DataResponse<Any>,
                                      failure: @escaping (NSError) -> Void) {
        switch response.result {
        case .success:
            
            if let error = response.response {
                
                failure(NSError(domain: "BBCNews", code: error.statusCode, userInfo: nil))
            }
            
        case .failure(let error):
            
            failure(NSError(domain: "BBCNews", code: error._code, userInfo: nil))
        }
    }
    
    fileprivate func apiResponseError(loader: Bool = true,
                                      response: DataResponse<String>,
                                      failure: @escaping (NSError) -> Void) {
        switch response.result {
        case .success:
            
            if let error = response.response {
                
                failure(NSError(domain: "BBCNews", code: error.statusCode, userInfo: nil))
            }
            
        case .failure(let error):
            
            failure(NSError(domain: "BBCNews", code: error._code, userInfo: nil))
        }
        
        self.hideLoader(loader: loader)
    }
}
