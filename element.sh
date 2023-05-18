#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

CHOICE=$1;

NUMBER_ENTERED() {
  result=$(eval "$PSQL \"SELECT elements.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius
         FROM elements
         JOIN properties ON elements.atomic_number = properties.atomic_number
         JOIN types ON properties.type_id = types.type_id
         WHERE elements.atomic_number = $CHOICE;\"")
  if [ -z "$result" ]; then
    echo "I could not find that element in the database."
  else
    IFS='|' read -ra values <<< "$result"
    atomic_number=${values[0]}
    name=${values[1]}
    symbol=${values[2]}
    type=${values[3]}
    atomic_mass=${values[4]}
    melting_point=${values[5]}
    boiling_point=${values[6]}

    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  fi
}

NAME_ENTERED() {
  result=$(eval "$PSQL \"SELECT elements.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius
         FROM elements
         JOIN properties ON elements.atomic_number = properties.atomic_number
         JOIN types ON properties.type_id = types.type_id
         WHERE elements.name = '$CHOICE';\"")
  if [ -z "$result" ]; then
    echo "I could not find that element in the database."
  else
    IFS='|' read -ra values <<< "$result"
    atomic_number=${values[0]}
    name=${values[1]}
    symbol=${values[2]}
    type=${values[3]}
    atomic_mass=${values[4]}
    melting_point=${values[5]}
    boiling_point=${values[6]}

    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  fi
}

SYMBOL_ENTERED() {
  result=$(eval "$PSQL \"SELECT elements.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius
         FROM elements
         JOIN properties ON elements.atomic_number = properties.atomic_number
         JOIN types ON properties.type_id = types.type_id
         WHERE elements.symbol = '$CHOICE';\"")
  if [ -z "$result" ]; then
    echo "I could not find that element in the database."
  else
    IFS='|' read -ra values <<< "$result"
    atomic_number=${values[0]}
    name=${values[1]}
    symbol=${values[2]}
    type=${values[3]}
    atomic_mass=${values[4]}
    melting_point=${values[5]}
    boiling_point=${values[6]}

    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  fi
}

ELEMENT_NOT_FOUND() {
  echo "I could not find that element in the database."
}


case $CHOICE in
  [0-9]*) NUMBER_ENTERED ;;
  [A-Z]|[A-Z][a-z]) SYMBOL_ENTERED ;;
  [A-Za-z]*) NAME_ENTERED ;;
  *) ELEMENT_NOT_FOUND ;;
esac
