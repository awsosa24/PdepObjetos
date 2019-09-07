/* Saqué algunos getters y setters que no se usan nunca (Al final los volvi a poner para los test)
habia metodos que tenian efecto y también devolvian algo pero lo que hay que hacer
es que haga una cosa o la otra no las dos, y depues algunos metodos van adentro de los objetos
por el tema del encapsulamiento de que la logica propia de cada objeto va dentro de ese objeto
y no de otro (me parece) */

object garlicSSea {
    var equipaje = #{"Caña de Pescar, Piloto"}
    var precio = 2500

    method esImportante(){
        return precio > 2000
    }

    method aplicarDescuento(descuento){
        precio = precio * (1 - descuento / 100)
    }
    
    method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }
    
    method equipaje(){
        return equipaje
    }

    method precio(){
        return precio
    }

    method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B")
    }

}

object silverSSea {
    var equipaje = #{"Protector Solar", "Equipo de Buceo"}
    var precio = 1350

    method esImportante(){
        return precio > 2000
    }

    method aplicarDescuento(descuento){
            precio = precio * (1 - descuento / 100)
        }

     method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }
    
    method equipaje(){
        return equipaje
    } 

    method precio(){
        return precio
    }

    method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B")
    }
}

object lastToninas {
    var equipaje = #{"Vacuna Gripal", "Vacuna B", "Necronomicon"}
    var precio = 3500
    
    method esImportante(){
        return precio > 2000
    }

    method aplicarDescuento(descuento){
        precio = precio * (1 - descuento / 100)
    }   

    method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }

    method equipaje(){
        return equipaje
    } 
    
    method precio(){
        return precio
    }

    method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B")
    }
}

object goodAirs {
    var equipaje = #{"Cerveza", "Protector Solar"}
    var precio = 1500

    method esImportante(){
        return precio > 2000
    }

    method aplicarDescuento(descuento){
        precio = precio * (1 - descuento / 100)
    }

    method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }

    method equipaje(){
        return equipaje
    }
    
    method precio(){
        return precio
    }

    method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B")
    }
}

object barrileteCosmico {
    var destinos = #{garlicSSea, silverSSea, lastToninas, goodAirs}

    method destinosMasImportantes(){
        return destinos.filter({destino => destino.esImportante()})
    }

    method aplicarDescuento(descuento){
        destinos.forEach({destino => destino.aplicarDescuento(descuento)})
        destinos.forEach({destino => destino.agregarEquipaje("Certificado de descuento")})
    }

    method esExtrema(){
        return destinos.any({destino => destino.esPeligroso()})
    }

    method destinos(){
        return destinos
    }
}

object pabloHari{
    const usuario = "PHari"
    var lugaresConocidos = #{lastToninas, goodAirs}
    var saldo = 1500
    var seguidos = #{}

    method volarHacia(destino){
        if (destino.precio() <= saldo){
            self.agregarDestino(destino)
            saldo -= destino.precio()
        }
    }

    method agregarDestino(destino){
        lugaresConocidos.add(destino)
    }

    method kilometros(){
        return (lugaresConocidos.map({lugar => lugar.precio()}).sum()) / 10
    }

    method seguirA(unUsuario){
        seguidos.add(unUsuario)
        unUsuario.seguirA(self)
    }
}