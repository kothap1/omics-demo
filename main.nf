nextflow.enable.dsl = 2

params.greeting = 'hello'
params.addressee = null
params.publish_dir = 'res'
params.out_dir = 'res'
params.py_input = 'main2.py'
params.version = 'v.0.3.9'

process py_start {
    publishDir params.publish_dir
    container params.py_container
    input:
    val(py_input)
    // output:
    // file("py_output.txt")
    script:
    """
    echo greeting ${params.greeting}
    echo addressee ${params.addressee}
    echo publish_dir ${params.publish_dir}
    echo out_dir ${params.out_dir}
    echo py_input ${params.py_input}
    echo version ${params.version}
    echo container_python ${params.container_python}
    echo ${workflow.projectDir}/main2.py
    echo ${workflow.projectDir}/${py_input}
    #python ${workflow.projectDir}/main.py ${workflow.projectDir}/${py_input}
    """
}

process Greet {
    publishDir params.publish_dir
    input:
        val greeting
        val addressee
    
    output:
        path "output", emit: output_file
    
    script:
        """
        echo 
        echo START
        echo "${greeting} ${addressee} publishDir" | tee output
        uname -a
        echo "${greeting} ${addressee}" 
        echo END
        """
}

workflow {
    Greet(params.greeting, params.addressee)
    py_start(params.py_input)
}
