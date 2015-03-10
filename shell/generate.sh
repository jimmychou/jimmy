#!/bin/bash
FILE=standard.txt
php --re standard > $FILE

FILE=array.txt
php --rf array_change_key_case >> $FILE
php --rf array_chunk >> $FILE
php --rf array_column >> $FILE
