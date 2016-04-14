(:~
: User: bridger
:)

import module namespace fx = 'http://www.functx.com';

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";

(: assumes BaseX :)
(:let $parent := "/disk2/onlineTEI":)
let $parent := "./0012_003553_000204_0000.xml"


return(
    '"Online TEI"',
    for $online in fn:collection($parent)/TEI
    let $adminDB := fx:substring-after-match(fx:substring-before-match(fn:data($online/@xml:id),'_[0-9]{6}_0{4}'),'ms')
    let $teiID := fx:substring-after-match(fx:substring-before-match(fn:data($online/@xml:id),'_0{4}$'),'ms')
    let $msN := $online//sourceDesc/bibl/note[@type='manuscript']/text()
    let $coll := $online//sourceDesc/bibl/note[@type='collection']/text()
    group by $adminDB
    order by $adminDB
    return(
        '&#10;',
        fn:concat('### AdminDB Prefix: ',$adminDB[1],' -- ','MS/AR number: ',$msN[1],'###'),
        for $file in $online
        let $ft := fn:data($file//sourceDesc[1]/bibl[1]/title)
        let $ft2 := $file//sourceDesc[1]/bibl[1]/title/text()[fn:normalize-space()]
        let $ft3 := fn:normalize-space($file//sourceDesc[1]/bibl[1]/title)
        let $id := $file//publicationStmt[1]/idno[1]/text()
        return(
            fn:concat(fn:normalize-space($ft),' -- ',$id),
            $ft2,
            $ft3
        )

    )
)




