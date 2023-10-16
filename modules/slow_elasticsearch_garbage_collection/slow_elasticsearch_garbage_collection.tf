resource "shoreline_notebook" "slow_elasticsearch_garbage_collection" {
  name       = "slow_elasticsearch_garbage_collection"
  data       = file("${path.module}/data/slow_elasticsearch_garbage_collection.json")
  depends_on = [shoreline_action.invoke_update_elasticsearch_heap_size_config]
}

resource "shoreline_file" "update_elasticsearch_heap_size_config" {
  name             = "update_elasticsearch_heap_size_config"
  input_file       = "${path.module}/data/update_elasticsearch_heap_size_config.sh"
  md5              = filemd5("${path.module}/data/update_elasticsearch_heap_size_config.sh")
  description      = "Increase the memory allocation for Elasticsearch to ensure that it has enough resources to complete garbage collection efficiently."
  destination_path = "/tmp/update_elasticsearch_heap_size_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_elasticsearch_heap_size_config" {
  name        = "invoke_update_elasticsearch_heap_size_config"
  description = "Increase the memory allocation for Elasticsearch to ensure that it has enough resources to complete garbage collection efficiently."
  command     = "`chmod +x /tmp/update_elasticsearch_heap_size_config.sh && /tmp/update_elasticsearch_heap_size_config.sh`"
  params      = ["CONFIG_FILE","HEAP_SIZE"]
  file_deps   = ["update_elasticsearch_heap_size_config"]
  enabled     = true
  depends_on  = [shoreline_file.update_elasticsearch_heap_size_config]
}

