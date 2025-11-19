#!/usr/bin/env nextflow

include { sayHello } from './say_hello.nf'

process convertToUpper {
    publishDir 'results', mode: 'copy'

    input:
    path input_file

    output:
    path "UPPER-${input_file}.txt"

    script:
    """
    cat ${input_file} | tr '[a-z]' '[A-Z]' > 'UPPER-${input_file}.txt'
    """
}

process collectGreetings {
    publishDir 'results', mode: 'copy'

    input:
    path input_files

    output:
    path "collected_greetings.txt"

    script:
    """
    cat ${input_files} > 'collected_greetings.txt'
    """
}
/* input
parameter
*/
params.greeting = 'greetings.csv'
params.greeting_list = ['Hello', 'Hola', 'Bonjour', 'Ciao', 'Hallo']
workflow {
    greetings_ch = channel.fromPath(params.greeting)
        .splitCsv()
        .map { item -> item[0] }
    // get the first column (greeting) — use Groovy closure syntax

    // emit a greeting
    greetings_list_ch = channel.of(params.greeting_list).flatten()

    sayHello(greetings_list_ch)

    convertToUpper(sayHello.out)

    collectGreetings(convertToUpper.out.collect())
}
