<shortSpeeches>
{
for $s in //SPEECH,$sp in $s/SPEAKER,$l in $s/LINE
   let $n:=$s/LINE
   where count($n)=1 
   return
   <SPEECH> { $sp/text()}
   
     <LINE>{$l/text()}</LINE>
   </SPEECH>
  
} </shortSpeeches>