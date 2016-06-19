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

Number
-------
    select 3210 as number, "Foobar" as label

Sankey
------
    select "A" as origin, "B" as destination, 10 as number
    union
    select "A"as origin, "C"as destination, 15 as number
    union
    select "B"as origin, "C"as destination, 5 as number
    union
    select "C"as origin, "D"as destination, 2 as number


Gauge
------
    select 12 as value, 100 as max, 1 as min


Pie
------
    select "foo" as label, 12 as number
    union
    select "bar" as label, 21 as number

Graph
------
    select '2015-05-05' as group_column, 12 as custom_name1, 13 as custom_name2
    union
    select '2016-05-05' as group_column, 22 as custom_name1, 23 as custom_name2

The columns custom_name1, ...2, etc are custom and the name is variable as well as the number of columns

Area
------
    select '2015-05-05' as group_column, 12 as custom_name1, 13 as custom_name2
    union
    select '2016-05-05' as group_column, 22 as custom_name1, 23 as custom_name2

The columns custom_name1, ...2, etc are custom and the name is variable as well as the number of columns


Table
-------
    select 1 as foo, 2 as bar, "test" as something
Column names will directly be translated to the column headers of the table.


Stacked
-------
    select '2015-05-05' as group_column, 12 as custom_name1, 13 as custom_name2
    union
    select '2016-05-05' as group_column, 22 as custom_name1, 23 as custom_name2

The columns custom_name1, ...2, etc are custom and the name is variable as well as the number of columns
