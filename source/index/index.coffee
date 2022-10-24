############################################################
defaultDecayMS = 30000

#############################################################
allMemoryObjects = []
nextMemId = 0

############################################################
export setDefaultDecayMS = (decayMS) -> 
    defaultDecayMS = decayMS
    return

############################################################
export makeForgetable = (obj, decayMS) ->
    if !decayMS? then decayMS = defaultDecayMS

    Object.defineProperties(
        obj, 
        "__memoryid": {
            value: nextMemId++,
            enumerable: false,
            writable: false
        },
        "letForget": {
            value: letForget
            enumerable: false
            writable: false
        }
    )
    toForgetTimers = {}
    allMemoryObjects[obj.__memoryid] = {decayMS, toForgetTimers}
    return obj

############################################################
letForget = (key, ms) ->
    # console.log("letForget "+key)
    throw new Error("Key was not a string!") unless typeof key == "string"

    targetObj = this

    memObj = allMemoryObjects[targetObj.__memoryid]

    if ms? then decayMS = ms
    else decayMS = memObj.decayMS

    forget = -> 
        delete targetObj[key]
        delete memObj.toForgetTimers[key]
        # console.log("forget "+key)
        return

    # console.log("before: "+Object.keys(memObj.toForgetTimers))

    timeoutId = memObj.toForgetTimers[key]
    if timeoutId? then clearTimeout(timeoutId)
    timeoutId = setTimeout(forget, decayMS)
    memObj.toForgetTimers[key] = timeoutId

    # console.log("after: "+Object.keys(memObj.toForgetTimers))
    return
