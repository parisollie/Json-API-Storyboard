//
//  ViewController.swift
//  JSONUIKIT
//
//  Created by Paul Jaime Felix Flores on 25/04/23.
//


import UIKit

//Celda personaizada.
class celda: UITableViewCell {
    
    //V-137,paso 1.0 nuestros objetos de celda personalizada
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var email: UILabel!
    
}

/*Paso 1.1, la parte donde va la tabla
  Le agregamos esto : UITableViewDelegate, UITableViewDataSource*/
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Paso 1.2
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Paso 1.3,Ponemos esto por defecto
        tabla.delegate = self
        tabla.dataSource = self
        //Paso 1.14 ,Hacemos nuestro closure
        ModeloViewModel.shared.fetch{ done in
            if done {
                self.tabla.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Paso 1.7,Retornamos nuestro modelo y cuenta el numero de registros
        return ModeloViewModel.shared.datosModelo.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Paso 1.8 ,Hacemos la parte de nuestra celda
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! celda
        //Paso 1.9,Donde estan nuestros datos
        let user = ModeloViewModel.shared.datosModelo.data[indexPath.row]
       
        //Paso 1.10,Accedemos a los datos
        cell.nombre.text = user.first_name
        cell.email.text = user.email
        
        //Paso 1.11,para la imagen , la imagen viene en URL, la traemos en datos
        guard let imageURL = URL(string: user.avatar) else { fatalError("sin imagen") }
        
        /*
          Traemos un DispatchQueue.global() para que nos encierre todo el proceso
          que hara la imagen
        */
        
        //Paso 1.12
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            //Guardamos nuestra imagen
            DispatchQueue.main.async {
                cell.imagen.image = image
                /*Ya no necesario ponerlo sino se hace un bucle infinito
                self.tabla.reloadData()*/
            }
        }
        return cell
    }
    
    
    

    

}
