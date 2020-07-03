{
    split($1,array,"[:/]");
    year = array[3]
    month = array[2]
    day = array[1]

    print > "./output/auth.log-"year"_"month"_"day
}
