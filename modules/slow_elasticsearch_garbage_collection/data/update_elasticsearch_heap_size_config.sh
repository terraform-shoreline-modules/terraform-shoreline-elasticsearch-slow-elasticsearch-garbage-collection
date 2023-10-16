

#!/bin/bash



# set variables

ELASTICSEARCH_HEAP_SIZE=${HEAP_SIZE}

ELASTICSEARCH_CONFIG_FILE=${CONFIG_FILE}



# backup existing config file

cp $ELASTICSEARCH_CONFIG_FILE $ELASTICSEARCH_CONFIG_FILE.bak



# update Elasticsearch heap size in config file

sed -i "s/-Xms[0-9]*m -Xmx[0-9]*m/-Xms${ELASTICSEARCH_HEAP_SIZE}m -Xmx${ELASTICSEARCH_HEAP_SIZE}m/g" $ELASTICSEARCH_CONFIG_FILE



# restart Elasticsearch service

systemctl restart elasticsearch.service