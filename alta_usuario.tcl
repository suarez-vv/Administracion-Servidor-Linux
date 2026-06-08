
puts "\n================================"
puts "      ALTA DE USUARIO"
puts "================================"

puts -nonewline "Nombre de usuario: "
flush stdout
gets stdin usuario

# Validar que no esté vacío
if {$usuario eq ""} {
    puts "\nError: Debe ingresar un nombre de usuario."
    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

# Verificar si ya existe
if {![catch {exec id $usuario}]} {
    puts "\nError: El usuario ya existe."
    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

puts -nonewline "Contraseña: "
flush stdout
gets stdin password

# Validar contraseña
if {[string length $password] < 4} {
    puts "\nError: La contraseña debe tener al menos 4 caracteres."
    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

# Crear usuario
if {[catch {exec sudo useradd -m $usuario} resultado]} {
    puts "\nError al crear usuario:"
    puts $resultado

    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

# Asignar contraseña
if {[catch {exec sh -c "echo '$usuario:$password' | sudo chpasswd"} resultado]} {
    puts "\nError al asignar contraseña:"
    puts $resultado

    puts "\nPresione ENTER para continuar..."
    gets stdin pausa
    return
}

puts "\nUsuario creado correctamente."

puts "\nPresione ENTER para regresar al menú..."
gets stdin pausa
