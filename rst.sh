#!/bin/bash

chkconfig (){

    which pandoc >> /dev/null 2>&1
    if [ $? != 0 ]; then
        printf "'pandoc' required\n"
        exit 1
    fi

    which make >> /dev/null 2>&1
    if [ $? != 0 ]; then
        printf "'make' command required\n"
        exit 1
    fi

    which sphinx-build >> /dev/null 2>&1
    if [ $? != 0 ]; then
        printf "'sphinx-build command required\n"
        printf "try - pip install Sphinx\n"
        exit 1
    fi
    printf "config looks legit!\n"
}

convert_docs(){
    excludes=('README.md' 'todo.md' 'template.md')
    for infile in `ls *.md`; do
        generate='Y'
        for exclude in ${excludes[@]}; do
            if [ "$exclude" == "$infile" ]; then
                generate='N'
                break
            fi
        done
        if [ $generate == 'Y' ]; then
            outfile=`echo $infile | sed -e 's/.md/.rst/'`
            echo "Converting ${infile} to ${outfile}..."
            pandoc\
                --from=markdown_github --to=rst\
                --output=./rst/source/guidelines/$outfile $infile
        fi
    done
}

generate_html(){
    cd rst
    make html
    printf "checkout -> ./rst/build/html/index.html\n"
}

main(){
    chkconfig
    convert_docs
    generate_html
}

main
