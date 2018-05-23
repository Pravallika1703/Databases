
for $s1 in distinct-values(//SPEAKER),$s2 in distinct-values(//SPEAKER)
   where $s1!=$s2
     return
    <related>
     <SPEAKER>{$s1 } </SPEAKER>
   
     <SPEAKER>{$s2 }</SPEAKER>
      {for $sc in //SCENE
      let $a:=distinct-values($sc/SPEECH/SPEAKER)
      let $b:=distinct-values($sc/SPEECH/SPEAKER)
      where $a=$s1 and $b=$s2
       return
       <SCENE>{ $sc/TITLE/text()}</SCENE>}
      
      </related>
