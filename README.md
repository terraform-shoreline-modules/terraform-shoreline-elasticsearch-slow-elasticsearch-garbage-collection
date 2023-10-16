
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Slow Elasticsearch Garbage Collection
---

This incident type refers to a problem that occurs when garbage collection takes a longer time than usual to complete in an Elasticsearch system. Garbage collection is a process used by Elasticsearch to free up memory occupied by unused objects and data structures. When this process takes longer than expected, it can slow down the overall performance of the system, causing delays and potential downtime. This issue can be caused by a variety of factors, including insufficient memory allocation or poor system resource management.

### Parameters
```shell
export ELASTICSEARCH_ENDPOINT="PLACEHOLDER"

export ELASTICSEARCH_LOG_FILE_PATH="PLACEHOLDER"

export HEAP_SIZE="PLACEHOLDER"

export CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check Elasticsearch cluster health and node status
```shell
curl -s -XGET ${ELASTICSEARCH_ENDPOINT}/_cluster/health?pretty
```

### Check Elasticsearch cluster and node stats
```shell
curl -s -XGET ${ELASTICSEARCH_ENDPOINT}/_nodes/stats?pretty
```

### Check Elasticsearch garbage collection stats
```shell
curl -s -XGET ${ELASTICSEARCH_ENDPOINT}/_nodes/stats/jvm?pretty | grep gc
```

### Check Elasticsearch heap usage and garbage collection logs
```shell
curl -s -XGET ${ELASTICSEARCH_ENDPOINT}/_nodes/stats/jvm?pretty | grep -E 'jvm\.(max|mem|gc)\.'
```

### Check Elasticsearch garbage collection logs
```shell
tail -f ${ELASTICSEARCH_LOG_FILE_PATH} | grep --line-buffered 'gc\['
```

## Repair

### Increase the memory allocation for Elasticsearch to ensure that it has enough resources to complete garbage collection efficiently.
```shell


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


```