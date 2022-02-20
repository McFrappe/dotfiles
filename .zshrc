# load seperated config files
for conf in "$HOME/.config/zsh/"*.zsh; do
    source ${conf}

    if [ $? -ne 0 ]; then 
        echo "! ${red}Failed${end} to source ${conf}.\nReturn code was $?"
        continue
    fi

    echo "> Sourced ${conf} ${grn}successfully${end}."
done
unset conf
