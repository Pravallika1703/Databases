%query 1
moreAirports(Place,Name1,Code1,Name2,Code2):-airport(_,Name1,Place,Code1,_,_),airport(_,Name2,Place,Code2,_,_),not(Code1=Code2).

%query 2
aaFlight(FromCode,ToCode):-route(Name,FromCode,ToCode,_),(Name=aa).
aaFlight(FromCode,ToCode):-route(Name,FromCode,Code,_), aaFlight(Code,ToCode),(Name=aa),(FromCode\=ToCode).

%query 3
farAirports(Name1,Name2):-airport(_,Name1,_,_,Latitude1,Longitude1),airport(_,Name2,_,_,Latitude2,Longitude2), abs(Latitude1-Latitude2)>=16,abs(Longitude1-Longitude2)>=16.

%query 4
sgToSydney(FromCode,ToCode):-route(Name,FromCode,syd,_),route(Name,ToCode,syd,_),not(FromCode=ToCode),Name=qf.
sgToSydney(FromCode,ToCode):-sgToSydney(FC1,TC1),route(Name,FromCode,FC1,_),route(Name,ToCode,TC1,_),FromCode\=ToCode,Name='qf'.

%query 5
tsvf(FromCode,ToCode):- route(Name,FromCode,tsv,_).
tsvf(FromCode,ToCode):-route(Name,FromCode,Code,_),tsvf(Code,ToCode).
throughTownsvilleFlight(FromCode,syd):-tsvf(FromCode,syd),not(FromCode='syd'),not(FromCode='tsv').


