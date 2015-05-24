# beachhead

BeachHead is a set of tools for determining the viability of a new username.

Currently it checks if the handle is available on GitHub and Twitter, and can also check domain availability.

Usage
-----
* social.rb considers each argument a handle you want to check.
* import-domains.rb will fetch a list of current TLDs and import them into a Redis store.
* domains.rb will search for available domains. Rather than searching *all* top-level domains, it expects to find a Redis set at `tld:interest`, containing and TLDs you are interested in checking.

License
-------
[MIT](https://tldrlegal.com/license/mit-license)

Contributors
------------
* [Chris Olstrom](https://colstrom.github.io/) | [e-mail](mailto:chris@olstrom.com) | [Twitter](https://twitter.com/ChrisOlstrom)
