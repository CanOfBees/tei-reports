import module namespace fx = 'http://www.functx.com';

declare option output:method "text";

(: need to rebuild the db. :)
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
    let $ft := fn:normalize-space($file/teiHeader/fileDesc/titleStmt[1]/title)
    let $id := $file//publicationStmt[1]/idno[1]/text()
    order by $id
    return(
      '&#10;',
      (: fn:string-join(($ft,$id),' -- ') :)
      fn:concat('* ',$ft,' -- ',$id),
      '&#10;'
    ),
    '&#10;'
  )
)
  