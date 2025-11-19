process sayHello {
    publishDir 'results', mode: 'copy'

    input:
    val greeting

    output:
    path 'output.txt'

    script:
    """
    python -c  "print('${greeting}')" > output.txt
    """
}

params.greeting = 'namaste world'
workflow {
    sayHello(params.greeting)
}
