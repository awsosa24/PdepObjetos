/* V1.0 TP1 Objetos PdeP */
/* 
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
*/

/*object barrileteCosmico{
    var destinos = #{garlicSSea, silverSSea, lastToninas, goodAirs}

    method destinosMasImportantes(){
        return destinos.filter({destino => destino.esImportante() })
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
} */
/* 
object pabloHari{
    const usuario = "PHari"
    var lugaresConocidos = #{lastToninas, goodAirs}
    var saldo = 1500
    var seguidos = #{}

    method volarHacia(destino){
        if (self.puedeVolar(destino)){
            self.agregarDestino(destino)
            saldo -= destino.precio()
        }
    }

	method puedeVolar(unDestino){
		return unDestino.precio() <= saldo
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
    
    method lugaresConocidos(){
    	return lugaresConocidos
    }
    
    method saldo(){
    	return saldo
    }
}
*/
/************* TP2 **************/

/* Medios de  transporte */

class Transporte{
    var tardanza
    var costo
    
    method costo(){
    	return costo
    }
}

/* Localidades */

class Localidad{
    var equipaje
    var precio
    var kilometro
    
    constructor (precioLocalidad,equipajeLocalidad){
		precio=precioLocalidad
		equipaje=equipajeLocalidad
	}
	
    method equipaje(){
        return equipaje
    } 
    
    method precio(){
        return precio
    }
	  
	method kilometro(){
        return kilometro
    }
    
    method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B")
    }

    method distanciaALocalidad(localidad){
        return  (kilometro - localidad.kilometro()).abs()  
    }

/* Ver en carpeta que hacer cuando comparten mismos metodos pero con diferentes comportamientos */
  //Ayuda! no se como hacerlo ya teniendo el objeto y no definiendo una nueva clase
    method esImportante(){
        return precio > 2000
    }

    method aplicarDescuento(descuento){
        precio = precio * (1 - descuento / 100)
    }   

    method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }


/* Viajes */
	method precioDelViaje(localidad, transporte){
		return precio+self.distanciaALocalidad(localidad)*transporte.costo()
	}
}

	const garlicSSea = new  Localidad(2500,#{"Caña de Pescar, Piloto"})
	const silverSSea = new  Localidad(1350,#{"Protector Solar", "Equipo de Buceo"})
	const lastToninas= new  Localidad(3500,#{"Vacuna Gripal", "Vacuna B", "Necronomicon"})
	const goodAirs 	 = new  Localidad(1500,#{"Cerveza", "Protector Solar"})

/* Usuarios */
class Usuario{
	const usuario
    var lugaresConocidos  
    var saldo 
    var seguidos 
    var localidadDeOrigen
    
    constructor(nombreUsuario, lugaresUsuario, saldoUsuario){
    	usuario=nombreUsuario
    	lugaresConocidos=lugaresUsuario
    	saldo=saldoUsuario
    	//localidadDeOrigen=localidadUsuario
    }
    

	method localidadDeOrigen(nuevaLocalidad){
		localidadDeOrigen=nuevaLocalidad
	}

    method volarHacia(unaLocalidad, unTransporte){
        if (self.puedeVolar(unaLocalidad, unTransporte)){
            self.agregarDestino(unaLocalidad)
            saldo -= unaLocalidad.precioDelViaje(unaLocalidad, unTransporte)
            localidadDeOrigen=unaLocalidad
        }
    }

	method puedeVolar(unaLocalidad, unTransporte){
		return unaLocalidad.precioDelViaje(unaLocalidad, unTransporte) <= saldo
	}
	
    method agregarDestino(unaLocalidad){
        lugaresConocidos.add(unaLocalidad)
    }
//TODO 
//Se suma los kms de cada localidad a la localidad de origen del Usuario.
//Lo que no me cierra es que la localidad de origen puede cambiar. 
//Sera que tenemos que tener una variable kilometros e ir sumando los kilometros recorridos ahi?
    method kilometros(){
        return (lugaresConocidos.map({
			        	lugar => lugar.distanciaALocalidad(localidadDeOrigen)
			        }).sum()) 
    }

    method seguirA(unUsuario){
        seguidos.add(unUsuario)
        unUsuario.seguirA(self)
    }
    
    method lugaresConocidos(){
    	return lugaresConocidos
    }
    
    method saldo(){
    	return saldo
    }
}

const pabloHari = new Usuario("PHari", #{lastToninas, goodAirs}, 1500)

/* Barrilete cosmico */
class AgenciaDeViaje {
    var destinos 
    var transportes 
    
    constructor (destinosIniciales, mediosDeTransporte){
    	destinos= destinosIniciales
    	transportes = mediosDeTransporte
    }

    method destinosMasImportantes(){
        return destinos.filter({destino => destino.esImportante() })
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
    
    method armarViaje(unUsuario, unaLocalidad){
    	unUsuario.volarHacia(unaLocalidad, transportes.anyOne())
    }
}

const barrileteCosmico = new AgenciaDeViaje(#{garlicSSea, silverSSea, lastToninas, goodAirs}, #{})