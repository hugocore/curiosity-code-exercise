[![Build Status](https://travis-ci.org/hugocore/curiosity-code-exercise.svg?branch=master)](https://travis-ci.org/hugocore/curiosity-code-exercise)
[![Maintainability](https://api.codeclimate.com/v1/badges/57d6a14eb1a0c0ee7248/maintainability)](https://codeclimate.com/github/hugocore/curiosity-code-exercise/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/57d6a14eb1a0c0ee7248/test_coverage)](https://codeclimate.com/github/hugocore/curiosity-code-exercise/test_coverage)

# Curiosity - The tale of a warehouse robot

Imagine that this is a project for NASA. They have high standards and strict safety requirements. This test should take between 1 to 2 hours to complete. If it takes longer, don't worry. We're only testing your skills, not your delivery speed.

# Usage

Run the project with Docker:

```
docker-compose build
docker-compose run --rm web rake db:reset
docker-compose run --rm web rspec
```

Or, locally by creating an `.env` file with:

```
DB_HOST=...
DB_USER=...
DB_PASSWORD=...
```

And then running:

```
bundle install
RAILS_ENV=test rake db:create
rspec
```

# Code Quality

- Run rspec via Spring to speed up preloading with:

```
docker-compose run --rm web bash
bundle exec spring rspec
```

- Check test coverage locally:

```
open coverage/index.html
```

- A git commit hook runs Rubocop to validate changes, to skip it run:

```
SKIP=RuboCop git commit
```

- Travis makes sure the repo keeps building:

https://travis-ci.org/github/hugocore/curiosity-code-exercise

- Coveralls shows test coverage at:

https://coveralls.io/github/hugocore/curiosity-code-exercise

- Codeclimate checks code quality for every build at:

https://codeclimate.com/github/hugocore/curiosity-code-exercise

# Background

We have installed a robot in our Mars warehouse and now we need to be able to send it commands to control it. We need you to implement the control mechanism and expose it via an RESTful API.

For convenience the robot moves along a grid in the roof of the warehouse and we have made sure that all of our warehouses are built so that the dimensions of the grid are 10 by 10. We've also made sure that all our warehouses are aligned along north-south and east-west axes.

All of the commands to the robot consist of a single capital letter and different commands are dilineated by whitespace.

## Part One

The robot should accept the following commands:

* N move north
* W move west
* E move east
* S move south

### Example command sequences

The command sequence: "N E S W" will move the robot in a full square, returning it to where it started.

If the robot starts in the south-west corner of the warehouse then the following commands will move it to the middle of the warehouse.

"N E N E N E N E"

# Requirements

* (Req 1.) Create a way to send a series of commands to the robot
* (Req 2.) Make sure that the robot doesn't try to move outside the warehouse
* (Req 3.) Ensure that the robot's position is persisted (in the database)

## Part two

The robot is equipped with a lifting claw which can be used to move crates around the warehouse. We track the locations of all the crates in the warehouse.

Model the presence of crates in the warehouse. Initially one is in the centre and one in the north-east corner.

Extend the robot's commands to include the following:

* (Req 4.) G grab a crate and lift it
* (Req 5.) D drop a crate gently to the ground

There are some rules about moving crates:

* (Req 6.) The robot should not try and lift a crate if it already lifting one
* (Req 7.) The robot should not lift a crate if there is not one present
* (Req 8.) The robot should not drop a crate on another crate!

# Assumptions

- If given an invalid cardinal direction, the robot stays in the same place
