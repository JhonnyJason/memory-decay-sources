# Memory Decay 

# Background
In many applications it seems like a useful capability to have some specific datafield of an object being automatically deleted over time.

For example authentication codes, which are valid for a limited time.

Also it seems in a generalized form this might be useful on other cases as well.


# Usage
Requirements
------------
- ESM importability

Installation
------------
Current git version:
```
npm install -g git+https://github.com/JhonnyJason/memory-decay-output.git
```

Npm Registry:
```
npm install -g memory-decay
```

Current Functionality
---------------------
- Set a global default decay time.
- Prepare an object such that it's datafields may be forgotten  -> adds `letForget` function
- Specify a specific datafield to be forgotten in the specified time `letForget(key, timeMS)` - timeMS is optional
- If you call `letForget` again it will postpone the deletion to the new time.

```coffee
setDefaultDecayMS = (decayTimeMS) ->
makeForgetableMemory  = (object, decayTimeMS) -> object
# here decayTimeMS is optional - defaultDecayMS will be take if decayTimeMS is not specified
# the same object as provided is returned
# the object now has a new function attached
object.letForget = (key, decayTimeMSs) ->
# also here decayTimeMS is optional - either the Object specified or the global default is taken if decayTimeMS is not specified

```

```coffee
import { makeForgetableMemory } from "memory-decay"

## default default is 30000ms
volatileIdeaMemory = makeForgetableMemory({})

volatileIdeaMemory.task1 = "think about task 2"
volatileIdeaMemory.letForget("task1") ## is forgotten in 30000ms

volatileIdeaMemory.task2 = "plan task 3"
volatileIdeaMemory.letForget("task1", 1000) ## is forgotten in 1000ms


longtermMemory = {}
makeForgetableMemory(longtermMemory, 30000000000)
longtermMemory.secret = "super secret secret"
longtermMemory.letForget("secret") ## is forgotten in 347 days

```

---

# Further steps

- maybe make a proxy out of it so that the "letForget" is always implicitely triggered when set
- figure out what to do next^^


All sorts of inputs are welcome, thanks!

---

# License
[Unlicense JhonnyJason style](https://hackmd.io/nCpLO3gxRlSmKVG3Zxy2hA?view)
