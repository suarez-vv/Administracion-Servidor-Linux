puts "\n================================"
puts "      BAJA DE USUARIO"
puts "================================"

puts -nonewline "Usuario a eliminar: "
flush stdout
gets stdin usuario

# Validar entrada
if {$usuario eq ""} {
    puts "\nError: Debe ingresar un usuario."

    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

# Verificar si existe
if {[catch {exec id $usuario}]} {
    puts "\nError: El usuario no existe."

    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

# Confirmación
puts -nonewline "¿Está seguro de eliminar '$usuario'? (s/n): "
flush stdout
gets stdin respuesta

if {[string tolower $respuesta] ne "s"} {
    puts "\nOperación cancelada."

    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

# Eliminar usuario y su directorio personal
if {[catch {exec sudo userdel -r $usuario} resultado]} {

    if {[catch {exec id $usuario}]} {
        puts "\nUsuario eliminado correctamente."
    } else {
        puts "\nError al eliminar usuario:"
        puts $resultado
    }

} else {
    puts "\nUsuario eliminado correctamente."
}

puts "\nPresione ENTER para regresar al menú..."
gets stdin pausa
