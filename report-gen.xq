(:~
: bridger
: 
:)

declare namespace t = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";

(: assumes BaseX :)
let $parent := "/usr/home/bridger/Documents/tei/preProx-XML/processed-files"

return(
    '"READY" TEI',
    for $ready in fn:collection(fn:concat($parent,"/READY/"))/t:TEI
    let $adminDB := functx:substring-after-match(functx:substring-before-match(fn:data($ready/@xml:id),'_[0-9]{6}_0{4}'),'ms')
    let $teiID := functx:substring-after-match(functx:substring-before-match(fn:data($ready/@xml:id),'_0{4}$'),'ms')
    let $msN := $ready//t:sourceDesc/t:bibl/t:note[@type='manuscript']/text()
    let $coll := $ready//t:sourceDesc/t:bibl/t:note[@type='collection']/text()
    group by $adminDB
    order by $adminDB
    return(
        '&#10;',
        fn:concat('AdminDB Prefix: ',$adminDB[1],' -- ','MS/AR#: ',$msN[1]),
        for $file in $ready
        let $t := $file//t:sourceDesc/t:bibl/t:title[1]/text()
        let $id := $file//t:publicationStmt/t:idno[1]/text()
        return
            fn:concat($t,' -- ',$id)
    )
)