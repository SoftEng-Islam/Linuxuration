# Installation
> `npm install --save @types/object.pick`

# Summary
This package contains type definitions for object.pick (https://github.com/jonschlinkert/object.pick).

# Details
Files were exported from https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/object.pick.
## [index.d.ts](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/object.pick/index.d.ts)
````ts
/**
 * Returns a filtered copy of an object with only the specified keys, similar to `_.pick` from lodash / underscore.
 *
 * @param object
 * @param keys
 */
declare function pick<T extends object, U extends keyof T>(object: T, keys: readonly U[]): Pick<T, U>;

export = pick;

````

### Additional Details
 * Last updated: Tue, 07 Nov 2023 09:09:39 GMT
 * Dependencies: none

# Credits
These definitions were written by [Ifiok Jr.](https://github.com/ifiokjr).
