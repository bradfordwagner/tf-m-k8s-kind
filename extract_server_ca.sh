# Create a temporary file
tmpfile=$(mktemp)

export KUBECONFIG=${tmpfile}
kind get kubeconfig --internal --name ${cluster_name} > ${KUBECONFIG}
# export KUBECONFIG=~/.kube/kind/internal/${cluster_name}
kubectl config view --raw --minify --flatten \
  --output 'jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode \
  > ${KUBECONFIG}_ca
kubectl config view --raw --minify --flatten \
  --output 'jsonpath={.clusters[].cluster.server}' \
  > ${KUBECONFIG}_server

# cleanup files
rm ${KUBECONFIG} ${KUBECONFIG}_ca ${KUBECONFIG}_server
