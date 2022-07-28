#!/bin/bash

#Set date timestamp
DSTAMP=`date +"%m%d%y"`

#Input Varaibles
export input_file_name=$1
export output_file_name=$2

#Command to strip/extract the required information from provided yaml file
#yq -y '(.items[] |= (del(.status) | .metadata |={name, namespace, labels})) | del(.metadata) | del(.kind)' ${input_file_name} > intrim_deployment-${DSTAMP}.yaml
#yq -y '.items[0, 3, 4, 5] |= (del(.metadata) | del(.spec))' ${input_file_name} > intrim_deployment-${DSTAMP}.yaml
#yq -y '.items[] |= (del(.metadata.labels."app.kubernetes.io/component") | del(.metadata.labels."app.kubernetes.io/instance") | del(.metadata.labels."app.kubernetes.io/name") | del(.metadata.labels."app.kubernetes.io/part-of") | del(.metadata.labels."app.openshift.io/runtime-version"))' intrim_deployment-${DSTAMP}.yaml > ${output_file_name}

#yq -y '(.items[] |= (del(.status) | del(.metadata.labels."app.kubernetes.io/component") | del(.metadata.labels."app.kubernetes.io/instance") | del(.metadata.labels."app.kubernetes.io/name") | del(.metadata.labels."app.kubernetes.io/part-of") | del(.metadata.labels."app.openshift.io/runtime-version") | .metadata |={name, namespace, labels})) | del(.metadata) | del(.kind)' ${input_file_name} > intrim_deployment-${DSTAMP}.yaml

#yq -y '.items[0, 3, 4, 5] |= (del(.metadata) | del(.spec) | del(.apiVersion) | del(.kind)) | del(.metadata) | del(.kind)' ${input_file_name} > intrim_deployment-${DSTAMP}.yaml

yq -y '.items[] |= (del(.status) | del(.metadata.annotations) | del(.metadata.creationTimestamp) | del(.metadata.resourceVersion) | del(.metadata.uid) | del(.metadata.labels."app.kubernetes.io/component") | del(.metadata.labels."app.kubernetes.io/instance") | del(.metadata.labels."app.kubernetes.io/name") | del(.metadata.labels."app.kubernetes.io/part-of") | del(.metadata.labels."app.openshift.io/runtime-version") | del(.metadata.labels."app.openshift.io/runtime-namespace") | del(.spec.clusterIP) | del(.spec.clusterIPs) | del(.spec.ipFamilies) | del(.spec.ipFamilyPolicy))' ${input_file_name} > intrim_deployment-${DSTAMP}.yaml

yq -y '.items[0, 3, 4, 5] |= (del(.metadata) | del(.spec) | del(.apiVersion) | del(.kind))' intrim_deployment-${DSTAMP}.yaml > ${output_file_name}

sed -i '/{}/d' ${output_file_name}

exit 0
