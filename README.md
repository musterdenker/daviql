daviql
======

A small rails app for quick visualization / export of sql statements

User management is done with help of the devise gem and the :registerable option is disabled in production mode.
Additionally it is possible to switch on basic authentication via config.use_basic_auth see the environment files for details.

To enque a async worker do:
Sidekiq::Cron::Job.create(name: 'Precache', cron: '*/5 * * * *', class: 'PreCache', args: {query_id: 10})


Todos:
======

 * Adding some NoSql storages
