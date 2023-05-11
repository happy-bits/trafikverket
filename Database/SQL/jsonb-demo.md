# JSON

JSON stands for JavaScript Object Notation. JSON is an open standard format that consists of key-value pairs.

The main usage of JSON is to transport data between a server and a web application. Unlike other formats, JSON is human-readable text.

JSON is perfect for storing **temporary data**. For example, temporary data can be user-generated data, such as a **submitted form** on a website. JSON can also be used as a data format for any programming language to provide a high level of interoperability.

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-json/


# JSON vs JSONB

The only difference between json & jsonb is their storage:

- json is stored in its plain text format, while
- jsonb is stored in some **binary representation**

Jsonb pros
- If you do a **lot of operations** on the JSON value in PostgreSQL, or use **indexing** on some JSON field, you should use jsonb.
- json operations take significantly more **time** than jsonb (& parsing also needs to be done each time you do some operation at a json typed value)

Jsonb cons
- jsonb usually takes more **disk space** to store than json (sometimes not)
- jsonb takes more **time to build** from its input representation than json

If you only work with the JSON representation in your application, PostgreSQL is only used to store & retrieve this representation, you should use json.

# Why would I even want JSON/JSONB data in my DB?

https://www.cloudbees.com/blog/unleash-the-power-of-storing-json-in-postgres

I still believe that most data is modelled very well using a relational database. The reason for this is because website data tends to be relational. A user makes purchases and leaves reviews, a movie has actors which act in various movies, etc. However, there are use cases where it makes a lot of sense to incorporate a JSON document into your model. For example, it’s perfect when you need to:

**Avoid complicated joins** on data that is siloed or isolated. Think of something like Trello, where they can keep all information about a single card (comments, tasks, etc...) together with the card itself. Having the data denormalized makes it possible to fetch a card and it’s data with a single query.

Maintain data that comes from an **external service** in the **same structure**  and format (as JSON) that it arrived to you as. What endsup in the database is exactly what the API provided. Look at the charge response object from Stripe as an example; it's nested,has arrays, and so on. Instead of trying to normalize this dataacross five or more tables, you can store it as it is (and stillquery against it).

**Avoid transforming data** before returning it via your **JSON API**. Look at this nasty JSON response from the FDA API of adverse drug events. It's deeply nested and has multiple arrays -- to build this data real-time on every request would be incredibly taxing on the system.

# Use case

If you can solve it without json you should probably to that (in general avoid)

A good use case: you get external data, maybe in the form of json, and you don't know exactly how it will look like (the structure). You just want to save it and be able to search the data later.

https://www.2ndquadrant.com/en/blog/postgresql-anti-patterns-unnecessary-jsonhstore-dynamic-columns/

In general it's time to consider hstore, xml, jsonb, etc when you're starting to look at alternatives like **EAV** or **wide tables** where the app **adds columns dynamically**. jsonb is basically the new hstore with a more standard way of representing its data and with nesting capabilities, so it's preferable most of the time.

Use json if your **data won't fit** in the database using a normal relational modelling. If you're choosing between using EAV, **serializing** a Java/Ruby/Python object into a bytea field, or storing a key to look up an **external** structured object somewhere else ... that's when you should be reaching for json fields.

Note that **plain json fields** are also useful - if you're not going to be indexing the json and querying within it, they're usually more compact and faster to send and receive.

A JSON database makes it possible to store data as JSON and provide it to applications in other forms. For example, it can operate as an **in-memory** key-value store for applications that just need quick and easy access. Or, **indexing and querying** can make JSON data appear as a table.

FK constraints cannot be the values of json keys. You can use CHECK constraints though. Or store that particular info in a normal column. 

# Details below...

# EAV

Entity–attribute–value model (EAV) is a data model to encode, in a space-efficient manner, entities where the number of attributes (properties, parameters) that can be used to describe them is potentially vast, but the number that will actually apply to a given entity is relatively modest. Such entities correspond to the mathematical notion of a sparse matrix.

EAV is also known as object–attribute–value model, vertical database model, and open schema.

Example

    Entity	Attribute	Value
    ⟨Patient XYZ, 1/5/98 9:30 AM⟩	⟨Temperature in degrees Fahrenheit⟩	    "102"
    ⟨Patient XYZ, 1/5/98 9:30 AM⟩	⟨Presence of Cough⟩	                    "True"
    ⟨Patient XYZ, 1/5/98 9:30 AM⟩	⟨Type of Cough⟩	                        "With phlegm, yellowish, streaks of blood"
    ⟨Patient XYZ, 1/5/98 9:30 AM⟩	⟨Heart Rate in beats per minute⟩	    "98"

The main advantage of using EAV is its flexibility. Table holding attributes describing an entity is not limited to a specific number of columns, meaning that it doesn't require a schema redesign every time new attribute needs to be introduced


# Misc

More info here: (har inte kollat)
https://www.postgresql.org/docs/current/functions-json.html