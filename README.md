Canvas LMS
======

Canvas is a new, open-source LMS by Instructure Inc. It is released under the
AGPLv3 license for use by anyone interested in learning more about or using
learning management systems.

[Please see our main wiki page for more information](http://github.com/instructure/canvas-lms/wiki)

Installation
=======

Detailed instructions for installation and configuration of Canvas are provided
on our wiki.

 * [Quick Start](http://github.com/instructure/canvas-lms/wiki/Quick-Start)
 * [Production Start](http://github.com/instructure/canvas-lms/wiki/Production-Start)


Translating
=======

Execute (it takes about 5 minutes)

```
bundle exec rake i18n:generate
bundle exec rake tolk:sync
```
Now you can visit http://localhost:3000/tolk to start translating Canvas.

After you done execute
```
bundle exec rake tolk:dump_all[config/locales]
```

and set your translation using
```
config.i18n.default_locale = :sl
```

thats it :).
