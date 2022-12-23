%dw 2.0
fun getParentKeyChain(currKey,parentKey)=
(
	(if ( parentKey !="" and (not (isEmpty(parentKey))) ) parentKey ++ "." else "") ++ currKey
)

fun convertPayloadKeysAndValues(obj,keyFunc,valueFunc,parentKey="",currKey="")=
(obj match {
        case is Array-> obj map ((item, index) -> 
        	convertPayloadKeysAndValues(item,keyFunc,valueFunc,parentKey,currKey)
        )
        case is Object-> obj mapObject ((value, key, index) ->
            (keyFunc(value,(key), parentKey,obj) as String): convertPayloadKeysAndValues(value,keyFunc,valueFunc,getParentKeyChain((key as String),parentKey),(key as String)))
        else -> valueFunc(obj,currKey,parentKey)
    })