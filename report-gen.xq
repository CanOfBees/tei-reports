(:~
: bridger
: 
:)
import module namespace fx = 'http://www.functx.com';

declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";

(: assumes BaseX :)
let $parent := fn:collection("unreleasedTEI")

return(
    '"READY" TEI',
    '&#10;',
    for $ready in $parent/t:TEI
    let $adminDB := fx:substring-after-match(fx:substring-before-match(fn:data($ready/@xml:id),'_[0-9]{6}_0{4}'),'ms')
    let $teiID := fx:substring-after-match(fx:substring-before-match(fn:data($ready/@xml:id),'_0{4}$'),'ms')
    let $msN := $ready//t:sourceDesc/t:bibl/t:note[@type='manuscript']/text()
    let $coll := $ready//t:sourceDesc/t:bibl/t:note[@type='collection']/text()
    group by $adminDB
    order by $adminDB
    return(
        '&#10;',
        fn:concat('#### AdminDB Prefix: ',$adminDB[1],' -- ','MS/AR#: ',$msN[1],' ####'),
        '&#10;',
        for $file in $ready
        let $t := fn:normalize-space($file//t:sourceDesc/t:bibl/t:title[1])
        let $id := $file//t:publicationStmt/t:idno[1]/text()
        return(
            '&#10;',
            fn:concat('* ',$t,' -- ',$id),
            '&#10;'
        )
    )
)