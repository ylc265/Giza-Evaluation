For each set of results, I will include:
- raw data: data that can be extracted using the python functions I provide.
- readable data: a csv format of the data summaries (percentile, average, mean error, etc...)
- graph data: graph representation of the readable data

I will also try to make the ipython notebook very readible and comment what each function does.


Results Explanations
Ping Latency:
  - Measure the 10th, 50th, 75th, and 95th percentile latency between each pair of VM's. Includes all vms. Currently, haven't obtained results form us-west-central to north europe and vice versa.
  - Raw data:            ping_latency_raw
  - Graph data:          None (placeholder: ping_latency_graph)
  - Readable data:       ping_latency_readable 

Evaluation 6.3.1: Data Path Tunneling (From US Central Only)
  - Measuring the difference between sending data via rpc call and writing locally to the blob storage and writing directly to the blob storage.
  - Raw data:            no tunneling: azure_storage_latency_raw , tunneling: giza_latency_raw
  - Graph data:          no tunneling: azure_storage_latency_graph_no_tunneling  tunneling: azure_storage_latency_graph_tunneling
  - Readable data:       None (placeholder: azure_storage_latency_readable

This is not done yet. For the tunneling effect, I was able to trace out the difference between the azure local put latency and the cross vm thrift transport latency. As the distance between the VM increases, the thirft transport latency should become the dominating latency. This can be seen in the graph data for tunneling.

For the no-tunneling effect, we wanted to argue that there might be network contention due to traffic being on open internet. However, I am investigating this claim. What I found out is that the increased latency may be due to the sdk not reusing the tcp connect. Each request to the blob store opens a new tcp connection and this is significant when the vm is far from each other. For the graph, I want to trace out the entire storage latency and also the tcp connection latency. Currently, I have one result in the graph data for no tunneling.

Evaluation 6.3.2: Metadata Path with Fast Paxos vs Classical paxos (From US Central Only)
  - Measure the 10th, 50th, 75th, and 95th percentile latency of executing the Metadata path put with Fast Paxos and with Classical Paxos. This is for each of the four configurations.
  - Raw data:            giza_latency_raw
  - Graph data:          giza_latency_graph/metadata/
  - Readable data:       None (placeholder: giza_latency_readable/metadata/

Evaluation 6.3.3 Giza Put Latency (From US Central 2-1 World, 4MB Configuration Only)
  - Measure the 50th percentile with confidence interval of the three iterations of Put, including: Running metadata path 1 concurrenctly with data path + metadata path 2, Running metadata path 1 + metadata path 2 concurrently with data path, and running fast paxos optimization. The baseline is sending the giza data without running the metadata path.
  - Raw data:            max(metadata path 1, data path) + metadata path 2: giza_latency_raw/metadata1_with_data/
                         max(metadata path 1 + metadata path 2 ) + data path: giza_latency_raw/metadata_with_data/
                         giza optimization: giza_latency_raw/2-1-world/4mb/put/
                         baseline: giza_latency_raw/2-1-world/4mb/put/
  - Graph data:          giza_latency_graph/put/
  - Readable data:       None (placeholder: giza_latency_readable_data/put/

Evaluation 6.3.4 Giza Get Latency (From US Central 2-1 World, 4MB Configuration Only)
  - Measure the 50th percentile with confidence interval of the 2 iterations of Get, including: metadata then data and optimistic metadata/data. The baseline is getting the data from storage only.
  - Raw data:            metadata then data: giza_latency_raw/unoptimized_get
                         optimistic: giza_latency_raw/giza_latency_raw/2-1-world/4mb/get/
                         baseline: giza_latency_raw/2-1-world/4mb/get/
  - Graph data:          giza_latency_graph/get/
  - Readable data:       None (placeholder: giza_latency_readable_data/get/

Evaluation 6.4 Comparing the 4 configurations of Giza (2-1-world, 2-1-us, 6-1-world, 6-1-us) with 4mb data. Th
  - Measure the 50th percentile with confidence interval of the configuration with regard to putting 4mb data.
  - Raw data:            giza_latency_raw/
  - Graph data:          giza_latency_graph/configurations/
  - Readable_data:       None (placeholder: giza_latency_readable/configurations/

Evaluation 6.5.1 Comparing Giza with CockroachDB as a blob replication key value store
  - Measure the 50th percentile with confidence interval of storing 256kb, 1mb, 4mb in the 2-1-us configuration
  - Raw data:            giza put: giza_latency_raw/2-1-us/
                         cockroach put: cockroachdb_latency_raw/2-1-us/put/
  - Graph data:          giza_latency_graph/giza_cockroach/put/
  - Readable data:       None (placeholer: tbd)

Evaluation 6.5.2 Comparing Giza with CockraochDB as a metadata key value store
  - Measures the 50th percentile with confidence interval in the 2-1-world configuration
  - Raw data:            giza metadata: giza_latency_raw 
                         cockroach put: cockroachdb_latency_raw/metadata/
  - Graph data:          None
  - Readable data:       None
