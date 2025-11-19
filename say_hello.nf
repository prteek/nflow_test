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
