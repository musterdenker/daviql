Daviql
======

A small rails app for quick visualization / export of sql statements / build dashboards



User management is done with help of the devise gem and the :registerable option is disabled in production mode.
Additionally it is possible to switch on basic authentication via config.use_basic_auth see the environment files for details.

To enque a async worker do:

    Sidekiq::Cron::Job.create(name: 'Precache', cron: '*/5 * * * *', class: 'PreCache', args: {query_id: 10})

start worker:

    bundle exec sidekiq

Config
======

Please set the following ENV Variables

    GOOGLE_API_KEY="GOOGLE_API_KEY"
    GOOGLE_CLIENT_ID="GOOGLE_CLIENT_ID"
    GOOGLE_CLIENT_SECRET="GOOGLE_CLIENT_SECRET"
    GOOGLE_OAUTH_DOMAINS="example.com, beispiel.de"
    REDIS_URL="redis://127.0.0.1:6380/15"



Query Syntax for Interpreters
======
> **Note:**

> - Whenever possible / neccassary named attributes are used


Stacked
-------
    select "Bar1" as label,"elemt1" as element, 12 as val
    union
    select "Bar1" as label,"element2" as element, 13 as val
    union
    select "Bar2" as label,"element1" as element, 8 as val
    union
    select "Bar2" as label,"element1" as element, 10 as val
