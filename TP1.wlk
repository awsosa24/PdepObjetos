/************* TP2 **************/

/* Medios de  transporte */

class Transporte{
    var tardanza
    var costo
    
    constructor(tardanzaTransporte, costoTransporte){
    	tardanza=tardanzaTransporte
    	costo=costoTransporte
    }
    
    method costo(){
    	return costo
    }
}

	const colectivo = new Transporte(0,10)
/* Localidades */

class Localidad{
    var equipaje
    var precio
    var kilometro
    
    constructor (precioLocalidad,equipajeLocalidad,unKilometro){
		precio=precioLocalidad
		equipaje=equipajeLocalidad
        kilometro = unKilometro
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
	method precioDelViaje(distanciaEntreLocalidades, transporte){
		return precio + distanciaEntreLocalidades * transporte.costo()
	}
}
    //Me fije en internet en que kilometro quedaba cada lugar xd
	const garlicSSea  = new  Localidad(2500,#{"Caña de Pescar, Piloto"}, 344)
	const silverSSea  = new  Localidad(1350,#{"Protector Solar", "Equipo de Buceo"}, 415)
	const lastToninas = new  Localidad(3500,#{"Vacuna Gripal", "Vacuna B", "Necronomicon"}, 320)
	const goodAirs    = new  Localidad(1500,#{"Cerveza", "Protector Solar"}, 0)

/* Usuarios */
class Usuario{
	const usuario
    var lugaresConocidos  
    var saldo 
    var seguidos 
    var localidadDeOrigen
    var kilometros = 0 /*********/
    
    constructor(nombreUsuario, lugaresUsuario, saldoUsuario, localidadUsuario){
    	usuario=nombreUsuario
    	lugaresConocidos=lugaresUsuario
    	saldo=saldoUsuario
    	localidadDeOrigen=localidadUsuario
    }
    
	method localidadDeOrigen(nuevaLocalidad){
		localidadDeOrigen=nuevaLocalidad
	}

    method distanciaALocalidad(localidad){ /*********/
        return  (localidadDeOrigen.kilometro() - localidad.kilometro()).abs()  
    }

    method viajarHacia(unaLocalidad, unTransporte){
    	
        var distanciaEntreLocalidades = self.distanciaALocalidad(unaLocalidad)
        if (self.puedeViajar(unaLocalidad, unTransporte, distanciaEntreLocalidades)){
			
            saldo -= unaLocalidad.precioDelViaje(distanciaEntreLocalidades, unTransporte) /*********/

            self.agregarDestino(unaLocalidad)
            localidadDeOrigen = unaLocalidad
            kilometros += distanciaEntreLocalidades /*********/
            
        }
    }

	method puedeViajar(unaLocalidad, unTransporte, distanciaEntreLocalidades){
		return unaLocalidad.precioDelViaje(distanciaEntreLocalidades, unTransporte) <= saldo
	}
	
    method agregarDestino(unaLocalidad){
        lugaresConocidos.add(unaLocalidad)
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

    method kilometros(){
        return kilometros
    }
}

	const pabloHari = new Usuario("PHari", #{lastToninas, goodAirs}, 1500+4150, goodAirs)

/* Barrilete cosmico */
object barrileteCosmico {
    var destinos = #{garlicSSea, silverSSea, lastToninas, goodAirs}
    var transportes = #{}

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

/* En ningun lado dice los kilometros de cada destino
barrilete cosmico cuando arma un vieje dice que ""establece como localidad de origen la del mismo""
hay que calcular todos los kilometros acumulados de todos los lugares que conoce?
*/

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