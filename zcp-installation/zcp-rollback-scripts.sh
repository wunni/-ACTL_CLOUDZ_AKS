#!/bin/bash

echo -e "Please select number you want to rollback."
echo "1. All"
echo "2. Registry"
echo "3. Catalog"

echo -e "Insert a number: \c "
read number

if [ $number == 2  -o  $number == 1 ]
then
  echo "Start ZCP Registry rollback..."

  revision=$(helm history zcp-registry | wc -l)
  revision=$((revision-2))
  helm rollback zcp-registry $revision

  echo "End ZCP Registry rollback."
fi

if [ $number == 3  -o  $number == 1 ]
then
  echo "Start ZCP Catalog rollback..."


  echo "End ZCP Catalog rollback."
fi
