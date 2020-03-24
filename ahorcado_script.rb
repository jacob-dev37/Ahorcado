#Juego de ahorcado (Adivinar palabra)

#Encabezado principal
def titulo mensaje
    puts '    _    _                             _'
    puts '   / \\  | |__   ___  _ __ ___ __ _  __| | ___'
    puts '  / _ \\ | \'_ \\ / _ \\| \'__/ __/ _` |/ _` |/ _ \\'
    puts ' / ___ \\| | | | (_) | | | (_| (_| | (_| | (_) |'
    puts '/_/   \\_\\_| |_|\\___/|_|  \\___\\__,_|\\__,_|\\___/'
    puts "\n#{mensaje}\n\n"
end

#Inicializa las variables principales
def inicializar
    @palabra = "gato"
    @respuesta = []
    @intentos = 0
    #Inicializar @limite según longitud de la palabra
    case @palabra.length
    when 0..4
        @limite = 7
    when 5..8
        @limite = 12
    when 9..15
        @limite = 20
    else
        @limite = 30
    end
    #Inicializar respuesta con guines bajos
    @palabra.length.times do |x|
        @respuesta[x] = "_"
    end
    return @respuesta
end

#El usuario introduce letras
def responder
    while @respuesta.join != @palabra
        system("clear")
        titulo "Adivina la palabra"
        puts @respuesta.join(" ")
        puts "\nIntentos: #{@intentos}"
        print "\nEscribe una letra: "
        letra = gets.chomp
        #Incrementar @intentos si la letra no está
        unless @palabra.include?(letra)
            @intentos += 1
        end
        #Interrumpir el ciclo si alcanza el limite de intentos
        break if @intentos >= @limite
        #Ciclo que busca y reemplaza letras
        @respuesta.length.times do |x|
            if @palabra[x] == letra
                @respuesta[x] = letra
            end
        end
    end
    system("clear")
    if @intentos >= @limite
        titulo "Perdiste! Intentalo de nuevo"
    else
        titulo "Felicidades, has ganado!"
    end
end

#Ejecución del programa
inicializar
responder
