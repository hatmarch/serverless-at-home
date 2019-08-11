# Adventures in “Domestic Serverless”
serverless-at-home

Serverless programming is popping up everywhere and its popularity is only increasing.  Some have posited that it is the age of “Serverless 2.0”.  But does one have to have to go to a public cloud provider to be able to build a serverless solution?  Is there room for choice and transparency in serverless platforms?  Perhaps most importantly: Can the promise of serverless be harnessed without a credit card?

I had a humble problem that translated well into serverless: having recently installed solar panels, I wanted to drive the color of an LED light based on the amount of excess solar capacity was being generated and see how much I could automate the running of certain devices based on that capacity.  Given that all the data (and “things” required for this) were only available within my own local home network, using public cloud implementations of serverless did not seem feasible.  I decided to see answers existed in the Open Source community.

In this talk, I report on my attempt to build a fully domestic and fully serverless implementation of this solar capacity LED light indicator (powered by disused laptops or whatever compute resources I could find in my home).  My domestic serverless adventure leads me through the use of three different Open Source implementations of serverless computing (and just a little bit of IoT); with absolutely no help from any of those public cloud providers.  

Hands-on observations of the strengths and weaknesses of each implementation abound.  These observations in turn drive insights about the suitability of these projects to larger (or even commercial) workloads and what it might mean for the future of serverless computing.

# Setup

Follow link:https://blog.openshift.com/getting-started-helm-openshift/[these instructions] for getting helm installed on OpenShift up to Step 3

1. Ensure to specify the matching version of helm for the client installed
----
    oc process -f https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.9.0 | oc create -f -
----

2. Execute the Lab 1b workshop instructions up to link:https://github.com/hatmarch/workshop/blob/master/lab1b.md#install-openfaas-with-helm[here]

    1. Instead of this command
----
    kubectl -n kube-system create sa tiller \
    && kubectl create clusterrolebinding tiller \
     --clusterrole cluster-admin \
    --serviceaccount=kube-system:tiller
    
3. You can do this for Openshift for every (oc project) project (openfaas and openfaas-fn)
----
    oc policy add-role-to-user admin "system:serviceaccount:${TILLER_NAMESPACE}:tiller"
4. Then you can run:
----
        helm repo update \
        && helm upgrade openfaas --install openfaas/openfaas \
        --namespace openfaas  \
        --set basic_auth=true \
        --set functionNamespace=openfaas-fn
5. If it fails, you can try again with:
----
    helm delete --purge openfaas

6. To get the gateway url use this command (to set OPENFAAS_URL)
----
    minishift openshift service gateway-external --url

7. Then you can complete the rest of Lab 1b
