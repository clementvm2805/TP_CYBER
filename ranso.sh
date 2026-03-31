#!/bin/bash
set -e

DIR="$(dirname "$0")"

F="$DIR/ranso.txt"
E="$DIR/ranso.txt.enc"
K="$DIR/key.key"
IV_FILE="$DIR/iv.txt"

echo "Test AES-256" > "$F"

openssl rand -hex 32 > "$K"
IV=$(openssl rand -hex 16)

openssl enc -aes-256-cbc -in "$F" -out "$E" -K "$(cat "$K")" -iv "$IV"
echo "$IV" > "$IV_FILE"

rm "$F"

read -p "Entrée pour déchiffrer..."

openssl enc -aes-256-cbc -d -in "$E" -out "$F" -K "$(cat "$K")" -iv "$(cat "$IV_FILE")"

echo "Contenu récupéré :"
cat "$F"