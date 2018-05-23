for $sp in distinct-values(//SPEAKER)
return
<SPEAKER>{ $sp}
 { for $sc in //SCENE
  where distinct-values($sc/SPEECH/SPEAKER)=$sp
   return
   <scene>{ $sc/TITLE/text()}</scene>
}
  </SPEAKER>