#!/usr/bin/env bash

dir="$HOME/Pictures/Screenshots"
time=$(date +'%Y_%m_%d_at_%Hh%Mm%Ss')
file="${dir}/Screenshot_${time}.png"

area() {
    GRIMBLAST_HIDE_CURSOR=0 grimblast --notify --freeze copysave area "$file"
}

output() {
    GRIMBLAST_HIDE_CURSOR=0 grimblast --notify --freeze copysave output "$file"
}

swappy_() {
    GRIMBLAST_HIDE_CURSOR=0 grimblast --notify --freeze copysave area "$file"
    swappy -f "$file"
}

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

if [[ "$1" == "--area" ]]; then
    area
elif [[ "$1" == "--output" ]]; then
    output
elif [[ "$1" == "--swappy" ]]; then
    swappy_
else
    echo -e "Available Options: --area --output --swappy"
fi

exit 0
