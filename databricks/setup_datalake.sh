#!/bin/bash

databricks fs rm dbfs:/datalake -r
databricks fs mkdirs dbfs:/datalake
databricks fs mkdirs dbfs:/datalake/code
databricks fs ls dbfs:/datalake