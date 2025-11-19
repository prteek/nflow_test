process sayHello {
    publishDir 'results', mode: 'copy'

    input:
    val greeting

    output:
    path "${greeting}-output.txt"

    script:
    """
    python -c  "print('${greeting}')" > '${greeting}-output.txt'
    """
}

params.greeting = 'greetings.csv'
workflow {
    greetings_array = ['Hello', 'Hola', 'Bonjour', 'Namaste']
    greeting_ch = channel.of(greetings_array).flatten().view { greeting -> "flattened greeting: ${greeting}" }
    greeting_file_ch = channel.fromPath(params.greeting)
        .splitCsv()
        .map { item -> item[0] }
        .view { greeting -> "greeting from file: ${greeting}" }


    sayHello(greeting_file_ch)
}
