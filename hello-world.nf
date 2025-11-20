process sayHello {
    publishDir 'results', mode: 'copy'

    input:
    val greeting
    path scriptpath

    output:
    path 'output.txt'

    script:
    "python ${scriptpath} > 'output.txt'"
}

params.greeting = 'namaste world'
params.filepath = 'script.py'
workflow {
    sayHello(params.greeting, file(params.filepath))
}
