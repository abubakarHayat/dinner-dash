# DinnerDashV2
  Dinner Dash V2 is a web application made in ruby on rails. It allows one to manage Restaurants and its items, customers' cart, their orders etc.

  Following are some details that would help you to get this app up and running in your system.


#### Ruby version
ruby 2.7

#### Rails version
rails 5.2

### System dependencies

#### Configuration
* Make sure to have ruby installed. You can check by running following command:
```console
foo@bar:~$ ruby -v
```
* Make sure to have rails installed as well.
```console
foo@bar:~$ rails -v
```
* Install and enable postgresql.
```console
foo@bar:~$ sudo yum install postgresql-server postgresql-contrib
```
* Create postgres database cluster.
```console
foo@bar:~$ sudo postgresql-setup initdb

```

* Install necessary gems.
```console
foo@bar:~$ bundle install

```
* Run following data to initialize DB with seed data.
```console
foo@bar:~$ rails db:seed

```

* Run Rails server.
```console
foo@bar:~$ rails s

```
