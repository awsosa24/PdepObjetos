/*object garlicSea{
	const nombreDestino= "Garlic´s Sea"
	var precioDestino = 2500
	var equipajeImprescindible = #{"Cana de Pescar, Piloto"}
	
	method precioDestino(){ return precioDestino}
}
object silverSea{
	const nombreDestino= "Silver's Sea"
	var precioDestino = 1350
	var equipajeImprescindible = #{"Protector Solar", "Equipo de Buceo"}
	
	method precioDestino(){ return precioDestino}
}*/
object lastToninas{
	const nombreDestino= "Last Toninas"
	var precioDestino = 3500
	var equipajeImprescindible = #{"Vacuna Gripal", "Vacuna B", "Necronomicon"}
	
	method precioDestino(){ return precioDestino}
	method precioDestino(nuevoPrecio){ precioDestino = nuevoPrecio}
	method equipajeImprescindible(){return equipajeImprescindible }
	method equipajeImprescindible(nuevoEquipaje){equipajeImprescindible.add(nuevoEquipaje) }
	
	method agregarEquipajeImprescindible(nuevoEquipaje){
		  self.equipajeImprescindible(nuevoEquipaje)
		  return self
	}
	method descuentoAlDestino(unDescuento){
		self.precioDestino( self.precioDestino() - unDescuento )
		return self
	}
	method esExtremo(){
		 return equipajeImprescindible.contains("Vacuna") //TODO Deberia evaluar todo lo que contenga vacuna?
	}
}
object goodAirs{
	const nombreDestino= "Good Airs"
	var precioDestino = 1500
	var equipajeImprescindible = #{"Cerveza", "Protector Solar"}
	
	method precioDestino(){ return precioDestino}
	method precioDestino(nuevoPrecio){ precioDestino = nuevoPrecio}
	method equipajeImprescindible(){return equipajeImprescindible }
	method equipajeImprescindible(nuevoEquipaje){equipajeImprescindible.add(nuevoEquipaje) }
	
	method agregarEquipajeImprescindible(nuevoEquipaje){
		  self.equipajeImprescindible(nuevoEquipaje)
		  return self
	}
	method descuentoAlDestino(unDescuento){
		self.precioDestino( self.precioDestino() - unDescuento )
		return self
	}
	method esExtremo(){
		 return equipajeImprescindible.contains("Vacuna")
	}
}
// goodAirs.agregarEquipajeImprescindible("holaaaaaa")
object barrileteCosmico{
	
	var coleccionDestinos = [lastToninas,  goodAirs]
	
	method destinosMasImportantes(){
		 self.destinosDestacados()
	}
	method destinosDestacados(){
		 coleccionDestinos.filter({unDestino=> unDestino.precioDestino() > 2000})
	} //barrileteCosmico.destinosDestacados()
	
	method descuentosADestinos(unDescuento){
		coleccionDestinos.map({unDestino=> unDestino.descuentoAlDestino(unDescuento) })
		
		  coleccionDestinos.map({unDestino=> 
			  unDestino.agregarEquipajeImprescindible("Certificado de Descuento")
			  })//barrileteCosmico.descuentosADestinos()
	}
	
	method empresaExtrema(){
		coleccionDestinos.any({unDestino=>
			unDestino.esExtremo()
		})
	}
	method destinosEmpresa(){ //sigo por aca la proxima!
		coleccionDestinos.
	}
}