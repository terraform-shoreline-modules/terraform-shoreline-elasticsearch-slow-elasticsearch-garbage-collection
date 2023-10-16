terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "slow_elasticsearch_garbage_collection" {
  source    = "./modules/slow_elasticsearch_garbage_collection"

  providers = {
    shoreline = shoreline
  }
}