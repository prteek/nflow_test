#!/usr/bin/env nextflow

params.str = 'Hello world!'

process splitLetters {
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
