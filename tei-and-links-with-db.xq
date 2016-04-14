import module namespace fx = 'http://www.functx.com';

declare option output:method "text";

(: need to rebuild the original db. :)
let $parent := fn:collection("onlineTEI")

return(
  '"Online TEI"',
  '&#10;',
  for $online in $parent/TEI
  let $adminDB := fx:substring-after-match(fx:substring-before-match(fn:data($online/@xml:id),'_[0-9]{6}_0{4}'),'ms')
  let $teiID := fx:substring-after-match(fx:substring-before-match(fn:data($online/@xml:id),'_0{4}$'),'ms')
  let $msN := $online//sourceDesc/bibl/note[@type='manuscript'][1]/text()
  let $coll := $online//sourceDesc/bibl/note[@type='collection']/text()
  group by $adminDB
  order by $adminDB
  return(
    '&#10;',
    fn:concat('#### AdminDB Prefix: ',$adminDB[1],' -- ','MS/AR Number: ',$msN[1],' ####'),
    '&#10;',
    for $file in $online
    (: let $ft := fn:normalize-space($file//sourceDesc[1]/bibl[1]/title) :)
    let $ft := if ($file//sourceDesc[1]/bibl[1]/title) then 
                fn:normalize-space($file//sourceDesc[1]/bibl[1]/title) 
                else fn:normalize-space($file//titleStmt[1]/title)
    let $id := $file//publicationStmt[1]/idno[1]/text()
    let $scout := fn:concat('http://dlc.lib.utk.edu/spc/view?=tei/',$id,'/',$id,'.xml')
    order by $id
    return(
      '&#10;',
      (: fn:string-join(($ft,$id),' -- ') :)
      fn:concat('* [',$ft,' -- ',$id,']','(',$scout,')'),
      '&#10;'
    ),
    '&#10;'
  )
)
  