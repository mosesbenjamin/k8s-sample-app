Pre-requisites: This demo is only compatible with macosx as of this time.
- Ensure homebrew is installed
- Run `sudo vim /etc/hosts`, and add the following to the end of the file with a domain name of your choosing:
  - 127.0.0.1   sampleapp.com
- (Optional) Feel free to change `sampleapp.com` to any other domain name of your choosing:
  - `cd ./chart/values.yaml` and replace the value of `ingressHostName`


Commands to run:
NB: Run the folowing only if the pre-requisites stated above are all satisfied
- Run `make create_kind_cluster_with_registry` to create a kind cluster
- Run the application with `make install_app`
- Run `make clean_up` to clean up

Alternatively,
- Run `make run_end_to_end` to deploy the application
- `make clean_up` to clean up
