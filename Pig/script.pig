/* Load the ACTOR data */
ACTOR = LOAD ' actor.csv' USING PigStorage(',') AS (ActorID:int, Name:chararray);
/* dump ACTOR data */
DUMP ACTOR;
/* Load the MOVIE data */
MOVIE = LOAD ' movie.csv' USING PigStorage(',') AS (MovieID:int, Title:chararray, Year:int, Score:float, Votes:int);
/* dump MOVIE data */
DUMP MOVIE;
/* Load the CASTING data */
CASTING = LOAD ' casting.csv' USING PigStorage(',') AS (MovieID:int, ActorID:int, Ordinal:int);
/* dump CASTING data */
DUMP CASTING;

/* Joining MOVIE and CASTING data */
MOVIE_CAST = JOIN MOVIE BY MovieID, CASTING BY MovieID; 
/* Joining MOVIE, CASTING and ACTOR data */
MOVIE_CAST_ACTOR = JOIN MOVIE_CAST BY ActorID, ACTOR BY ActorID; 
/* dump joining data */
DUMP MOVIE_CAST_ACTOR;

/* Fliter MOVIE details where score is greater than 8 */
MOVIE_FIL = FILTER MOVIE BY Score > 8;
/* Generating output for each row by MOVIE title */
MOVIE_T = FOREACH MOVIE_FIL GENERATE Title;
/* Order the data in ascending order based on MOVIE title */
MOVIE_T_ORD = ORDER MOVIE_T BY Title asc;
/* Dump the result to screen */
DUMP MOVIE_T_ORD;

/* Generate output for each row by MOVIE title and year */
MOVIE_T_Y = FOREACH MOVIE GENERATE Title, Year;
/* Filter the MOVIE data based on year>=1980 year<=1989 and year%2 == 0 */
MOVIE_FIL = FILTER MOVIE_T_Y BY Year >= 1980 AND Year <=1989 AND Year%2==0;
/* dump data to screen*/
DUMP MOVIE_FIL;

/* Generate the output for each row by MOVIE title and votes */
MOVIE_T_V = FOREACH MOVIE GENERATE Title, Votes;
/* Order the data in descending order based on Votes */
MOVIE_ORD = ORDER MOVIE_T_V BY Votes desc;
/* print first 5 from the list using LIMIT */
MOVIE_L = LIMIT MOVIE_ORD 5;
/* DUMP data to screen */
DUMP MOVIE_L;
 
 /* Join ACTOR and CASTING */
CAST_ACTOR = JOIN CASTING BY ActorID, ACTOR BY ActorID; 
/* Group the data by name */
GR_CAST_ACTOR = GROUP CAST_ACTOR BY Name;
/* Generate the output for the first column as $0 and Count CAST_ACTOR  which we already have  */
COUNT_CAST_ACTOR = FOREACH GR_CAST_ACTOR GENERATE $0, COUNT(CAST_ACTOR);
/* Fillter the records based on $1 greater than 3 */
FIL_CAST_ACTOR = FILTER COUNT_CAST_ACTOR BY ($1>3);
/* Generating FIL_CAST_ACTOR first column output  */
AC_GEN1 = FOREACH FIL_CAST_ACTOR GENERATE $0;
/* ORDERING AC_GEN1 by first column in ascending order and storing in AC_ORD */
AC_ORD = ORDER AC_GEN1 BY $0 asc;
/* Dump data to screen*/
DUMP AC_ORD;

/* Group MOVIE_CAST_ACTOR data by name */
G_MOVIE_CAST_ACTOR = GROUP MOVIE_CAST_ACTOR BY Name;

/* ORDERING GRP_AM on the basis of first column and in ascending order. */
MA_ORD = ORDER G_MOVIE_CAST_ACTOR BY $0 asc;
/* FILTERING MA_ORD by counting fist column and it should be greater than three */
MA_FIL = FILTER MA_ORD BY COUNT($1)>3;
/* Generate first column and average of second column and fourth column */
MA_AVG = FOREACH MA_FIL GENERATE $0, AVG($1.$3);
/* DUMPING  output to screen */
DUMP MA_AVG;
		