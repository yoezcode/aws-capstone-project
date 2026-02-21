/*
Gets the list of available availability zones
from AWS for the current region.
Used to avoid hardcoding AZ names.
*/

data "aws_availability_zones" "available" {}