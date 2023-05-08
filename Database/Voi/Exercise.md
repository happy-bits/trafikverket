# Voi - SQL Modeling

## Intro

You're going to model a database for Voi. Voi owns thousands of scooters and earns money by renting the scooters to customers.

Below you see notes from your meeting with Voi. 

Create an ER-diagram for their business using **lucid charts**. Then create a database with appropriate primary keys, datatypes and relations. 

Everything is about what to **store**. You do not need to think about the app, the GUI or the functionality. 

## Notes 

We have many customers that take a scooter for a ride. We need to keep track of all of our scooters, where they are right now and who is driving the scooter. 

Right now we have three types of scooters with different battery power and top speed. One of the scooters was released this year and the others are two years old. They all have different article numbers.

To see which places that are popular we want to know the start and end position of each ride. As well as the time. And the battery level right now for a scooter.

Using the app the customer fills in his first name, last name, email and phone number. Some customers are "Gold"-members with a 20% discount. Some are "Silver"-member with 15% discount. Maybe we will add more membership later.

When a customer has finished a trip he can rate his experience using stars (1-5). We need to keep track of how much we charge the customer for the trip. And if it's paid or not.

Every customer can login with username and password. Within the app the customer can add his credit cards. The user should be able to choose which card he prefers. We need to store the usual card info (number, expires etc.)

It would be nice if someone from accounting could see how many scooters we bought in 2021 and what that cost.

Some scooters are in bad shape and might need repair. There are some common problems many scooters have, e.g problems with wheel, battery, lights...  We want to know which problems a scooter has.

## Hints

Look for the following in the text:
- People
- Things
- Places
- Events

Sometimes it helps to add rows in your database to see if it's setup right

