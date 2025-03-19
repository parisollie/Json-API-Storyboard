//
//  ModeloViewModel.swift
//  JSONUIKIT
//
//  Created by Paul Jaime Felix Flores on 25/04/23.
//

import Foundation

//Paso 1.5
class ModeloViewModel {
    //Paso 1.6,Como la usamos en core data,para poder ingresar a datosModelo y al fetch 
    public static var shared = ModeloViewModel()
    
    var datosModelo = Modelo(data: [])
    
    /*Paso 1.13,Hacemos un compeltetion una forma de escapar los datos
     escapamos el resultado, done es un parámetro y el tipo de dato que queremos */
    func fetch(completion: @escaping (_ done:Bool) -> Void){
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return  }
        
        URLSession.shared.dataTask(with: url){data,_,_ in
            
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(Modelo.self, from: data)
                DispatchQueue.main.async {
                    self.datosModelo = json
                    //Paso 1.15 Ponemos el completetion aqui para poder recargar la tabla 
                    completion(true)
                }
            }catch let error as NSError{
                print("Error en el json", error.localizedDescription)
            }
            
        }.resume()
    }
}
