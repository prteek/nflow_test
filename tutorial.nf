#!/usr/bin/env nextflow

params.str = 'Hello world!'

process splitLetters {
    container 'iprtk/nflow-test:latest'

    input:
    val str

    output:
    file 'chunk_*'

    script:
    """
    printf '${str}' | split -b 6 - chunk_
    """
}

process convertToUpperX {
    container 'iprtk/nflow-test:latest'

    input:
    file x

    output:
    stdout

    script:
    """
    cat ${x} | tr '[a-z]' '[A-Z]'

    """
}

workflow {
    // create a channel from the parameter, call processes and view the result
    str_ch = channel.value(params.str)
    letters = splitLetters(str_ch)
    result = convertToUpperX(letters.flatten())
    result.view { x -> x.trim() }
}
