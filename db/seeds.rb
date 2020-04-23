# frozen_string_literal: true

# If the robot starts in the south-west corner of the warehouse then the following
# commands will move it to the middle of the warehouse.
# Model the presence of crates in the warehouse. Initially one is in the
# centre and one in the north-east corner.

warehouse = Warehouse.find_or_create_by!(
  width: 10,
  length: 10
)

Crate.find_or_create_by!(
  x: 5,
  y: 5,
  warehouse: warehouse
)

Crate.find_or_create_by!(
  x: 10,
  y: 10,
  warehouse: warehouse
)

Robot.find_or_create_by!(
  x: 1,
  y: 1,
  warehouse: warehouse
)
